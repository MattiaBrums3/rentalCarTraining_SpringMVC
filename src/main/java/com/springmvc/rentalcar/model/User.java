package com.springmvc.rentalcar.model;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "users")
public class User implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idUser")
    private int id;

    @NotEmpty(message="{NotEmpty.user.name}")
    @Column(name = "name")
    private String name;

    @NotEmpty(message="{NotEmpty.user.surname}")
    @Column(name = "surname")
    private String surname;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "dateOfBirth")
    private Date dateOfBirth;

    @NotEmpty(message="{NotEmpty.user.fiscalCode}")
    @Column(name = "fiscalCode")
    private String fiscalCode;

    @Column(name = "superUser",columnDefinition = "TINYINT")
    private Boolean superUser;

    @NotEmpty(message="{NotEmpty.user.username}")
    @Column(name = "username")
    private String username;

    @NotEmpty(message="{NotEmpty.user.password}")
    @Column(name = "password")
    private String password;

    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER, cascade = CascadeType.DETACH)
    List<Rental> rentals;

    public User() {}

    public User(String name, String surname, Date dateOfBirth, String fiscalCode, Boolean superUser, String username, String password) {
        this.name = name;
        this.surname = surname;
        this.dateOfBirth = dateOfBirth;
        this.fiscalCode = fiscalCode;
        this.superUser = superUser;
        this.username = username;
        this.password = password;
    }

    public User(int id, String name, String surname, Date dateOfBirth, String fiscalCode, Boolean superUser, String username, String password) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.dateOfBirth = dateOfBirth;
        this.fiscalCode = fiscalCode;
        this.superUser = superUser;
        this.username = username;
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getFiscalCode() {
        return fiscalCode;
    }

    public void setFiscalCode(String fiscalCode) {
        this.fiscalCode = fiscalCode;
    }

    public Boolean getSuperUser() {
        return superUser;
    }

    public void setSuperUser(Boolean superUser) {
        this.superUser = superUser;
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

    public List<Rental> getRentals() { return rentals; }

    public void setRentals(List<Rental> rentals) { this.rentals = rentals; }

    @Override
    public String toString() {
        return "User [id=" + id + ", name=" + name + ", surname=" + surname + ", dateOfBirth=" + dateOfBirth + ", fiscalCode=" + fiscalCode + ", superUser=" + superUser + ", username=" + username + ", password=" + password + "]";
    }
}
