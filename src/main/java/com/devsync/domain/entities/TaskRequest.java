package com.devsync.domain.entities;

import com.devsync.domain.enums.TaskRequestStatus;
import jakarta.persistence.*;


import java.time.LocalDateTime;

@Entity
public class TaskRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private TaskRequestStatus taskRequestStatus;



    private LocalDateTime requestDate;

    @ManyToOne
    @JoinColumn(name = "task_id")
    private Task task;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}