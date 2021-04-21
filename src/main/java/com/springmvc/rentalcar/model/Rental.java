package com.springmvc.rentalcar.model;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "rentals")
public class Rental implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idRental")
    private int id;

    @ManyToOne
    @JoinColumn(name = "idUser")
    private User user;

    @ManyToOne
    @JoinColumn(name = "idVehicle")
    private Vehicle vehicle;

    @NotNull(message="{NotNull.rental.dateOfStart}")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "dateOfStart")
    private Date dateOfStart;

    @NotNull(message="{NotNull.rental.dateOfEnd}")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "dateOfEnd")
    private Date dateOfEnd;

    @Column(name = "approved", columnDefinition = "TINYINT")
    private Boolean approved;

    public Rental() {}

    public Rental(User user, Vehicle vehicle, Date dateOfStart, Date dateOfEnd, Boolean approved) {
        this.user = user;
        this.vehicle = vehicle;
        this.dateOfStart = dateOfStart;
        this.dateOfEnd = dateOfEnd;
        this.approved = approved;
    }

    public Rental(int id, User user, Vehicle vehicle, Date dateOfStart, Date dateOfEnd, Boolean approved) {
        this.id = id;
        this.user = user;
        this.vehicle = vehicle;
        this.dateOfStart = dateOfStart;
        this.dateOfEnd = dateOfEnd;
        this.approved = approved;
    }

    public int getId() { return id; }

    public void setId(int id) { this.id = id; }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Vehicle getVehicle() {
        return vehicle;
    }

    public void setVehicle(Vehicle vehicle) {
        this.vehicle = vehicle;
    }

    public Date getDateOfStart() {
        return dateOfStart;
    }

    public void setDateOfStart(Date dateOfStart) {
        this.dateOfStart = dateOfStart;
    }

    public Date getDateOfEnd() {
        return dateOfEnd;
    }

    public void setDateOfEnd(Date dateOfEnd) {
        this.dateOfEnd = dateOfEnd;
    }

    public Boolean getApproved() { return approved; }

    public void setApproved(Boolean approved) { this.approved = approved; }

    @Override
    public String toString() {
        return "Rental [id=" + id + ", user=" + user + ", vehicle=" + vehicle + ", dateOfStart=" + dateOfStart + ", dateOfEnd=" + dateOfEnd + "]";
    }
}
