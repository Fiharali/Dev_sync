package com.devsync;

import com.devsync.dao.UserDao;
import com.devsync.domain.entities.User;
import com.devsync.domain.enums.UserType;
import com.devsync.exceptions.EmailExistException;
import com.devsync.exceptions.InvalidArgumentException;
import com.devsync.exceptions.ResourceNotFoundException;
import com.devsync.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class UserServiceTest {

    @Mock
    private UserDao userDao;

    @InjectMocks
    private UserService userService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }



    @Test
    public void testSave() {
        User user = new User(1L, "User", "Two", "user2@example.com", "password", "user2", UserType.USER,1,1);
        when(userDao.save(user)).thenReturn(user);
        assertThrows(InvalidArgumentException.class, () -> userService.save(null));
    }


    @Test
    public void testSaveDuplicate() {

        User user = new User(1L, "User", "Two", "user2@example.com", "password", "user2", UserType.USER, 1, 1);
        User user2 = new User(2L, "User", "Two", "user2@example.com", "password", "user2", UserType.USER, 1, 1);

        when(userDao.findByEmail("user2@example.com")).thenReturn(null).thenReturn(user);

        userService.save(user);

        assertThrows(EmailExistException.class, () -> userService.save(user2));

        verify(userDao, times(1)).save(user);
    }


    @Test
    public void testFindByIdWithNull() {

        User mockUser = new User(1L,  "User", "Three", "user3@example.com", "password","user3", UserType.USER, 1, 2);
        when(userDao.findById(1L)).thenReturn(Optional.of(mockUser));

        assertThrows(InvalidArgumentException.class, () -> userService.findById(null));

    }


    @Test
    public void testFindByIdNotFound() {

        User mockUser = new User(1L,  "User", "Three", "user3@example.com", "password","user3", UserType.USER, 1, 2);
        when(userDao.findById(1L)).thenReturn(Optional.of(mockUser));

        assertThrows(ResourceNotFoundException.class, () -> userService.findById(10L));

    }


    @Test
    public void testDeleteNotFound() {
        User mockUser = new User(1L,  "User", "Three", "user3@example.com", "password","user3", UserType.USER, 1, 2);
        when(userDao.findById(1L)).thenReturn(Optional.of(mockUser));

        assertThrows(ResourceNotFoundException.class, () -> userService.findById(10L));
    }

    @Test
    public void testDeleteWithNull() {
        User mockUser = new User(1L,  "User", "Three", "user3@example.com", "password","user3", UserType.USER, 1, 2);
        when(userDao.findById(1L)).thenReturn(Optional.of(mockUser));

        assertThrows(InvalidArgumentException.class, () -> userService.findById(null));
    }
}
