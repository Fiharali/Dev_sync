package com.devsync.service;

import com.devsync.dao.TaskRequestDao;
import com.devsync.dao.UserDao;
import com.devsync.domain.entities.Tag;
import com.devsync.domain.entities.Task;
import com.devsync.domain.entities.TaskRequest;
import com.devsync.domain.entities.User;
import com.devsync.domain.enums.TaskRequestStatus;
import com.devsync.domain.enums.TaskStatus;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TaskRequestService {

    private TaskRequestDao taskRequestDao;
    private UserService userService;


    public TaskRequestService() {

        userService = new UserService();
        taskRequestDao = new TaskRequestDao();

    }


    public void findRecentTasksForUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser != null){
            List<TaskRequest> tasksRequest = taskRequestDao.findAll();
            tasksRequest.stream().filter(taskRequest ->
                         taskRequest.getUser().getId().equals(sessionUser.getId())
                         && taskRequest.getTaskRequestStatus().equals(TaskRequestStatus.PENDING)
                         && taskRequest.getDate().minusHours(12).equals(LocalDateTime.now())
            );
            req.setAttribute("tasks", tasksRequest);
        }
        req.getRequestDispatcher("/pages/tasks/list-request.jsp").forward(req, resp);
    }



    public void save(User user , Task task)  {

        TaskRequest taskRequest = new TaskRequest();
        taskRequest.setUser(user);
        taskRequest.setTask(task);
        taskRequest.setDate(LocalDateTime.now());
        taskRequest.setTaskRequestStatus(TaskRequestStatus.PENDING);
        taskRequestDao.save(taskRequest);

    }

    public void updateStatus(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        TaskRequestStatus status =TaskRequestStatus.valueOf(req.getParameter("_method"));
        TaskRequest taskRequest = taskRequestDao.findById(id);
        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("user");
        if ( status.equals(TaskRequestStatus.REJECTED)){
            sessionUser.setTokens(sessionUser.getTokens() - 1);
            userService.updateStatus(sessionUser);
        }

        taskRequest.setTaskRequestStatus(status);
        taskRequestDao.update(taskRequest);
        resp.sendRedirect(req.getContextPath() + "/tasks");
    }




}