package gushici.action.game;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.Answer;
import gushici.domain.User;
import gushici.domain.Wrong;

import java.util.Map;
import java.util.Random;

/**
 * 诗词游戏
 */
public class WrongAction extends ActionSupport {

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
}
