/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package persistencia;

import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import logica.Revision;
import persistencia.exceptions.NonexistentEntityException;

/**
 *
 * @author ramir
 */
public class RevisionJpaController implements Serializable {

    public RevisionJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    public RevisionJpaController() {
        emf = Persistence.createEntityManagerFactory("Swisstec_PU");
    }

    public void create(Revision revision) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(revision);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Revision revision) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            revision = em.merge(revision);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Long id = revision.getId();
                if (findRevision(id) == null) {
                    throw new NonexistentEntityException("The revision with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Long id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Revision revision;
            try {
                revision = em.getReference(Revision.class, id);
                revision.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The revision with id " + id + " no longer exists.", enfe);
            }
            em.remove(revision);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Revision> findRevisionEntities() {
        return findRevisionEntities(true, -1, -1);
    }

    public List<Revision> findRevisionEntities(int maxResults, int firstResult) {
        return findRevisionEntities(false, maxResults, firstResult);
    }

    private List<Revision> findRevisionEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Revision.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Revision findRevision(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Revision.class, id);
        } finally {
            em.close();
        }
    }

    public int getRevisionCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Revision> rt = cq.from(Revision.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
