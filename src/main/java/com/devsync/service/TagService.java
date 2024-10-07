package com.devsync.service;

import com.devsync.dao.TagDao;
import com.devsync.domain.entities.Tag;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class TagService {

    private TagDao tagDao;

    public TagService() {
        tagDao = new TagDao();
    }

    public List<Tag> findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Tag> tags = tagDao.findAll();
        req.setAttribute("tags", tags);
        req.getRequestDispatcher("/pages/tags/list.jsp").forward(req, resp);
        return tags;
    }

    public void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");

        Tag tag = new Tag();
        tag.setName(name);

        tagDao.save(tag);
        resp.sendRedirect(req.getContextPath() + "/tags");
    }

    public void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long tagId = Long.parseLong(req.getParameter("id"));
        Tag tag = tagDao.findById(tagId);
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

        tagDao.update(tag);
        resp.sendRedirect(req.getContextPath() + "/tags");
    }

    public void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long tagId = Long.parseLong(req.getParameter("id"));
        tagDao.delete(tagId);
        resp.sendRedirect(req.getContextPath() + "/tags");
    }

    public List<Tag> getAllTags() {
        return tagDao.findAll();
    }

    public Tag findById(Long id) {
        return tagDao.findById(id);
    }
}