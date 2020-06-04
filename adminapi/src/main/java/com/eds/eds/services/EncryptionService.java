package com.eds.eds.services;



import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class EncryptionService {

     private BCryptPasswordEncoder bCryptPasswordEncoder;

    public EncryptionService(){
        bCryptPasswordEncoder = new BCryptPasswordEncoder();
    }

    public String hashPassword(String password){
        return bCryptPasswordEncoder.encode(password);
    }
}
