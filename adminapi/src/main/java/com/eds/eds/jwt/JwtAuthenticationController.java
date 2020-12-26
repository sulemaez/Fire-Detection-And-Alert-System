package com.eds.eds.jwt;

import com.eds.eds.models.User;
import com.eds.eds.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin
public class JwtAuthenticationController {
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    private JwtUserDetailsService userDetailsService;
    @Autowired
    private UserRepository userRepository;

    @RequestMapping(value = "/authenticate", method = RequestMethod.POST)
    public ResponseEntity<?> createAuthenticationToken(@RequestBody User user) throws Exception {
        String username = getUserName(user);
        authenticate(username, user.getPassword());
        final UserDetails userDetails = userDetailsService
                .loadUserByUsername(username);

        user = userRepository.findByUsername(username).get();
        if(!user.isAdmin()){
            throw new Exception("INVALID_CREDENTIALS");
        }
        final String token = jwtTokenUtil.generateToken(userDetails);
        return ResponseEntity.ok(new JwtResponse(token,user));
    }

    @RequestMapping(value = "/authenticate/user", method = RequestMethod.POST)
    public ResponseEntity<?> createAuthenticationTokenUser(@RequestBody User user) throws Exception {
        String username = getUserName(user);
        System.out.println("USERNAME");
        System.out.println(username);
        authenticate(username, user.getPassword());
        final UserDetails userDetails = userDetailsService
                .loadUserByUsername(username);
        user = userRepository.findByUsername(username).get();
        final String token = jwtTokenUtil.generateToken(userDetails);
        return ResponseEntity.ok(new JwtResponse(token,user));
    }

    private String getUserName(User user) throws Exception{
        try {
            if(user.getEmail() != null && !user.getEmail().equalsIgnoreCase("")){
               return userRepository.findByEmail(user.getEmail()).get().getUsername();
            }else if(user.getPhone() != null && !user.getPhone().equals("")){
                return userRepository.findByPhone(user.getPhone()).get().getUsername();
            }else if (user.getUsername() != null && !user.getUsername().equalsIgnoreCase("")){
                return user.getUsername();
            }
        }catch (Exception e){
            throw new Exception("INVALID_CREDENTIALS", e);
        }
        return "";
    }

    private void authenticate(String username, String password) throws Exception {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        } catch (DisabledException e) {
            throw new Exception("USER_DISABLED", e);
        } catch (BadCredentialsException e) {
            throw new Exception("INVALID_CREDENTIALS", e);
        }
    }
}