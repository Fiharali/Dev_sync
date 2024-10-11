package com.devsync.controller;

import com.devsync.domain.entities.Tag;
import com.devsync.service.TagService;
import com.devsync.service.interfaces.TagServiceInterface;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class TagController {

    private TagServiceInterface tagServiceInterface;

    public TagController() {
        tagServiceInterface = new TagService();
    }

    public List<Tag> findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Tag> tags = tagServiceInterface.findAll();
        req.setAttribute("tags", tags);
        req.getRequestDispatcher("/pages/tags/list.jsp").forward(req, resp);
        return tags;
    }

    public void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");

        Tag tag = new Tag();
        tag.setName(name);

        tagServiceInterface.save(tag);
        resp.sendRedirect(req.getContextPath() + "/tags");
    }

    public void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long tagId = Long.parseLong(req.getParameter("id"));
        Tag tag = tagServiceInterface.findById(tagId);
        if (tag != null) {
            req.setAttribute("tag", tag);
            req.getRequestDispatcher("/pages/tags/update.jsp").forward(req, resp);
        }
    }

    public void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long tagId = Long.parseLong(req.getParameter("id"));
        String name = req.getParameter("name");

        Tag tag = new Tag();
        tag.setId(tagId);
        tag.setName(name);

        tagServiceInterface.update(tag);
        resp.sendRedirect(req.getContextPath() + "/tags");
    }

    public void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long tagId = Long.parseLong(req.getParameter("id"));
        tagServiceInterface.delete(tagId);
        resp.sendRedirect(req.getContextPath() + "/tags");
    }



}