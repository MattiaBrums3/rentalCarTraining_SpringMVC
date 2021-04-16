package com.springmvc.rentalcar.service;

import com.springmvc.rentalcar.dao.UserDao;
import com.springmvc.rentalcar.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service("userService")
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao dao;

    public User findById(int id) {
        return dao.findById(id);
    }

    public User findByCredentials(String username, String password) { return dao.findByCredentials(username, password); }

    public void saveUser(User user) {
        dao.saveUser(user);
    }

    public void updateUser(User user) {
        User entity = dao.findById(user.getId());
        if(entity!=null){
            entity.setName(user.getName());
            entity.setSurname(user.getSurname());
            entity.setDateOfBirth(user.getDateOfBirth());
            entity.setFiscalCode(user.getFiscalCode());
            entity.setSuperUser(user.getSuperUser());
            entity.setUsername(user.getUsername());
            entity.setPassword(user.getPassword());
        }
    }

    public void deleteUser(int id) {
        dao.deleteUser(id);
    }

    public List<User> findAllUsers() {
        return dao.findAllUsers();
    }
}
