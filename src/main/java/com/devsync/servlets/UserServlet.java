package com.devsync.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "index", urlPatterns = {"/index"})
public class UserServlet extends HttpServlet {



        //private UserDao userDao = new UserDao();

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
           // List<User> users = userDao.findAll();
           // req.setAttribute("users", users);
            req.getRequestDispatcher("/users/users.jsp").forward(req, resp);
        }


        protected  void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        }



}