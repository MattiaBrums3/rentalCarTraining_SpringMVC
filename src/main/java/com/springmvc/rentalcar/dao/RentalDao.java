package com.springmvc.rentalcar.dao;

import com.springmvc.rentalcar.model.Rental;

import java.util.List;

public interface RentalDao {
    Rental findById(int id);

    List<Rental> findByUserId(int id);

    void saveRental(Rental rental);

    void deleteRental(int id);

    List<Rental> findAllRentals();
}
