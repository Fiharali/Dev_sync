package com.devsync.service;

import com.devsync.dao.TaskDao;
import com.devsync.dao.UserDao;
import com.devsync.domain.entities.Task;
import com.devsync.domain.entities.User;
import com.devsync.domain.enums.TaskStatus;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

public class TaskService {

    private TaskDao taskDao;
  //  private UserDao userDao;
    private UserService userService;

    public TaskService() {
        taskDao = new TaskDao();
       // userDao = new UserDao();
        userService = new UserService();
    }


    public void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Task> tasks = taskDao.findAll();
        req.setAttribute("tasks", tasks);
        req.getRequestDispatcher("/pages/tasks/list.jsp").forward(req, resp);
    }

    public void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        TaskStatus status = TaskStatus.valueOf(req.getParameter("status"));
        LocalDate dateCreated = LocalDate.parse(req.getParameter("dateCreated"));
        LocalDate dateEnd = LocalDate.parse(req.getParameter("dateEnd"));
        Long userId = Long.parseLong(req.getParameter("userId"));

        User user = userService.findById(userId);

        Task task = new Task();
        task.setTitle(title);
        task.setDescription(description);
        task.setStatus(status);
        task.setDateCreated(dateCreated);
        task.setDateEnd(dateEnd);
        task.setUser(user);
       // user.getTasks().add(task);
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
        taskDao.delete(taskId);
        resp.sendRedirect(req.getContextPath() + "/tasks");
    }

    public void displayCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", userService.getUserWhoHaveUserTypeUser());
        req.getRequestDispatcher("pages/tasks/create.jsp").forward(req, resp);

    }
}