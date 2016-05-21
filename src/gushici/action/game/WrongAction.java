package gushici.action.game;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.Answer;
import gushici.domain.User;
import gushici.domain.Wrong;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * 诗词游戏
 */
public class WrongAction extends ActionSupport {
	private Map<String, Object> dataMap;
	private Integer serr_err_location;

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	public Integer getSerr_err_location() {
		return serr_err_location;
	}

	public void setSerr_err_location(Integer serr_err_location) {
		this.serr_err_location = serr_err_location;
	}

	public WrongAction() {
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
		actionContext.put("score", user.getSuesr__serr_score());
		actionContext.put("pageTitle", "诗词找错");
		return SUCCESS;
	}

	public String getQuestion() throws Exception  {
		dataMap.clear();
		ActionContext actionContext = ActionContext.getContext();
		actionContext.getSession().remove("wrong");

		HibernateTool hibernateTool = new HibernateTool();
		Random random = new Random();
		int countRecord = hibernateTool.count(Wrong.class);

		int count = 0;
		Wrong wrong = new Wrong();
		while(++count < 20){
			wrong = (Wrong)hibernateTool.get(Wrong.class, random.nextInt(countRecord));
			if(wrong != null)
				break;
		}

		if(wrong == null){
			dataMap.put("error","服务器故障");
			return SUCCESS;
		}

		dataMap.put("serr_content",wrong.getSerr_content().toCharArray());
		dataMap.put("serr_sf_title",wrong.getSerr_sf_title());
		dataMap.put("serr_sf_auth",wrong.getSerr_sf_auth());

		actionContext.getSession().put("wrong", wrong);

		return SUCCESS;
	}

	public String submitAnswer() throws Exception  {
		dataMap.clear();
		ActionContext actionContext = ActionContext.getContext();
		Wrong wrong = (Wrong)actionContext.getSession().get("wrong");
		User user = (User)actionContext.getSession().get("user");

		if (wrong != null && wrong.getSerr_err_location().equals(getSerr_err_location())){
			user.setSuesr__serr_score(user.getSuesr__serr_score() + 1);
			HibernateTool hibernateTool = new HibernateTool();
			hibernateTool.update(user);
			actionContext.getSession().put("user", user);
			actionContext.getSession().remove("wrong");
			dataMap.put("result", true);
			dataMap.put("score", user.getSuesr__serr_score());
			return SUCCESS;
		}

		dataMap.put("result", false);
		dataMap.put("score", user.getSuesr__serr_score());

		return SUCCESS;
	}
}
