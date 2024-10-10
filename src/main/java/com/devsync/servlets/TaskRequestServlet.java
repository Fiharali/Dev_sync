package com.devsync.servlets;


import com.devsync.service.TaskRequestService;
import com.devsync.service.TaskService;
import com.devsync.utils.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/tasks-request")
public class TaskRequestServlet extends HttpServlet {

        private TaskRequestService taskRequestService;

        @Override
        public void init() throws ServletException {
                taskRequestService = new TaskRequestService();
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                if (!SessionUtil.isUserLoggedIn(req, resp)) {
                        resp.sendRedirect(req.getContextPath() + "/login");
                        return;
                }
                String action = req.getParameter("action");
                if ("rejected-tasks".equals(action)) {
                        taskRequestService.findRejectedTasks(req, resp);
                } else {
                        taskRequestService.findRecentTasksForUser(req, resp);

                }
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                taskRequestService.updateStatus(req, resp);
        }



}