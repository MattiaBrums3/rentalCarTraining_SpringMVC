package com.springmvc.rentalcar.service;

import com.springmvc.rentalcar.model.User;

import java.util.List;

public interface UserService {
    User findById(int id);

    User findByCredentials(String username, String password);

    void saveUser(User user);

    void updateUser(User user);

    void deleteUser(int id);

    List<User> findAllUsers();
}
