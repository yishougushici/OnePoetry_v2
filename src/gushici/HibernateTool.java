package gushici;

import org.hibernate.*;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Projections;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Jason Song(wolfogre.com) on 2016/5/7.
 */
public class HibernateTool {

	private SessionFactory sessionFactory;
	private Session session;

	public HibernateTool() {
		Configuration configuration = new Configuration().configure();
		ServiceRegistry serviceRegistry = new ServiceRegistryBuilder().applySettings(configuration.getProperties()).buildServiceRegistry();
		sessionFactory = configuration.buildSessionFactory(serviceRegistry);
		session = sessionFactory.openSession();
	}

	public List query(Class type, String queryString) {
		SQLQuery sqlQuery = session.createSQLQuery(queryString).addEntity(type);
		return sqlQuery.list();
	}

	public Object getOne(Class type, String queryString) {
		SQLQuery sqlQuery = session.createSQLQuery(queryString).addEntity(type);
		List result = sqlQuery.list();
		if(result.isEmpty())
			return null;
		return result.get(0);
	}

	public Object get(Class type, Object id) throws Exception {
		if(id instanceof Integer)
			return session.get(type, (Integer)id);
		if(id instanceof String)
			return session.get(type, (String)id);
		throw new Exception("Unknown type of id");
	}

	public Serializable save(Object obj) {
		Transaction transaction = session.beginTransaction();
		Serializable result = session.save(obj);
		transaction.commit();
		return  result;
	}

	public void update(Object obj) {
		Transaction transaction = session.beginTransaction();
		session.update(obj);
		transaction.commit();
	}

	public int count(Class type) {
		Criteria criteria = session.createCriteria(type);
		criteria.setProjection(Projections.rowCount());
		return  Integer.parseInt(criteria.uniqueResult().toString());
	}

	@Override
	protected void finalize() throws Throwable {
		super.finalize();
		session.close();
		sessionFactory.close();
	}
}
