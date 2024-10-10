package com.devsync.service;

import com.devsync.dao.TaskDao;
import com.devsync.domain.entities.Task;
import com.devsync.service.interfaces.TaskServiceInterface;
import com.devsync.service.interfaces.UserServiceInterface;

import java.util.List;

public class TaskService implements TaskServiceInterface {


    private TaskDao taskDao;
    private UserServiceInterface userServiceInterface;


    public TaskService() {
        taskDao = new TaskDao();
        userServiceInterface = new UserService();


        //updateTaskStatuses();
    }


    @Override
    public List<Task> findAll(){
       return  taskDao.findAll() ;
    }

    @Override
    public Task save(Task task){
        return taskDao.save(task);
    }


    @Override
    public Task findById(Long taskId){
       return taskDao.findById(taskId);
    }

    @Override
    public Task update(Task task){
        return taskDao.update(task);
    }

    @Override
    public void delete(Long taskId){
         taskDao.delete(taskId);
    }
}
