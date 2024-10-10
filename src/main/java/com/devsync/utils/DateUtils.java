package com.devsync.utils;

import java.time.Duration;
import java.time.LocalDateTime;

public class DateUtils {
    public static String timeAgo(LocalDateTime dateTime) {
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(dateTime, now);

        if (duration.toHours() > 0) {
            return duration.toHours() + " hour" + (duration.toHours() > 1 ? "s" : "") + " ago";
        } else if (duration.toMinutes() > 0) {
            return duration.toMinutes() + " minute" + (duration.toMinutes() > 1 ? "s" : "") + " ago";
        } else {
            return "just now";
        }
    }
}
