package com.devsync.scheduled;

import com.devsync.domain.entities.Task;
import com.devsync.domain.enums.TaskStatus;
import com.devsync.service.TaskService;

import javax.inject.Inject;
import java.time.LocalDate;
import java.util.List;
import java.util.TimerTask;
import java.util.logging.Logger;

public class TaskRequestUpdater extends TimerTask {


    private TaskService taskService=new TaskService();
    private static final Logger logger = Logger.getLogger(TaskRequestUpdater.class.getName());

    @Override
    public void run() {
        logger.info("Running scheduled task to update statuses...");
        List<Task> tasks = taskService.findAll();
        LocalDate today = LocalDate.now();

        for (Task task : tasks) {
            LocalDate taskEndDate = task.getDateEnd();
            if (taskEndDate.isBefore(today) && task.getStatus() != TaskStatus.DONE) {
                task.setStatus(TaskStatus.OVERDUE);
                logger.info("Updated task ID " + task.getId() + " to OVERDUE.");
            }
            taskService.update(task);
        }
    }
}
