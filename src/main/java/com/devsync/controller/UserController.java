package com.devsync.controller;

import com.devsync.domain.entities.User;
import com.devsync.domain.enums.UserType;
import com.devsync.service.UserService;
import com.devsync.service.interfaces.UserServiceInterface;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class UserController {

    private UserServiceInterface userServiceInterface;

    public UserController() {
        userServiceInterface = new UserService();
    }

    public void findAll(HttpServletRequest req, HttpServletResponse resp) throws  ServletException ,IOException{
        List<User> users = userServiceInterface.findAll();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/pages/users/list.jsp").forward(req, resp);
    }

    public User findById(Long userId) {
        return userServiceInterface.findById(userId);
    }

    public void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String name = req.getParameter("name");
        String prenom = req.getParameter("prenom");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String userType = req.getParameter("userType");

        User user = new User();
        user.setUsername(username);
        user.setName(name);
        user.setPrenom(prenom);
        user.setEmail(email);
        user.setPassword(password);
        user.setUserType(UserType.valueOf(userType.toUpperCase()));
        user.setTokens(2);
        user.setDeleteTokens(1);

        userServiceInterface.save(user);

        resp.sendRedirect(req.getContextPath() + "/users");
    }

    public void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long userId = Long.parseLong(req.getParameter("id"));
        User user = userServiceInterface.findById(userId);
        if (user != null) {
            req.setAttribute("user", user);
            req.getRequestDispatcher("/pages/users/update.jsp").forward(req, resp);
        }
    }

    public void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long userId = Long.parseLong(req.getParameter("id"));
        String username = req.getParameter("username");
        String name = req.getParameter("name");
        String prenom = req.getParameter("prenom");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String userType = req.getParameter("userType");

        User user = new User();
        user.setId(userId);
        user.setUsername(username);
        user.setName(name);
        user.setPrenom(prenom);
        user.setEmail(email);
        user.setPassword(password);
        user.setUserType(UserType.valueOf(userType.toUpperCase()));

        userServiceInterface.update(user);
        resp.sendRedirect(req.getContextPath() + "/users");
    }


    public void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long userId = Long.parseLong(req.getParameter("id"));
        userServiceInterface.delete(userId);
        req.setAttribute("successDeleteMessage", "User deleted successfully!");
        resp.sendRedirect(req.getContextPath() + "/users");
    }


}
