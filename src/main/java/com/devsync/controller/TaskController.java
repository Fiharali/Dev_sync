package com.devsync.controller;

import com.devsync.domain.entities.Task;
import com.devsync.domain.entities.TaskRequest;
import com.devsync.domain.entities.User;
import com.devsync.domain.entities.Tag;
import com.devsync.domain.enums.TaskRequestStatus;
import com.devsync.domain.enums.TaskStatus;
import com.devsync.service.TagService;
import com.devsync.service.TaskRequestService;
import com.devsync.service.TaskService;
import com.devsync.service.UserService;
import com.devsync.service.interfaces.TagServiceInterface;
import com.devsync.service.interfaces.TaskServiceInterface;
import com.devsync.service.interfaces.UserServiceInterface;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TaskController {

    private TaskServiceInterface taskServiceInterface;
    private UserServiceInterface userServiceInterface;
    private TagServiceInterface tagServiceInterface;

    private TaskRequestController taskRequestController;
    private TaskRequestService  taskRequestService;


    public TaskController() {
        userServiceInterface = new UserService();

        tagServiceInterface = new TagService();
        taskRequestController = new TaskRequestController();
        taskRequestService = new TaskRequestService();
        taskServiceInterface = new TaskService();


        //updateTaskStatuses();
    }


    public void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Task> tasks = taskServiceInterface.findAll();
        List<User> users = userServiceInterface.findAll();
        req.setAttribute("tasks", tasks);
        req.setAttribute("users", users);
        req.getRequestDispatcher("/pages/tasks/list.jsp").forward(req, resp);
    }


    public void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        LocalDate dateEnd = LocalDate.parse(req.getParameter("dateEnd"));
        LocalDate dateStart = LocalDate.parse(req.getParameter("dateStart"));

        HttpSession session = req.getSession();
        if (dateEnd.isBefore(LocalDate.now().plusDays(3))){
            session.setAttribute("errorMessageFirst", "start date must be 3 days from now");
            resp.sendRedirect(req.getContextPath() + "/tasks?action=create");
            return;
        }
        if (dateEnd.isBefore(dateStart)){
            session.setAttribute("errorMessageSecond", "start date must be befor end date ");
            resp.sendRedirect(req.getContextPath() + "/tasks?action=create");
            return;
        }

        String title = req.getParameter("title");

        String description = req.getParameter("description");
        TaskStatus status = TaskStatus.valueOf(req.getParameter("status"));
        LocalDate dateCreated =  LocalDate.now();
        Long userId = Long.parseLong(req.getParameter("user_id"));
        Long createdByUserId = Long.parseLong(req.getParameter("createdByUser"));

        User user = userServiceInterface.findById(userId);
        User createdByUser = userServiceInterface.findById(createdByUserId);

        Task task = new Task();
        task.setTitle(title);
        task.setDescription(description);
        task.setStatus(status);
        task.setDateCreated(dateCreated);
        task.setDateEnd(dateEnd);
        task.setStartDate(dateStart);
        task.setUser(user);
        task.setAssigned(false);
        task.setCreatedByUser(createdByUser);

        String[] tagIds = req.getParameterValues("tags[]");
        List<Tag> selectedTags = new ArrayList<>();
        if (tagIds != null) {
            for (String tagId : tagIds) {
                Long id = Long.parseLong(tagId);
                Tag tag = tagServiceInterface.findById(id);
                selectedTags.add(tag);
            }
        }


        task.setTags(selectedTags);
        Task task1 = taskServiceInterface.save(task);
        taskRequestController.save(user, task1);

        session.setAttribute("successMessage", "Task created successfully!");
        resp.sendRedirect(req.getContextPath() + "/tasks");
    }

    public void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long taskId = Long.parseLong(req.getParameter("id"));
        Task task = taskServiceInterface.findById(taskId);
        if (task != null) {
            req.setAttribute("task", task);
            req.getRequestDispatcher("/pages/tasks/update.jsp").forward(req, resp);
        }
    }

    public void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long taskId = Long.parseLong(req.getParameter("id"));
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        TaskStatus status = TaskStatus.valueOf(req.getParameter("status"));
        LocalDate dateCreated = LocalDate.parse(req.getParameter("dateCreated"));
        LocalDate dateEnd = LocalDate.parse(req.getParameter("dateEnd"));
        Long userId = Long.parseLong(req.getParameter("userId"));



        Task task = new Task();
        task.setId(taskId);
        task.setTitle(title);
        task.setDescription(description);
        task.setStatus(status);
        task.setDateCreated(dateCreated);
        task.setDateEnd(dateEnd);


        taskServiceInterface.update(task);
        resp.sendRedirect(req.getContextPath() + "/tasks");
    }

    public void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long taskId = Long.parseLong(req.getParameter("id"));
        Long userId = Long.parseLong(req.getParameter("userId"));
        User user = userServiceInterface.findById(userId);
        taskServiceInterface.delete(taskId);
        user.setDeleteTokens(0);
        userServiceInterface.update(user);
        req.getSession().setAttribute("user", user);
        resp.sendRedirect(req.getContextPath() + "/tasks");
    }

    public void displayCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", userServiceInterface.getUsers());
        req.setAttribute("tags", tagServiceInterface.findAll());
        req.getRequestDispatcher("pages/tasks/create.jsp").forward(req, resp);

    }

    public void updateStatus(HttpServletRequest req, HttpServletResponse resp) {
        Long taskId = Long.parseLong(req.getParameter("taskId"));
        Task task = taskServiceInterface.findById(taskId);
        if (task != null) {
            TaskStatus status = TaskStatus.valueOf(req.getParameter("newStatus"));
            task.setStatus(status);
            taskServiceInterface.update(task);
        }
    }

    public void updateUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Long taskId = Long.parseLong(req.getParameter("task_id"));
        Long userId = Long.parseLong(req.getParameter("user_id"));
        Task task = taskServiceInterface.findById(taskId);
        User user = userServiceInterface.findById(userId);
        if (task != null && user != null) {
            task.setUser(user);
            taskServiceInterface.update(task);
            TaskRequest taskRequest = taskRequestService.findByTsakId(taskId);
            taskRequest.setUser(user);
            taskRequest.setDate(LocalDateTime.now());
            taskRequest.setTaskRequestStatus(TaskRequestStatus.APPROVED);
            taskRequestService.update(taskRequest);
        }



        resp.sendRedirect(req.getContextPath() + "/tasks");
    }

    private void updateTaskStatuses() {
        List<Task> tasks = taskServiceInterface.findAll();
        LocalDate today = LocalDate.now();

        for (Task task : tasks) {
            LocalDate taskEndDate = task.getDateEnd();
            if (taskEndDate.isBefore(today) && task.getStatus() != TaskStatus.DONE) {
                task.setStatus(TaskStatus.OVERDUE);
            }
            taskServiceInterface.update(task);
        }
    }


}