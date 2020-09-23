package com.eds.eds.services;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class EncryptionService {

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public EncryptionService(){

    }

    public String hashPassword(String password){
        return bCryptPasswordEncoder.encode(password);
    }
}
