package com.devsync.service.interfaces;

import com.devsync.domain.entities.Tag;

import java.util.List;

public interface TagServiceInterface {
    List<Tag> findAll();

    Tag save(Tag tag);

    Tag findById(Long tagId);

    Tag update(Tag tag);

    void delete(Long tagId);
}
