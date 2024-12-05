
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
import logica.Suministros;
import persistencia.exceptions.NonexistentEntityException;


public class SuministrosJpaController implements Serializable {

    public SuministrosJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    public SuministrosJpaController() {
        emf = Persistence.createEntityManagerFactory("Swisstec_PU");
    }

    public void create(Suministros suministros) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(suministros);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Suministros suministros) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            suministros = em.merge(suministros);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = suministros.getId_suministros();
                if (findsuministros(id) == null) {
                    throw new NonexistentEntityException("The suministros with id " + id + " no longer exists.");
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
            Suministros suministros;
            try {
                suministros = em.getReference(Suministros.class, id);
                suministros.getId_suministros();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The suministros with id " + id + " no longer exists.", enfe);
            }
            em.remove(suministros);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Suministros> findsuministrosEntities() {
        return findsuministrosEntities(true, -1, -1);
    }

    public List<Suministros> findsuministrosEntities(int maxResults, int firstResult) {
        return findsuministrosEntities(false, maxResults, firstResult);
    }

    private List<Suministros> findsuministrosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Suministros.class));
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

    public Suministros findsuministros(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Suministros.class, id);
        } finally {
            em.close();
        }
    }

    public int getsuministrosCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Suministros> rt = cq.from(Suministros.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
