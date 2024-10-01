package com.devsync.servlets.users;

import com.devsync.dao.UserDao;
import com.devsync.domain.entities.User;
import com.devsync.domain.enums.UserType;
import com.devsync.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

//@WebServlet(name = "index", urlPatterns = {"/index"})
public class UserServlet extends HttpServlet {

        private UserService userService;


        @Override
        public void init() throws ServletException {
                userService = new UserService();
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                String action = req.getParameter("action");
                if ("create".equals(action)) {
                        req.getRequestDispatcher("/users/create.jsp").forward(req, resp);
                } else {
                        userService.findAll(req, resp);
                }
        }


        protected  void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                String method = req.getParameter("_method");

                if ("DELETE".equalsIgnoreCase(method)) {
                        userService.delete(req , resp);
                } else if ("UPDATE".equalsIgnoreCase(method)) {
                        userService.edit(req , resp);
                } else if ("PUT".equalsIgnoreCase(method)) {
                        userService.update(req , resp);
                } else {
                        userService.save(req, resp);
                }

        }



}