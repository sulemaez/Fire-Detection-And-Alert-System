package com.eds.eds.configs;


import com.eds.eds.models.*;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;

@Configuration
public class RepositoryConfig implements RepositoryRestConfigurer {

    @Override
    public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config) {
        config.exposeIdsFor(MainLocation.class);
        config.exposeIdsFor(Camera.class);
        config.exposeIdsFor(Emergency.class);
        config.exposeIdsFor(EmergencyType.class);
        config.exposeIdsFor(Location.class);
        config.exposeIdsFor(User.class);
        config.exposeIdsFor(UserType.class);
    }
}