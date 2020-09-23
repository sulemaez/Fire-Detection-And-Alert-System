package com.eds.eds.controllers;


import com.eds.eds.models.User;
import com.eds.eds.repositories.UserRepository;
import com.eds.eds.services.EncryptionService;
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
    private EncryptionService encryptionService;

    @RequestMapping(method = RequestMethod.POST, value = "/users")
    public @ResponseBody User addUsers(@RequestBody  User user) {
        String pass = encryptionService.hashPassword(user.getPassword());
        user.setPassword(pass);
        userRepository.save(user);
        return user;
    }

}