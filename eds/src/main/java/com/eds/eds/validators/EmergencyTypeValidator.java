package com.eds.eds.validators;


import com.eds.eds.models.Emergency;
import com.eds.eds.models.EmergencyType;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component("beforeCreateEmergencyTypeValidator")
public class EmergencyTypeValidator implements Validator{

    @Override
    public boolean supports(Class<?> clazz) {
        return clazz.equals(EmergencyType.class);
    }

    @Override
    public void validate(Object target, Errors errors) {
        EmergencyType emergencyType = (EmergencyType) target;
        if(emergencyType.getName() == null || emergencyType.getName().trim().equals("")){
            errors.rejectValue("name", "field.empty");
        }

        if(emergencyType.getDescription() == null || emergencyType.getDescription().trim().equals("")){
            errors.rejectValue("locationId", "field.empty");
        }

    }
}