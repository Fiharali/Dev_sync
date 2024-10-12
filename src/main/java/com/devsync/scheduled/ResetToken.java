package com.devsync.scheduled;

import com.devsync.domain.entities.User;

import com.devsync.service.UserService;

import java.time.LocalDate;
import java.util.List;
import java.util.TimerTask;
import java.util.logging.Logger;

public class ResetToken extends TimerTask {


    private UserService userService=new UserService();

    private static final Logger logger = Logger.getLogger(ResetToken.class.getName());

    @Override
    public void run() {
        logger.info("Running reset user Tokens To 2 ...");
        List<User> users = userService.findAll();
        LocalDate today = LocalDate.now();

        for (User user : users) {
                user.setTokens(2);
                logger.info("Updated tokens of  user ID " + user.getUsername() );
                userService.update(user);
        }
    }
}
