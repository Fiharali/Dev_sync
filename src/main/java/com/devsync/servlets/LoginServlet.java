package com.devsync.servlets;

import com.devsync.dao.UserDao;
import com.devsync.domain.entities.User;
import com.devsync.service.UserService;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDao userDao;



    @Override
    public void init() throws ServletException {
        userDao = new UserDao();
    }



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("pages/auth/login.jsp").forward(req, resp);

    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String method = req.getParameter("_method");
        if (  method.equals("DESTROY")) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {

            String email = req.getParameter("email");
            String password = req.getParameter("password");

            User user = authenticate(email, password);
            if (user != null) {
                req.getSession().setAttribute("user", user);
                resp.sendRedirect(req.getContextPath() + "/tasks");
            } else {
                req.setAttribute("error", "Invalid username or password");
                RequestDispatcher dispatcher = req.getRequestDispatcher("pages/auth/login.jsp");
                dispatcher.forward(req, resp);
            }
        }
    }



    public User authenticate(String email, String password) {
        User user = userDao.findByEmail(email);
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }

}
