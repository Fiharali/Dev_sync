package com.devsync.servlets;


import com.devsync.controller.TaskController;
import com.devsync.utils.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "taskServlet", urlPatterns = {"/tasks"})
public class TaskServlet extends HttpServlet {

        private TaskController taskController;

        @Override
        public void init() throws ServletException {
                taskController = new TaskController();
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                if (!SessionUtil.isUserLoggedIn(req, resp)) {
                        resp.sendRedirect(req.getContextPath() + "/login");
                        return;
                }
                String action = req.getParameter("action");
                if ("create".equals(action)) {
                        taskController.displayCreateForm(req, resp);
                } else {
                        taskController.findAll(req, resp);
                }
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

                String method = req.getParameter("_method");

                switch (method) {
                        case "DELETE":
                                taskController.delete(req, resp);
                                break;
                        case "UPDATE":
                                taskController.edit(req, resp);
                                break;
                        case "PUT":
                                taskController.update(req, resp);
                                break;
                        case "UPDATE_STATUS":
                                taskController.updateStatus(req, resp);
                                break;
                        case "UPDATE_USER":
                                taskController.updateUser(req, resp);
                                break;
                        default:
                                taskController.save(req, resp);
                                break;
                }
        }



}