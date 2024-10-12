package com.devsync.scheduled;

import com.devsync.scheduled.TaskRequestUpdater;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.Timer;

@WebListener
public class TaskSchedulerListener implements ServletContextListener {

    private Timer timer;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        timer = new Timer(true);
        TaskRequestUpdater task = new TaskRequestUpdater();
        timer.scheduleAtFixedRate(task, 0, 24*60*60 * 1000);

        ResetToken token = new ResetToken();
        timer.scheduleAtFixedRate(token, 0, 24*60*60 * 1000);

        DoubleTokens doubleTokens = new DoubleTokens();
        timer.scheduleAtFixedRate(doubleTokens, 0, 5*60 * 1000);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (timer != null) {
            timer.cancel();
        }
    }
}
