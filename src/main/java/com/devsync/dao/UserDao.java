package com.devsync.dao;


import com.devsync.domain.entities.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class UserDao {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("default");

    EntityManager em = emf.createEntityManager();


    public List<User> findAll() {
        TypedQuery<User> query = em.createQuery("SELECT u FROM User u", User.class);
        List<User> users = query.getResultList();
        em.close();
        return users;

    }

    public void save(User user) {
        em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();
        em.close();
    }


    public void delete(Long id) {
        em.getTransaction().begin();

        User user = em.find(User.class, id);
        if (user != null) {
            em.remove(user);
        }

        em.getTransaction().commit();
        em.close();
    }


    public void update(User user) {
        em.getTransaction().begin();
        em.merge(user);
        em.getTransaction().commit();
        em.close();
    }

    public User findById(Long userId) {
        User user = em.find(User.class, userId);
        em.close();
        return user;
    }

    public List<User> getUserWhoHaveUserTypeUser() {
        TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.userType = 'USER'", User.class);
        List<User> users = query.getResultList();
        em.close();
        return users;
    }

    public User findByEmail(String email) {
        TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class);
        query.setParameter("email", email);
        List<User> users = query.getResultList();
        em.close();
        return users.isEmpty() ? null : users.get(0);
    }

}