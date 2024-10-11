package com.devsync.servlets;

import com.devsync.controller.UserController;
import com.devsync.utils.CheckAccess;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "users", urlPatterns = {"/users"})
public class UserServlet extends HttpServlet {

        private UserController userController;


        @Override
        public void init() throws ServletException {
                userController = new UserController();
        }


        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                if (!CheckAccess.checkAccess(req, resp)) {
                        return;
                }
                String action = req.getParameter("action");
                if ("create".equals(action)) {
                        req.getRequestDispatcher("pages/users/create.jsp").forward(req, resp);
                } else {
                        userController.findAll(req, resp);
                }
        }


        @Override
        protected  void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                if (!CheckAccess.checkAccess(req, resp)) {
                        return;
                }

                String method = req.getParameter("_method");

                switch (method) {
                        case "DELETE":
                                userController.delete(req, resp);
                                break;
                        case "UPDATE":
                                userController.edit(req, resp);
                                break;
                        case "PUT":
                                userController.update(req, resp);
                                break;
                       default:
                                userController.save(req, resp);
                                break;
                }

        }





}