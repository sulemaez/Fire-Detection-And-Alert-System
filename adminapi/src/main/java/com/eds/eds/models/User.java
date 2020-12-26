package com.eds.eds.models;


import org.springframework.data.annotation.Id;


public class User {

    @Id
    private String id;

    private String name;
    private String phone;
    private String email;
    private String typeId;
    private boolean admin;
    private String username;
    private String password;
    private String location;

    public User(String id, String name, String phone, String email, String typeId, boolean admin, String username, String password) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.typeId = typeId;
        this.admin = admin;
        this.username = username;
        this.password = password;
    }

    public User() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
