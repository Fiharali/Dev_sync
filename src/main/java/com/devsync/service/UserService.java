package com.devsync.service;

import com.devsync.dao.UserDao;
import com.devsync.domain.entities.User;
import com.devsync.service.interfaces.UserServiceInterface;

import java.util.List;

public class UserService implements UserServiceInterface {


    private UserDao userDao;

    public UserService() {
        userDao = new UserDao();
    }

    @Override
    public List<User> findAll(){
        return userDao.findAll();
    }

    @Override
    public User findById(Long userId) {
        return userDao.findById(userId);
    }

    @Override
    public User save(User user){
        return  userDao.save(user);
    }

    @Override
    public User update(User user){
        return userDao.update(user);
    }

    @Override
    public void delete(Long userId){
       userDao.delete(userId);
    }

    @Override
    public List<User> getUsers(){
        return userDao.getUserWhoHaveUserTypeUser();
    }

    @Override
    public User findByEmail(String email) {
            return  userDao.findByEmail(email);
    }
}
