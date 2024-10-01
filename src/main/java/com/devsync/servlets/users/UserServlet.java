package com.devsync.servlets.users;

import com.devsync.dao.UserDao;
import com.devsync.domain.entities.User;
import com.devsync.domain.enums.UserType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "index", urlPatterns = {"/index"})
public class UserServlet extends HttpServlet {


        private UserDao userDao;

        // Initialize UserService
        @Override
        public void init() throws ServletException {
                userDao = new UserDao();
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                String action = req.getParameter("action");

                if ("create".equals(action)) {
                        req.getRequestDispatcher("/users/create.jsp").forward(req, resp);
                } else {

                        List<User> users = userDao.findAll();
                        req.setAttribute("users", users);
                        req.getRequestDispatcher("/users/list.jsp").forward(req, resp);
                }
        }


        protected  void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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

                userDao.save(user);


        }



}