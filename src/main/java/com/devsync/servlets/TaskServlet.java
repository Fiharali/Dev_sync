package com.devsync.servlets;


import com.devsync.service.TaskService;
import com.devsync.utils.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "taskServlet", urlPatterns = {"/tasks"})
public class TaskServlet extends HttpServlet {

        private TaskService taskService;

        @Override
        public void init() throws ServletException {
                taskService = new TaskService();
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                if (!SessionUtil.isUserLoggedIn(req, resp)) {
                        return;
                }

                String action = req.getParameter("action");
                if ("create".equals(action)) {
                        taskService.displayCreateForm(req, resp);
                } else {
                        taskService.findAll(req, resp);
                }
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                if (!SessionUtil.isUserLoggedIn(req, resp)) {
                        return;
                }
                String method = req.getParameter("_method");

                switch (method) {
                        case "DELETE":
                                taskService.delete(req, resp);
                                break;
                        case "UPDATE":
                                taskService.edit(req, resp);
                                break;
                        case "PUT":
                                taskService.update(req, resp);
                                break;
                        case "UPDATE_STATUS":
                                taskService.updateStatus(req, resp);
                                break;
                        default:
                                taskService.save(req, resp);
                                break;
                }
        }



}