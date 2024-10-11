package com.devsync.service.interfaces;

import com.devsync.domain.entities.Task;

import java.util.List;

public interface TaskServiceInterface {
    List<Task> findAll();

    Task save(Task task);

    Task findById(Long taskId);

    Task update(Task task);

    void delete(Long taskId);
}
