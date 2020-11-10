package com.eds.eds.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;



@Service
public class SendMail {

    @Autowired
    private JavaMailSender javaMailSender;


    public void send(String email,String password){
        SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
        simpleMailMessage.setTo(email);
        simpleMailMessage.setSubject("Emergency Detection System (EDS) Credentials");
        simpleMailMessage.setText("PASSWORD : "+password);
        javaMailSender.send(simpleMailMessage);
    }


}
