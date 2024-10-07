package com.devsync.dao;

import com.devsync.domain.entities.Tag;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class TagDao {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("default");

    public List<Tag> findAll() {
        EntityManager em = emf.createEntityManager();
        TypedQuery<Tag> query = em.createQuery("SELECT t FROM Tag t", Tag.class);
        List<Tag> tags = query.getResultList();
        em.close();
        return tags;
    }

    public void save(Tag tag) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(tag);
        em.getTransaction().commit();
        em.close();
    }

    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        Tag tag = em.find(Tag.class, id);
        if (tag != null) {
            em.remove(tag);
        }

        em.getTransaction().commit();
        em.close();
    }

    public void update(Tag tag) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(tag);
        em.getTransaction().commit();
        em.close();
    }

    public Tag findById(Long tagId) {
        EntityManager em = emf.createEntityManager();
        Tag tag = em.find(Tag.class, tagId);
        em.close();
        return tag;
    }

}