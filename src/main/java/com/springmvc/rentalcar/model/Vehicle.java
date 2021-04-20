package com.springmvc.rentalcar.model;

import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "vehicles")
public class Vehicle implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idVehicle")
    private int id;

    @NotEmpty(message="{NotEmpty.vehicle.model}")
    @Column(name = "model")
    private String model;

    @NotEmpty(message="{NotEmpty.vehicle.manufacturer}")
    @Column(name = "manufacturer")
    private String manufacturer;

    @NotEmpty(message="{NotEmpty.vehicle.licensePlate}")
    @Column(name = "licensePlate")
    private String license_plate;

    @Column(name = "yearOfRegistration")
    private int year_of_registration;

    @ManyToOne
    @JoinColumn(name="idCategory")
    private Category category;

    /*@OneToMany(mappedBy = "vehicle", fetch = FetchType.EAGER, cascade = CascadeType.DETACH)
    List<Rental> rentals;*/

    public Vehicle() {}

    public Vehicle(String model, String manufacturer, String license_plate, int year_of_registration, Category category) {
        this.model = model;
        this.manufacturer = manufacturer;
        this.license_plate = license_plate;
        this.year_of_registration = year_of_registration;
        this.category = category;
    }

    public Vehicle(int id, String model, String manufacturer, String license_plate, int year_of_registration, Category category) {
        this.id = id;
        this.model = model;
        this.manufacturer = manufacturer;
        this.license_plate = license_plate;
        this.year_of_registration = year_of_registration;
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getLicensePlate() {
        return license_plate;
    }

    public void setLicensePlate(String license_plate) {
        this.license_plate = license_plate;
    }

    public int getYearOfRegistration() {
        return year_of_registration;
    }

    public void setYearOfRegistration(int year_of_registration) {
        this.year_of_registration = year_of_registration;
    }

    public Category getCategory() { return category; }

    public void setCategory(Category category) { this.category = category; }

    /*public List<Rental> getRentals() { return rentals; }

    public void setRentals(List<Rental> rentals) { this.rentals = rentals; }*/

    @Override
    public String toString() {
        return "Vehicle [id=" + id + ", model=" + model + ", manufacturer=" + manufacturer + ", licensePlate=" + license_plate + ", yearOfRegistration=" + year_of_registration + "]";
    }
}
