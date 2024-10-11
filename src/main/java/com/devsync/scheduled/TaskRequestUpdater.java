package com.devsync.scheduled;

import com.devsync.domain.entities.Task;
import com.devsync.domain.enums.TaskStatus;
import com.devsync.service.TaskService;

import javax.ejb.Schedule;
import javax.ejb.Singleton;
import javax.ejb.Startup;
import javax.inject.Inject;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Logger;

@Singleton
@Startup
public class TaskRequestUpdater {

    @Inject
    private TaskService taskService;
    private static final Logger logger = Logger.getLogger(TaskRequestUpdater.class.getName());

    @Schedule(minute = "*/1", hour = "*", persistent = false)
    public void updateTaskStatuses() {
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
