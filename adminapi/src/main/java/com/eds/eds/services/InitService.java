package com.eds.eds.services;

import com.eds.eds.models.County;
import com.eds.eds.models.User;
import com.eds.eds.repositories.CountyRepository;
import com.eds.eds.repositories.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class InitService {
    @Autowired
    private ResourceLoader resourceLoader;

    @Autowired
    private CountyRepository countyRepository;

    @Autowired
    private UserRepository userRepository;

    public void  intiCounties(){
        try{
            List<County> counties = countyRepository.findAll();
            if(counties.isEmpty()){
                Resource resource = resourceLoader.getResource("classpath:data/counties.json");
                InputStream inputStream = resource.getInputStream();
                //create ObjectMapper instance
                //create ObjectMapper instance
                ObjectMapper objectMapper = new ObjectMapper();

                //convert json file to map
                List<Map<?, ?>> list = objectMapper.readValue(inputStream, List.class);
                inputStream.close();

                list.forEach( map -> {
                    //iterate over map entries and print to console
                    for (Map.Entry<?, ?> entry : map.entrySet()) {
                        County county = new County();
                        county.setName(entry.getValue().toString());
                        countyRepository.save(county);
                    }
                });
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public void initUser(){
        System.out.println("INIT USER USRE");
       Optional<User> user = userRepository.findByUsername("admin");
       if(user.isEmpty()){
           System.out.println("save");
           User admin = new  User();
           admin.setUsername("admin");
           admin.setName("EDS ADMIN");
           admin.setAdmin(true);
           admin.setEmail("admin@eds.com");
           admin.setPassword("$2a$10$OWI0ldJvVG5d.vn00RVM0uhbusLfmZuW9tcyaqxu8QPqeiIqBG4Qe");
           userRepository.save(admin);
       }

    }
}
