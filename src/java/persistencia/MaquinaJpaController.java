
package persistencia;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import logica.Maquina;
import persistencia.exceptions.NonexistentEntityException;


public class MaquinaJpaController implements Serializable {

    public MaquinaJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    public MaquinaJpaController() {
        emf = Persistence.createEntityManagerFactory("Swisstec_PU");
    }

    public void create(Maquina maquina) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(maquina);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Maquina maquina) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            maquina = em.merge(maquina);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = maquina.getId_maquina();
                if (findMaquina(id) == null) {
                    throw new NonexistentEntityException("The maquina with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(int id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Maquina maquina;
            try {
                maquina = em.getReference(Maquina.class, id);
                maquina.getId_maquina();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The maquina with id " + id + " no longer exists.", enfe);
            }
            em.remove(maquina);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Maquina> findMaquinaEntities() {
        return findMaquinaEntities(true, -1, -1);
    }

    public List<Maquina> findMaquinaEntities(int maxResults, int firstResult) {
        return findMaquinaEntities(false, maxResults, firstResult);
    }

    private List<Maquina> findMaquinaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Maquina.class));
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

    public Maquina findMaquina(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Maquina.class, id);
        } finally {
            em.close();
        }
    }

    public int getMaquinaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Maquina> rt = cq.from(Maquina.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
