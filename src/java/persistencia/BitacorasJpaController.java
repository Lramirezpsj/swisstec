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
import logica.Bitacoras;
import persistencia.exceptions.NonexistentEntityException;

/**
 *
 * @author ramir
 */
public class BitacorasJpaController implements Serializable {

    public BitacorasJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    public BitacorasJpaController() {
        emf = Persistence.createEntityManagerFactory("Swisstec_PU");
    }

    public void create(Bitacoras bitacoras) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(bitacoras);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Bitacoras bitacoras) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            bitacoras = em.merge(bitacoras);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Long id = bitacoras.getId();
                if (findBitacoras(id) == null) {
                    throw new NonexistentEntityException("The bitacoras with id " + id + " no longer exists.");
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
            Bitacoras bitacoras;
            try {
                bitacoras = em.getReference(Bitacoras.class, id);
                bitacoras.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The bitacoras with id " + id + " no longer exists.", enfe);
            }
            em.remove(bitacoras);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Bitacoras> findBitacorasEntities() {
        return findBitacorasEntities(true, -1, -1);
    }

    public List<Bitacoras> findBitacorasEntities(int maxResults, int firstResult) {
        return findBitacorasEntities(false, maxResults, firstResult);
    }

    private List<Bitacoras> findBitacorasEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Bitacoras.class));
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

    public Bitacoras findBitacoras(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Bitacoras.class, id);
        } finally {
            em.close();
        }
    }

    public int getBitacorasCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Bitacoras> rt = cq.from(Bitacoras.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
