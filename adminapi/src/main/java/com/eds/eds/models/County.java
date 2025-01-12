package com.eds.eds.models;


import org.springframework.data.annotation.Id;


public class County {

    @Id
    private String id;
    private String name;

    public County(String id, String name) {
        this.id = id;
        this.name = name;
    }

    public County() {
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
}
