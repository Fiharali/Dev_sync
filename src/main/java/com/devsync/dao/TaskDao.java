package com.devsync.dao;

import com.devsync.domain.entities.Task;
import com.devsync.domain.enums.TaskStatus;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class TaskDao {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("default");

    public List<Task> findAll() {
        EntityManager em = emf.createEntityManager();
        TypedQuery<Task> query = em.createQuery("SELECT t FROM Task t", Task.class);
        List<Task> tasks = query.getResultList();
        em.close();
        return tasks;
    }

    public void save(Task task) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(task);
        em.getTransaction().commit();
        em.close();
    }

    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        Task task = em.find(Task.class, id);
        if (task != null) {
            em.remove(task);
        }

        em.getTransaction().commit();
        em.close();
    }

    public void update(Task task) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(task);
        em.getTransaction().commit();
        em.close();
    }

    public Task findById(Long taskId) {
        EntityManager em = emf.createEntityManager();
        Task task = em.find(Task.class, taskId);
        em.close();
        return task;
    }

}