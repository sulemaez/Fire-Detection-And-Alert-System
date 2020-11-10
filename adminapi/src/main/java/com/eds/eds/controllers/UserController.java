package com.eds.eds.controllers;


import com.eds.eds.models.User;
import com.eds.eds.repositories.UserRepository;
import com.eds.eds.services.EncryptionService;
import com.eds.eds.services.SendMail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@RepositoryRestController
public class  UserController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private SendMail sendMail;

    @Autowired
    private EncryptionService encryptionService;

    @RequestMapping(method = RequestMethod.POST, value = "/users")
    public @ResponseBody User addUsers(@RequestBody  User user) throws Exception {
        if(userRepository.findByPhone(user.getPhone().trim()).isPresent()){
            throw new Exception("Phone already taken");
        }


        if(userRepository.findByEmail(user.getEmail().trim()).isPresent()){
            throw new Exception("Email already taken");
        }

        String pass = encryptionService.generatePassword();
        String hashPass = encryptionService.hashPassword(pass);
        user.setPassword(hashPass);
        userRepository.save(user);

        sendMail.send(user.getEmail(),pass);
        return user;
    }

}