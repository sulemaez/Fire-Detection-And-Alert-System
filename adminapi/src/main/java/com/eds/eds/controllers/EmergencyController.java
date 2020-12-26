package com.eds.eds.controllers;

import com.eds.eds.models.Camera;
import com.eds.eds.models.Emergency;
import com.eds.eds.models.Loc;
import com.eds.eds.models.User;
import com.eds.eds.redis.RedisMessagePublisher;
import com.eds.eds.repositories.CameraRepository;
import com.eds.eds.repositories.EmergencyRepository;
import com.eds.eds.repositories.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
@RestController
public class EmergencyController {

    @Autowired
    private CameraRepository cameraRepository;

    @Autowired
    private RedisMessagePublisher publisher;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmergencyRepository emergencyRepository;

    @RequestMapping(method = RequestMethod.POST, value = "/alert")
    public @ResponseBody String getAlert(@RequestBody String alert) throws Exception {
       String camName = alert.split("=")[1].trim();
        System.out.println("CAMERA "+camName);
       Camera camera = cameraRepository.findByName(camName);
       String coordinates = camera.getCoordinates();
        // Create ObjectMapper object.
        ObjectMapper mapper = new ObjectMapper();
        mapper.enable(SerializationFeature.INDENT_OUTPUT);

        List < String > users = new ArrayList < String> ();
        HashMap<String , Object > map = new HashMap<>();
        map.put("camera",camName);

       userRepository.findAll().forEach(user -> {
           if(user.getLocation() != null && !user.getLocation().equals("") && Loc.calculateDistance(coordinates,user.getLocation())){
               users.add(user.getUsername());
           }
       });
        map.put("users",users);
        // Seri alize Object to JSON.
        String json = mapper.writeValueAsString(map);
        System.out.println(json);
        publisher.publish(json);
        Emergency emergency = new Emergency();
        emergency.setLocationId(camera.getLocationId());
        emergency.setTime(LocalDateTime.now());

        emergencyRepository.save(emergency);
        return alert;
    }

    @RequestMapping(method = RequestMethod.POST, value = "/location")
    public ResponseEntity<?> getLocation(@RequestBody String coordinates, @RequestParam String username) throws Exception {
        User user = userRepository.findByUsername(username.trim()).get();

        user.setLocation(coordinates);
        userRepository.save(user);
        return ResponseEntity.ok("set");
    }



}
