package com.devsync.service;

import com.devsync.dao.TaskDao;
import com.devsync.dao.UserDao;
import com.devsync.domain.entities.Task;
import com.devsync.domain.entities.User;
import com.devsync.domain.entities.Tag;
import com.devsync.domain.enums.TaskStatus;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class TaskService {

    private TaskDao taskDao;
   private UserDao userDao;
    private UserService userService;
    private TagService tagService;

    public TaskService() {
        taskDao = new TaskDao();
        userService = new UserService();
        tagService = new TagService();
        userDao = new UserDao();

        updateTaskStatuses();
    }


    public void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Task> tasks = taskDao.findAll();
        List<User> users = userDao.findAll();
        req.setAttribute("tasks", tasks);
        req.setAttribute("users", users);
        req.getRequestDispatcher("/pages/tasks/list.jsp").forward(req, resp);
    }


    public void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        LocalDate dateEnd = LocalDate.parse(req.getParameter("dateEnd"));


        if (dateEnd.isBefore(LocalDate.now().plusDays(3))){
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "end date must be  3 days from now");
            resp.sendRedirect(req.getContextPath() + "/tasks?action=create");
            return;
        }

        String title = req.getParameter("title");

        String description = req.getParameter("description");
        TaskStatus status = TaskStatus.valueOf(req.getParameter("status"));
        LocalDate dateCreated =  LocalDate.now();
        Long userId = Long.parseLong(req.getParameter("user_id"));
        Long createdByUserId = Long.parseLong(req.getParameter("createdByUser"));

        User user = userService.findById(userId);
        User createdByUser = userService.findById(createdByUserId);

        Task task = new Task();
        task.setTitle(title);
        task.setDescription(description);
        task.setStatus(status);
        task.setDateCreated(dateCreated);
        task.setDateEnd(dateEnd);
        task.setUser(user);
        task.setCreatedByUser(createdByUser);

        String[] tagIds = req.getParameterValues("tags[]");
        List<Tag> selectedTags = new ArrayList<>();
        if (tagIds != null) {
            for (String tagId : tagIds) {
                Long id = Long.parseLong(tagId);
                Tag tag = tagService.findById(id);
                selectedTags.add(tag);
            }
        }




        task.setTags(selectedTags);

        HttpSession session = req.getSession();
        session.setAttribute("successMessage", "Task created successfully!");

        taskDao.save(task);
        resp.sendRedirect(req.getContextPath() + "/tasks");
    }

    public void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long taskId = Long.parseLong(req.getParameter("id"));
        Task task = taskDao.findById(taskId);
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

       // User user = userDao.findById(userId);

        Task task = new Task();
        task.setId(taskId);
        task.setTitle(title);
        task.setDescription(description);
        task.setStatus(status);
        task.setDateCreated(dateCreated);
        task.setDateEnd(dateEnd);
       // task.setUser(user);

        taskDao.update(task);
        resp.sendRedirect(req.getContextPath() + "/tasks");
    }

    public void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long taskId = Long.parseLong(req.getParameter("id"));
        Long userId = Long.parseLong(req.getParameter("userId"));
        User user = userDao.findById(userId);
        taskDao.delete(taskId);
        user.setDeleteTokens(0);
        userDao.update(user);
        req.getSession().setAttribute("user", user);
        resp.sendRedirect(req.getContextPath() + "/tasks");
    }

    public void displayCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", userService.getUserWhoHaveUserTypeUser());
        req.setAttribute("tags", tagService.getAllTags());
        req.getRequestDispatcher("pages/tasks/create.jsp").forward(req, resp);

    }

    public void updateStatus(HttpServletRequest req, HttpServletResponse resp) {
        Long taskId = Long.parseLong(req.getParameter("taskId"));
        Task task = taskDao.findById(taskId);
        if (task != null) {
            TaskStatus status = TaskStatus.valueOf(req.getParameter("newStatus"));
            task.setStatus(status);
            taskDao.update(task);
        }
    }

    public void updateUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Long taskId = Long.parseLong(req.getParameter("task_id"));
        Long userId = Long.parseLong(req.getParameter("user_id"));
        Task task = taskDao.findById(taskId);
        User user = userDao.findById(userId);
        if (task != null && user != null) {
            task.setUser(user);
            taskDao.update(task);
        }

        resp.sendRedirect(req.getContextPath() + "/tasks");
    }

    private void updateTaskStatuses() {
        List<Task> tasks = taskDao.findAll();
        LocalDate today = LocalDate.now();

        for (Task task : tasks) {
            LocalDate taskEndDate = task.getDateEnd();
            if (taskEndDate.isBefore(today) && task.getStatus() != TaskStatus.DONE) {
                task.setStatus(TaskStatus.OVERDUE);
            }
            taskDao.update(task);
        }
    }


}