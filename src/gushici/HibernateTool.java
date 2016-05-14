package gushici;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

import java.lang.reflect.Type;
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

	public Object get(Class type, Object id) throws Exception {
		if(id instanceof Integer)
			return session.get(type, (Integer)id);
		if(id instanceof String)
			return session.get(type, (String)id);
		throw new Exception("Unknown type of id");
	}

	@Override
	protected void finalize() throws Throwable {
		super.finalize();
		session.close();
		sessionFactory.close();
	}
}
