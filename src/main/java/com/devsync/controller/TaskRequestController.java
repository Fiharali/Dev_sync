package com.devsync.controller;

import com.devsync.domain.entities.Task;
import com.devsync.domain.entities.TaskRequest;
import com.devsync.domain.entities.User;
import com.devsync.domain.enums.TaskRequestStatus;
import com.devsync.service.TaskRequestService;
import com.devsync.service.UserService;
import com.devsync.service.interfaces.TaskRequestServiceInterface;
import com.devsync.service.interfaces.UserServiceInterface;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

public class TaskRequestController {

    private TaskRequestServiceInterface taskRequestServiceInterface;
    private UserServiceInterface userServiceInterface;


    public TaskRequestController() {
        userServiceInterface = new UserService();
        taskRequestServiceInterface = new TaskRequestService();


    }


    public void findRecentTasksForUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser != null){
            List<TaskRequest> tasksRequest = taskRequestServiceInterface.findAll();
            tasksRequest.stream().filter(taskRequest ->
                         taskRequest.getUser().getId().equals(sessionUser.getId())
                         && taskRequest.getTaskRequestStatus().equals(TaskRequestStatus.PENDING)
                         && taskRequest.getDate().minusHours(12).equals(LocalDateTime.now())
            );
            req.setAttribute("tasks", tasksRequest);
        }
        req.getRequestDispatcher("/pages/request/list-request.jsp").forward(req, resp);
    }



    public void save(User user , Task task)  {

        TaskRequest taskRequest = new TaskRequest();
        taskRequest.setUser(user);
        taskRequest.setTask(task);
        taskRequest.setDate(LocalDateTime.now());
        taskRequest.setTaskRequestStatus(TaskRequestStatus.APPROVED);

        taskRequestServiceInterface.save(taskRequest);

    }

    public void updateStatus(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        TaskRequestStatus status =TaskRequestStatus.valueOf(req.getParameter("_method"));
        TaskRequest taskRequest = taskRequestServiceInterface.findById(id);
        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("user");
        if (status.equals(TaskRequestStatus.PENDING)){
            sessionUser.setTokens(sessionUser.getTokens() - 1);
            userServiceInterface.update(sessionUser);
        }

        taskRequest.setTaskRequestStatus(status);
        taskRequestServiceInterface.update(taskRequest);
        resp.sendRedirect(req.getContextPath() + "/tasks");
    }


    public void findRejectedTasks(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<TaskRequest> tasksRequest = taskRequestServiceInterface.findAll();
        tasksRequest.stream().filter(taskRequest ->
                        taskRequest.getTaskRequestStatus().equals(TaskRequestStatus.REJECTED)
                        && taskRequest.getDate().minusHours(12).equals(LocalDateTime.now())
        );
        req.setAttribute("tasksRequest", tasksRequest);
        req.getRequestDispatcher("/pages/request/list-request-rejected.jsp").forward(req, resp);

    }
}