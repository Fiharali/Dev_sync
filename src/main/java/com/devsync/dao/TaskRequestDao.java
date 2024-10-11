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


       public TaskRequest save(TaskRequest taskRequest) {
           EntityManager em = emf.createEntityManager();
           em.getTransaction().begin();
           em.persist(taskRequest);
           em.getTransaction().commit();
           em.close();
           return taskRequest;
       }


       public TaskRequest update(TaskRequest taskRequest) {
           EntityManager em = emf.createEntityManager();
           em.getTransaction().begin();
           em.merge(taskRequest);
           em.getTransaction().commit();
           em.close();
           return taskRequest;
       }

       public TaskRequest findById(Long taskRequestId) {
           EntityManager em = emf.createEntityManager();
           TaskRequest taskRequest = em.find(TaskRequest.class, taskRequestId);
           em.close();
           return taskRequest;
       }


    public TaskRequest findByTaskId(Long taskId) {
        EntityManager em = emf.createEntityManager();
        TypedQuery<TaskRequest> query = em.createQuery("SELECT t FROM TaskRequest t WHERE t.task.id = :taskId", TaskRequest.class);
        query.setParameter("taskId", taskId);
        List<TaskRequest> taskRequests = query.getResultList();
        em.close();
        return taskRequests.isEmpty() ? null : taskRequests.get(0);
    }
}