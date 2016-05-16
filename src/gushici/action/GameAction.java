package gushici.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

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

	public String answer() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("user") == null){
			return LOGIN;
		}
		actionContext.put("pageTitle", "诗词问答");
		return SUCCESS;
	}

	public String wrong() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("user") == null){
			return LOGIN;
		}
		actionContext.put("pageTitle", "诗词找错");
		return SUCCESS;
	}

	public String round() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("user") == null){
			return LOGIN;
		}
		actionContext.put("pageTitle", "诗词接龙");
		return SUCCESS;
	}
}
