package com.devsync.dao;

import com.devsync.domain.entities.Task;
import com.devsync.domain.entities.TaskRequest;
import com.devsync.domain.entities.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class TaskRequestDao {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("default");

         public List<TaskRequest> findAll() {
                EntityManager em = emf.createEntityManager();
                TypedQuery<TaskRequest> query = em.createQuery("SELECT t FROM TaskRequest t", TaskRequest.class);
                List<TaskRequest> taskRequests = query.getResultList();
                em.close();
                return taskRequests;

         }


       public void save(TaskRequest taskRequest) {
           EntityManager em = emf.createEntityManager();
           em.getTransaction().begin();
           em.persist(taskRequest);
           em.getTransaction().commit();
           em.close();
       }


       public void update(TaskRequest taskRequest) {
           EntityManager em = emf.createEntityManager();
           em.getTransaction().begin();
           em.merge(taskRequest);
           em.getTransaction().commit();
           em.close();
       }

       public TaskRequest findById(Long taskRequestId) {
           EntityManager em = emf.createEntityManager();
           TaskRequest taskRequest = em.find(TaskRequest.class, taskRequestId);
           em.close();
           return taskRequest;
       }









}