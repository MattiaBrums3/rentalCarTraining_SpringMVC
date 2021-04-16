package com.springmvc.rentalcar.dao;

import com.springmvc.rentalcar.model.User;

import java.util.List;

public interface UserDao {
    User findById(int id);

    void saveUser(User user);

    void deleteUser(int id);

    List<User> findAllUsers();
}
