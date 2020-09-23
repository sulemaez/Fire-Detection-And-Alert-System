package com.eds.eds.validators;

import com.eds.eds.models.Location;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component("beforeCreateLocationValidator")
public class LocationValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return Location.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
         Location location = (Location)target;

         if(location.getName() == null || location.getName().trim().equals("")){
             errors.rejectValue("name","field.empty");
         }


    }
}
