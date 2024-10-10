package com.devsync.servlets;

import com.devsync.controller.TagController;
import com.devsync.utils.CheckAccess;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "tagServlet", urlPatterns = {"/tags"})
public class TagServlet extends HttpServlet {

    private TagController tagController;

    @Override
    public void init() throws ServletException {
        tagController = new TagController();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!CheckAccess.checkAccess(req, resp)) {
            return;
        }
        String action = req.getParameter("action");
        if ("create".equals(action)) {
            req.getRequestDispatcher("pages/tags/create.jsp").forward(req, resp);
            } else {
                tagController.findAll(req, resp);
            }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!CheckAccess.checkAccess(req, resp)) {
            return;
        }

        String method = req.getParameter("_method");

        switch (method) {
            case "DELETE":
                tagController.delete(req, resp);
                break;
            case "UPDATE":
                tagController.edit(req, resp);
                break;
            case "PUT":
                tagController.update(req, resp);
                break;
            default:
                tagController.save(req, resp);
                break;
        }
    }
}