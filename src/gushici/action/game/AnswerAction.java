package gushici.action.game;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.Answer;
import gushici.domain.User;
import org.apache.struts2.ServletActionContext;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * 诗词游戏
 */
public class AnswerAction extends ActionSupport {
	private Map<String, Object> dataMap;
	private String sa_tail;

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	public String getSa_tail() {
		return sa_tail;
	}

	public void setSa_tail(String sa_tail) {
		this.sa_tail = sa_tail;
	}

	public AnswerAction() {
		this.dataMap = new HashMap<>();
	}

	@Override
	public String execute() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("user") == null){
			return LOGIN;
		}
		User user = (User)(new HibernateTool()).get(User.class, ((User)actionContext.getSession().get("user")).getSuesr_name());
		actionContext.getSession().put("user", user);
		actionContext.getSession().put("score", user.getSuesr_sa_score());
		actionContext.put("pageTitle", "诗词问答");
		actionContext.put("isGame", true);
		return SUCCESS;
	}

	public String getQuestion() throws Exception  {
		dataMap.clear();
		ActionContext actionContext = ActionContext.getContext();
		actionContext.getSession().remove("answer");

		HibernateTool hibernateTool = new HibernateTool();
		Random random = new Random();
		//TODO:为降低难度只选取了前100条记录
		//int countRecord = hibernateTool.count(Answer.class);

		int count = 0;
		Answer answer = new Answer();
		while(++count < 20){
			//answer = (Answer)hibernateTool.get(Answer.class, random.nextInt(countRecord));
			answer = (Answer)hibernateTool.get(Answer.class, random.nextInt(100));
			if(answer != null)
				break;
		}

		if(answer == null){
			dataMap.put("error","服务器故障");
			return SUCCESS;
		}

		dataMap.put("sa_head",answer.getSa_head());
		dataMap.put("sa_title",answer.getSa_title());
		dataMap.put("sa_author",answer.getSa_author());

		actionContext.getSession().put("answer", answer);

		return SUCCESS;
	}

	public String submitAnswer() throws Exception  {
		dataMap.clear();
		ActionContext actionContext = ActionContext.getContext();
		Answer answer = (Answer)actionContext.getSession().get("answer");
		User user = (User)actionContext.getSession().get("user");

		if (answer != null && answer.getSa_tail().equals(getSa_tail())){
			user.setSuesr_sa_score(user.getSuesr_sa_score() + 1);
			HibernateTool hibernateTool = new HibernateTool();
			hibernateTool.update(user);
			actionContext.getSession().put("user", user);
			actionContext.getSession().remove("answer");
			dataMap.put("result", true);
			dataMap.put("score", user.getSuesr_sa_score());
			return SUCCESS;
		}

		user.setSuesr_sa_score(Math.max(user.getSuesr_sa_score() - 1, 0));
		HibernateTool hibernateTool = new HibernateTool();
		hibernateTool.update(user);
		dataMap.put("result", false);
		dataMap.put("score", user.getSuesr_sa_score());

		return SUCCESS;
	}

	public String timeout() throws Exception{
		dataMap.clear();
		ActionContext actionContext = ActionContext.getContext();
		User user = (User)actionContext.getSession().get("user");
		user.setSuesr_sa_score(Math.max(user.getSuesr_sa_score() - 1, 0));
		dataMap.put("score", user.getSuesr_sa_score());
		HibernateTool hibernateTool = new HibernateTool();
		hibernateTool.update(user);
		return SUCCESS;
	}
}
