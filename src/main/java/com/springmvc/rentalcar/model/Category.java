package com.springmvc.rentalcar.model;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "categories")
public class Category implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCategory")
    private int id;

    @NotEmpty(message="{NotEmpty.category.typology}")
    @Column(name = "typology")
    private String typology;

    @OneToMany(mappedBy="category", cascade = CascadeType.DETACH)
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Vehicle> vehicles;

    public Category() {}

    public Category(String typology) {
        this.typology = typology;
    }

    public Category (int id, String typology) {
        this.id = id;
        this.typology = typology;
    }

    public Category(int id, String typology, List<Vehicle> vehicles) {
        this.id = id;
        this.typology = typology;
        this.vehicles = vehicles;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTypology() {
        return typology;
    }

    public void setTypology(String typology) {
        this.typology = typology;
    }

    public List<Vehicle> getVehicles() { return vehicles; }

    public void setVehicles(List<Vehicle> vehicles) { this.vehicles = vehicles; }

    public void addVehicle(Vehicle vehicle) {
        vehicles.add(vehicle);
    }

    @Override
    public String toString() {
        return "Category [id=" + id + ", typology=" + typology + "]";
    }
}
