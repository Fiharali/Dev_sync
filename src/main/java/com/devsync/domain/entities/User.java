package com.devsync.domain.entities;

import com.devsync.domain.enums.UserType;
import jakarta.persistence.*;


@Entity
@Table(name = "users")

public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "prenom")
    private String prenom;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "tokens")
    private int tokens;

    @Column(name = "username")
    private String username;


    @Enumerated(EnumType.STRING)
    @Column(name = "usertype")
    private UserType userType;

    public User() {}

    public User(Long id, String name, String prenom, String email, String password, String username , UserType userType,int tokens) {
        this.id = id;
        this.name = name;
        this.prenom = prenom;
        this.email = email;
        this.password = password;
        this.username = username;
        this.userType = userType;
        this.tokens = tokens;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public UserType getUserType() {
        return userType;
    }

    public void setUserType(UserType userType) {
        this.userType = userType;
    }

    public int getTokens() {
        return tokens;
    }

    public void setTokens(int tokens) {
        this.tokens = tokens;
    }






}