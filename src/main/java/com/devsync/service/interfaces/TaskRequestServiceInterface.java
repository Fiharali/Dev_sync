package com.devsync.service.interfaces;

import com.devsync.domain.entities.TaskRequest;

import java.util.List;

public interface TaskRequestServiceInterface {
    List<TaskRequest> findAll();

    TaskRequest save(TaskRequest taskRequest);

    TaskRequest findById(Long id);

    TaskRequest update(TaskRequest taskRequest);
}
