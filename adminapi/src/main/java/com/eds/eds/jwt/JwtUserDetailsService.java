package com.eds.eds.jwt;

import java.util.ArrayList;
import java.util.Optional;

import com.eds.eds.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class JwtUserDetailsService implements UserDetailsService {
    @Autowired
    UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<com.eds.eds.models.User> foundUserOptional = userRepository.findByUsername(username);

        if (foundUserOptional.isPresent()) {
            com.eds.eds.models.User foundUser = foundUserOptional.get();
            return new User(foundUser.getUsername(), foundUser.getPassword(),
                    new ArrayList<>());
        } else {
            throw new UsernameNotFoundException("User not found with username: " + username);
        }
    }
}