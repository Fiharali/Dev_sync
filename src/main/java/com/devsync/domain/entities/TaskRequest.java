package com.devsync.domain.entities;

import com.devsync.domain.enums.TaskRequestStatus;
import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;


import java.time.LocalDateTime;

@Entity
@Table(name = "task_requests")
public class TaskRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "task_request_status")
    private TaskRequestStatus taskRequestStatus;


    @Column(name = "date")
    private LocalDateTime date;

    @ManyToOne
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "task_id")

    private Task task;

    public TaskRequest() {
    }

    public TaskRequest(Task task, User user, LocalDateTime date, TaskRequestStatus taskRequestStatus, Long id) {
        this.task = task;
        this.user = user;
        this.date = date;
        this.taskRequestStatus = taskRequestStatus;
        this.id = id;
    }


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public TaskRequestStatus getTaskRequestStatus() {
        return taskRequestStatus;
    }

    public void setTaskRequestStatus(TaskRequestStatus taskRequestStatus) {
        this.taskRequestStatus = taskRequestStatus;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }
}