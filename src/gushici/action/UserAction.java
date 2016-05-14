package gushici.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.User;

/**
 * 主页
 */
public class UserAction extends ActionSupport {
	private String suser_name;
	private String suser_password;

	public String getSuser_name() {
		return suser_name;
	}

	public void setSuser_name(String suser_name) {
		this.suser_name = suser_name;
	}

	public String getSuser_password() {
		return suser_password;
	}

	public void setSuser_password(String suser_password) {
		this.suser_password = suser_password;
	}

	public String login(){
		ActionContext actionContext = ActionContext.getContext();
		actionContext.put("pageTitle", "用户登录");
		return SUCCESS;
	}

	public String loginCheck() throws Exception {
		ActionContext actionContext = ActionContext.getContext();

		if(getSuser_name() == null) {
			actionContext.put("error_message", "请输入用户名");
			return ERROR;
		}

		if(getSuser_password() == null) {
			actionContext.put("error_message", "请输入密码");
			return ERROR;
		}

		if(getSuser_name().contains("'") || getSuser_password().contains("'")) {
			actionContext.put("error_message", "SQL注入死全家");
			return ERROR;
		}

		HibernateTool hibernateTool = new HibernateTool();
		User user = (User)hibernateTool.get(User.class, getSuser_name());

		if(user == null || !user.getSuser_password().equals(getSuser_password())) {
			actionContext.put("error_message", "用户名或密码错误");
			return ERROR;
		}

		actionContext.getSession().put("user", user);

		return SUCCESS;
	}

	public String home(){
		ActionContext actionContext = ActionContext.getContext();
		actionContext.put("pageTitle", "功能首页");
		return SUCCESS;
	}
}
