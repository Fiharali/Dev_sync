package com.devsync.service;

import com.devsync.dao.TagDao;
import com.devsync.domain.entities.Tag;
import com.devsync.service.interfaces.TagServiceInterface;

import java.util.List;

public class TagService implements TagServiceInterface {


    private TagDao tagDao;

    public TagService() {
        tagDao = new TagDao();
    }

    @Override
    public List<Tag> findAll(){
       return tagDao.findAll();
    }

    @Override
    public Tag save(Tag tag){
        return tagDao.save(tag);
    }

    @Override
    public Tag findById(Long tagId){
        return tagDao.findById(tagId);
    }

    @Override
    public Tag update(Tag tag){
        return tagDao.update(tag);
    }

    @Override
    public void delete(Long tagId){
        tagDao.delete(tagId);
    }
}
