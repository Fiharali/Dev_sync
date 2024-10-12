package com.devsync.servlets;

import com.devsync.domain.entities.Task;
import com.devsync.service.TaskService;
import com.devsync.service.UserService;
import com.devsync.utils.SessionUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class StatisticsServlet extends HttpServlet {


private TaskService taskService;
private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        taskService = new TaskService();
        this.objectMapper = new ObjectMapper();
        this.objectMapper.registerModule(new JavaTimeModule());
        this.objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
    }



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!SessionUtil.isUserLoggedIn(req, resp)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<Task> tasks = taskService.findAll();
        req.setAttribute("tasks", tasks);
        req.getRequestDispatcher("pages/statistics/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Task> tasks = getTasks();


        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {

            objectMapper.writeValue(resp.getWriter(), tasks);
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("Error processing request: " + e.getMessage());
        }
    }
    private List<Task> getTasks() {
        List<Task> tasks = taskService.findAll();

        for (Task task : tasks) {
            task.setUser(null);
            task.setCreatedByUser(null);
            task.setTags(null);
        }

        return tasks;
    }


}
