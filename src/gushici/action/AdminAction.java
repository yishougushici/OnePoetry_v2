package gushici.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 管理员模式
 */
public class AdminAction  extends ActionSupport {
	private String admin;
	private String password;

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String execute() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if("fang".equals(getAdmin()) && "fang".equals(getPassword()))
			actionContext.getSession().put("admin", getAdmin());
		else
			return LOGIN;
		actionContext.put("pageTitle", "管理员模式");
		return SUCCESS;
	}

	public String feedback() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("admin") == null)
			return LOGIN;
		actionContext.put("pageTitle", "查看反馈");
		return SUCCESS;
	}

	public String recommend() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		actionContext.put("pageTitle", "查看推荐");
		return SUCCESS;
	}

	public String original() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("admin") == null)
			return LOGIN;
		actionContext.put("pageTitle", "查看原创");
		return SUCCESS;
	}

	public String update() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("admin") == null)
			return LOGIN;
		actionContext.put("pageTitle", "录入诗词");
		return SUCCESS;
	}
}
