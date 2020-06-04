package com.eds.eds.validators;


import com.eds.eds.models.Emergency;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component("beforeCreateEmergencyValidator")
public class EmergencyValidator implements Validator{

    @Override
    public boolean supports(Class<?> clazz) {
        return clazz.equals(Emergency.class);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Emergency emergency = (Emergency)target;
        if(emergency.getTypeId() == null ||emergency.getTypeId().trim().equals("")){
            errors.rejectValue("typeId", "field.empty");
        }

        if(emergency.getLocationId() == null || emergency.getLocationId().trim().equals("")){
            errors.rejectValue("locationId", "field.empty");
        }
        if(emergency.getTime() == null){
            errors.rejectValue("locationId", "field.empty");
        }
    }
}

