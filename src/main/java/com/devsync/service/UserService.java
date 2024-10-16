package com.devsync.service;

import com.devsync.dao.UserDao;
import com.devsync.domain.entities.User;
import com.devsync.exeptions.EmailExistException;
import com.devsync.exeptions.InvalidArgumentException;
import com.devsync.exeptions.ResourceNotFoundException;
import com.devsync.scheduled.TaskRequestUpdater;
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
        if (userId == null) {
            throw new InvalidArgumentException("User ID cannot be null");
        }
        return userDao.findById(userId).orElseThrow(() ->
                new ResourceNotFoundException("User with ID " + userId + " not found"));
    }

    @Override
    public User save(User user){
        if (user == null) {
            throw new InvalidArgumentException("User cannot be null");
        }
            User existingUser = findByEmail(user.getEmail());
            if (existingUser != null) {
                throw new EmailExistException("This email is already used");
            }
            return userDao.save(user);
    }

    @Override
    public User update(User user){
        if (user == null) {
            throw new InvalidArgumentException("User cannot be null");
        }
            return userDao.update(user);
    }

    @Override
    public void delete(Long userId){
        if (userId == null) {
            throw new InvalidArgumentException("User id  cannot be null");
        }
       userDao.delete(userId);
    }

    @Override
    public List<User> getUsers(){
        return userDao.getUserWhoHaveUserTypeUser();
    }

    @Override
    public User findByEmail(String email) {
        if (email == null) {
            throw new InvalidArgumentException("User Email cannot be null");
        }
            return  userDao.findByEmail(email);
    }
}
