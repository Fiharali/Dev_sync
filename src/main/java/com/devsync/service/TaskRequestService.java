package com.devsync.service;

import com.devsync.controller.UserController;
import com.devsync.dao.TaskRequestDao;
import com.devsync.domain.entities.TaskRequest;
import com.devsync.scheduled.TaskRequestUpdater;
import com.devsync.service.interfaces.TaskRequestServiceInterface;

import java.util.List;

public class TaskRequestService implements TaskRequestServiceInterface {


    private TaskRequestDao taskRequestDao;


    public TaskRequestService() {
        taskRequestDao = new TaskRequestDao();

    }

    @Override
    public List<TaskRequest> findAll(){
        return taskRequestDao.findAll();
    }

    @Override
    public TaskRequest save(TaskRequest taskRequest) {
        return taskRequestDao.save(taskRequest);
    }

    @Override
    public TaskRequest findById(Long id) {
        return taskRequestDao.findById(id);
    }

    @Override
    public TaskRequest update(TaskRequest taskRequest) {
        return  taskRequestDao.update(taskRequest);
    }


    public  TaskRequest findByTsakId(Long taskId) {
        return taskRequestDao.findByTaskId(taskId);
    }
}
