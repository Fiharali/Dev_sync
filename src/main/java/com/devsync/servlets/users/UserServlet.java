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


        @Override
        protected  void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                String method = req.getParameter("_method");
                switch (method) {
                        case "DELETE":
                                userService.delete(req, resp);
                                break;
                        case "edit":
                                userService.edit(req, resp);
                                break;
                        case "PUT":
                                userService.update(req, resp);
                                break;
                        default:
                                userService.save(req, resp);
                                break;
                }

        }










}