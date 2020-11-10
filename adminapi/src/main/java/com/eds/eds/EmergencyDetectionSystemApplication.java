package com.eds.eds;

import com.eds.eds.models.County;
import com.eds.eds.services.InitService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;


@SpringBootApplication
@EnableWebSecurity
public class EmergencyDetectionSystemApplication implements CommandLineRunner {

    @Autowired
    InitService initService;

    public static void main(String[] args) {
        SpringApplication.run(EmergencyDetectionSystemApplication.class, args);
    }

    @Bean
    public ResourceBundleMessageSource messageSource() {
        ResourceBundleMessageSource source = new ResourceBundleMessageSource();
        source.setBasename("validation");
        source.setCacheSeconds(3600); // Refresh cache once per hour.
        return source;
    }


    @Override
    public void run(String... args) throws Exception {
          initService.intiCounties();
          initService.initUser();
    }
}
