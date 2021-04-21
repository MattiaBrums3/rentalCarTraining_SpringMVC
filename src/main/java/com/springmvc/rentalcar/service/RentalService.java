package com.springmvc.rentalcar.service;

import com.springmvc.rentalcar.model.Rental;

import java.util.List;

public interface RentalService {
    Rental findById(int id);

    List<Rental> findByUserId(int id);

    void saveRental(Rental rental);

    void updateRental(Rental rental);

    void deleteRental(int id);

    List<Rental> findAllRentals();
}
