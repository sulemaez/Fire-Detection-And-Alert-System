package com.eds.eds;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.ResourceBundleMessageSource;

@SpringBootApplication
public class EmergencyDetectionSystemApplication {

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
}
