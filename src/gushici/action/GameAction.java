package gushici.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.User;

/**
 * 诗词游戏
 */
public class GameAction extends ActionSupport {
	@Override
	public String execute() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("user") == null){
			return LOGIN;
		}
		actionContext.put("pageTitle", "诗词游戏");
		return SUCCESS;
	}
}
