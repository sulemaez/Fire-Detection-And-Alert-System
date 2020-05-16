package com.eds.eds.validators;


import com.eds.eds.models.User;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component("beforeCreateUserValidator")
public class UserValidator implements Validator {
    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        User user = (User)target;

        if(user.getName() == null || user.getName().trim().equals("")){
            errors.rejectValue("name","field.empty");
        }

        if(user.getPhone() == null || user.getPassword().trim().equals("")){
            errors.rejectValue("phone","field.empty");
        }

        if(user.getTypeId() == null || user.getTypeId().trim().equals("")){
            errors.rejectValue("typeId","field.empty");
        }

    }
}
