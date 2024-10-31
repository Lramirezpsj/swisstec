
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
import logica.RegistroContenedores;
import logica.exceptions.NonexistentEntityException;


public class RegistroContenedoresJpaController implements Serializable {

    public RegistroContenedoresJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    public RegistroContenedoresJpaController() {
        emf = Persistence.createEntityManagerFactory("Swisstec_PU");
    }

    public void create(RegistroContenedores registroContenedores) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(registroContenedores);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(RegistroContenedores registroContenedores) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            registroContenedores = em.merge(registroContenedores);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = registroContenedores.getId_contenedor();
                if (findRegistroContenedores(id) == null) {
                    throw new NonexistentEntityException("The registroContenedores with id " + id + " no longer exists.");
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
            RegistroContenedores registroContenedores;
            try {
                registroContenedores = em.getReference(RegistroContenedores.class, id);
                registroContenedores.getId_contenedor();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The registroContenedores with id " + id + " no longer exists.", enfe);
            }
            em.remove(registroContenedores);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<RegistroContenedores> findRegistroContenedoresEntities() {
        return findRegistroContenedoresEntities(true, -1, -1);
    }

    public List<RegistroContenedores> findRegistroContenedoresEntities(int maxResults, int firstResult) {
        return findRegistroContenedoresEntities(false, maxResults, firstResult);
    }

    private List<RegistroContenedores> findRegistroContenedoresEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(RegistroContenedores.class));
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

    public RegistroContenedores findRegistroContenedores(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(RegistroContenedores.class, id);
        } finally {
            em.close();
        }
    }

    public int getRegistroContenedoresCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<RegistroContenedores> rt = cq.from(RegistroContenedores.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
