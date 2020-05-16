package com.eds.eds.validators;

import com.eds.eds.models.Camera;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component("beforeCreateCameraValidator")
public class CameraValidator implements Validator{

    @Override
    public boolean supports(Class<?> clazz) {
        return clazz.equals(Camera.class);
    }

    @Override
    public void validate(Object target, Errors errors) {
       Camera camera = (Camera)target;
       if(camera.getName() == null || camera.getName().trim().equals("")){
           errors.rejectValue("name", "field.empty");
       }

       if(camera.getLocationId() == null || camera.getLocationId().trim().equals("")){
           errors.rejectValue("locationId", "field.empty");
       }
    }
}
