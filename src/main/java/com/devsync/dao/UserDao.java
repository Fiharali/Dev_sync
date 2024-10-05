package com.devsync.dao;


import com.devsync.domain.entities.User;
import jakarta.persistence.*;

import java.util.List;

public class UserDao {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("default");




    public List<User> findAll() {
        EntityManager em = emf.createEntityManager();
        TypedQuery<User> query = em.createQuery("SELECT u FROM User u", User.class);
        List<User> users = query.getResultList();
        em.close();
        return users;

    }

    public void save(User user) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();
        em.close();
    }


    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        User user = em.find(User.class, id);
        if (user != null) {
            em.remove(user);
        }

        em.getTransaction().commit();
        em.close();
    }


    public void update(User user) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(user);
        em.getTransaction().commit();
        em.close();
    }

    public User findById(Long userId) {
        EntityManager em = emf.createEntityManager();
        User user = em.find(User.class, userId);
        em.close();
        return user;
    }

    public List<User> getUserWhoHaveUserTypeUser() {
        EntityManager em = emf.createEntityManager();
        TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.userType = 'USER'", User.class);
        List<User> users = query.getResultList();
        em.close();
        return users;
    }

    public User findByEmail(String email) {
        try {
            EntityManager em = emf.createEntityManager();
            return em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

}