package com.devsync;

import com.devsync.dao.UserDao;
import com.devsync.domain.entities.User;
import com.devsync.domain.enums.UserType;
import com.devsync.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.List;

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
    public void testFindAll() {

        List<User> mockUsers = new ArrayList<>();
        mockUsers.add(new User(1L,  "User", "One", "user1@example.com", "password","user1", UserType.USER, 1 , 1));
        when(userDao.findAll()).thenReturn(mockUsers);


        List<User> users = userService.findAll();

        assertEquals(1, users.size());
        assertEquals("user1", users.get(0).getUsername());
        verify(userDao, times(1)).findAll();
    }

    @Test
    public void testSave() {
        User user = new User(1L, "User", "Two", "user2@example.com", "password", "user2", UserType.USER,1,1);
        when(userDao.save(user)).thenReturn(user);

        User savedUser = userService.save(user);

        assertNotNull(savedUser);
        assertEquals("user2", savedUser.getUsername());
        verify(userDao, times(1)).save(user);
    }

    @Test
    public void testFindById() {

        User mockUser = new User(1L,  "User", "Three", "user3@example.com", "password","user3", UserType.USER, 1, 2);
        when(userDao.findById(1L)).thenReturn(mockUser);

        User foundUser = userService.findById(1L);


        assertNotNull(foundUser);
        assertEquals("user3", foundUser.getUsername());
        verify(userDao, times(1)).findById(1L);
    }

    @Test
    public void testDelete() {

        userService.delete(1L);

        verify(userDao, times(1)).delete(1L);
    }
}
