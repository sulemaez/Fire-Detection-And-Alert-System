package com.eds.eds.validators;

import com.eds.eds.models.UserType;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component("beforeCreateUserTypeValidator")
public class UserTypeValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return UserType.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        UserType userType = (UserType)target;

        if(userType.getName() == null || userType.getName().trim().equals("")){
            errors.rejectValue("name","field.empty");
        }


        if(userType.getDescription() == null || userType.getDescription().trim().equals("")){
            errors.rejectValue("description","field.empty");
        }

    }
}