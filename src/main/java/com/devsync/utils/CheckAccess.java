package com.devsync.utils;

import com.devsync.domain.entities.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CheckAccess {



    public static boolean  checkAccess(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        if (!SessionUtil.isUserLoggedIn(req, resp)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        if (!SessionUtil.isManager(req, resp)) {
            req.getRequestDispatcher("pages/errors/403.jsp").forward(req, resp);
            return false;
        }
        return true;
    }



}
