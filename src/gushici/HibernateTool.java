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

	/**
	 * 对话工厂
	 */
	private SessionFactory sessionFactory;
	/**
	 * 对话
	 */
	private Session session;

	/**
	 * 构造函数
	 */
	public HibernateTool() {
		Configuration configuration = new Configuration().configure();
		ServiceRegistry serviceRegistry = new ServiceRegistryBuilder().applySettings(configuration.getProperties()).buildServiceRegistry();
		sessionFactory = configuration.buildSessionFactory(serviceRegistry);
		session = sessionFactory.openSession();
	}

	/**
	 * 查询数据库
	 * @param type 需要查询的持久化类
	 * @param queryString 查询语句
	 * @return 查询结果
	 */
	public List query(Class type, String queryString) {
		SQLQuery sqlQuery = session.createSQLQuery(queryString).addEntity(type);
		return sqlQuery.list();
	}

	/**
	 * 查询数据库,返回第一条符合条件的持久化对象
	 * @param type 需要查询的持久化类
	 * @param queryString 查询语句
	 * @return 查询结果
	 */
	public Object getOne(Class type, String queryString) {
		SQLQuery sqlQuery = session.createSQLQuery(queryString).addEntity(type);
		List result = sqlQuery.list();
		if(result.isEmpty())
			return null;
		return result.get(0);
	}

	/**
	 * 根据主键获取指定的持久化对象
	 * @param type 指定的持久化类
	 * @param id 主键
	 * @return 指定的持久化对象
	 * @throws Exception 未知的主键类型
	 */
	public Object get(Class type, Object id) throws Exception {
		if(id instanceof Integer)
			return session.get(type, (Integer)id);
		if(id instanceof String)
			return session.get(type, (String)id);
		throw new Exception("Unknown type of id");
	}

	/**
	 * 插入持久化对象
	 * @param obj 需要插入数据库的持久化对象
	 * @return 插入数据库的持久化对象的主键
	 */
	public Serializable save(Object obj) {
		Transaction transaction = session.beginTransaction();
		Serializable result = session.save(obj);
		transaction.commit();
		return  result;
	}

	/**
	 * 更新持久化对象
	 * @param obj 需要更新的持久化对象
	 */
	public void update(Object obj) {
		Transaction transaction = session.beginTransaction();
		session.update(obj);
		transaction.commit();
	}

	/**
	 * 统计指定的持久化类的持久化对象的个数
	 * @param type 指定的持久化类
	 * @return 个数
	 */
	public int count(Class type) {
		Criteria criteria = session.createCriteria(type);
		criteria.setProjection(Projections.rowCount());
		return  Integer.parseInt(criteria.uniqueResult().toString());
	}

	/**
	 * 释放资源
	 * @throws Throwable 释放资源失败
	 */
	@Override
	protected void finalize() throws Throwable {
		super.finalize();
		session.close();
		sessionFactory.close();
	}
}
