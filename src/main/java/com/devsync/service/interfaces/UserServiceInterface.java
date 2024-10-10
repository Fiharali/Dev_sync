package com.devsync.service.interfaces;

import com.devsync.domain.entities.User;

import java.util.List;

public interface UserServiceInterface {
    List<User> findAll();

    User findById(Long userId);

    User save(User user);

    User update(User user);

    void delete(Long userId);

    List<User> getUsers();
}
