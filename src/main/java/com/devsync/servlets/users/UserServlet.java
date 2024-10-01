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

//@WebServlet(name = "index", urlPatterns = {"/index"})
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
                String method = req.getParameter("_method");

                if ("DELETE".equalsIgnoreCase(method)) {
                        doDelete(req , resp);
                } else if ("UPDATE".equalsIgnoreCase(method)) {
                        doUpdate(req , resp);
                } else if ("PUT".equalsIgnoreCase(method)) {
                        doPut(req , resp);
                } else {
                        doSave(req, resp);
                }

        }




        protected void doSave(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
                resp.sendRedirect(req.getContextPath() + "/users");
        }

        protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                Long userId = Long.parseLong(req.getParameter("id"));
                userDao.delete(userId);
                req.setAttribute("successDeleteMessage", "User deleted successfully!");
                resp.sendRedirect(req.getContextPath() + "/users");

        }

        protected  void doUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                Long userId = Long.parseLong(req.getParameter("id"));
                User user = userDao.findById(userId);
                if (user != null) {
                        req.setAttribute("user", user);
                        req.getRequestDispatcher("/users/update.jsp").forward(req, resp);
                }
        }


        @Override
        protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                Long userId = Long.parseLong(req.getParameter("id"));
                String username = req.getParameter("username");
                String name = req.getParameter("name");
                String prenom = req.getParameter("prenom");
                String email = req.getParameter("email");
                String password = req.getParameter("password");
                UserType userType = UserType.valueOf(req.getParameter("userType"));

                User user = new User(userId, name, prenom, email, password, username,userType);
                userDao.update(user);
                resp.sendRedirect(req.getContextPath() + "/users");
        }

}