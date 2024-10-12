package com.devsync.scheduled;

import com.devsync.domain.entities.TaskRequest;
import com.devsync.domain.entities.User;
import com.devsync.domain.enums.TaskRequestStatus;
import com.devsync.service.TaskRequestService;
import com.devsync.service.UserService;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.TimerTask;
import java.util.logging.Logger;

public class DoubleTokens extends TimerTask {


    private TaskRequestService taskRequestService =new TaskRequestService();
    private UserService userService = new UserService();


    private static final Logger logger = Logger.getLogger(DoubleTokens.class.getName());

    @Override
    public void run() {
        logger.info("Running double user Tokens To 2 ...");
        List<TaskRequest> TaskRequests = taskRequestService.findAll();
        LocalDate today = LocalDate.now();

        for (TaskRequest taskRequest : TaskRequests) {
            if (taskRequest.getTaskRequestStatus().name().equals("PENDING")
                    && taskRequest.getDate().plusMinutes(2).isAfter(LocalDateTime.now())) {
                taskRequest.getUser().setTokens(taskRequest.getUser().getTokens() * 2);
                taskRequest.setTaskRequestStatus(TaskRequestStatus.REJECTED);
                userService.update(taskRequest.getUser());
                logger.info("Updated tokens of  user ID " + taskRequest.getUser().getUsername() );
            }
        }
    }
}
