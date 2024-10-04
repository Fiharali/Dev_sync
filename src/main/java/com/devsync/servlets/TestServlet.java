package com.devsync.servlets;


import com.devsync.dao.TaskDao;
import com.devsync.domain.entities.Task;
import com.devsync.service.TaskService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TestServlet", urlPatterns = {"/test"})
public class TestServlet extends HttpServlet {

    private TaskDao taskDao;

    @Override
    public void init() throws ServletException {
        taskDao = new TaskDao();
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Task> tasks = taskDao.findAll();
        req.setAttribute("tasks", tasks);
        req.getRequestDispatcher("pages/tasks/list2.jsp").forward(req, resp);
    }
}
