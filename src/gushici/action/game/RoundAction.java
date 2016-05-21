package gushici.action.game;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.User;

/**
 * 诗词游戏
 */
public class RoundAction extends ActionSupport {
	@Override
	public String execute() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("user") == null){
			return LOGIN;
		}
		User user = (User)(new HibernateTool()).get(User.class, ((User)actionContext.getSession().get("user")).getSuesr_name());
		actionContext.getSession().put("user", user);
		actionContext.put("score", user.getSuesr_sround_score());
		actionContext.put("pageTitle", "诗词接龙");
		return SUCCESS;
	}
}
