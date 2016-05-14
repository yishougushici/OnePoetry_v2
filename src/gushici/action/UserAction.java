package gushici.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.User;
import org.apache.struts2.ServletActionContext;

import java.io.IOException;

/**
 * 主页
 */
public class UserAction extends ActionSupport {
	private String suser_name;
	private String suser_password;
	private String suser_email;

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

	public String getSuser_email() {
		return suser_email;
	}

	public void setSuser_email(String suser_email) {
		this.suser_email = suser_email;
	}

	public String login(){
		ActionContext actionContext = ActionContext.getContext();
		actionContext.getSession().clear();
		actionContext.put("pageTitle", "用户登录");
		return SUCCESS;
	}

	public String loginCheck() throws Exception {
		ActionContext actionContext = ActionContext.getContext();

		if(getSuser_name() == null || getSuser_name().isEmpty()) {
			actionContext.put("error_message", "请输入用户名");
			return ERROR;
		}

		if(getSuser_password() == null || getSuser_password().isEmpty()) {
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

	public String register(){
		ActionContext actionContext = ActionContext.getContext();
		actionContext.put("pageTitle", "用户注册");
		return SUCCESS;
	}

	public String registerCheck(){
		ActionContext actionContext = ActionContext.getContext();

		if(getSuser_name() == null || getSuser_name().isEmpty()) {
			actionContext.put("error_message", "请输入用户名");
			return ERROR;
		}

		if(getSuser_password() == null || getSuser_password().isEmpty()) {
			actionContext.put("error_message", "请输入密码");
			return ERROR;
		}

		if(getSuser_email() == null || getSuser_email().isEmpty()) {
			actionContext.put("error_message", "请输入邮箱");
			return ERROR;
		}

		if(getSuser_name().contains("'") || getSuser_password().contains("'") || getSuser_email().contains("'")) {
			actionContext.put("error_message", "SQL注入死全家");
			return ERROR;
		}

		HibernateTool hibernateTool = new HibernateTool();
		User newUser = new User();
		newUser.setSuesr_name(getSuser_name());
		newUser.setSuser_password(getSuser_password());
		newUser.setSuser_email(getSuser_email());
		hibernateTool.save(newUser);
		return SUCCESS;
	}

	public String usernameCheck() throws Exception {
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		if(getSuser_name() == null || getSuser_name().isEmpty()) {
			ServletActionContext.getResponse().getWriter().write("请输入用户名");
			return null;
		}
		if(getSuser_name().contains("'")) {
			ServletActionContext.getResponse().getWriter().write("SQL注入死全家");
			return null;
		}
		HibernateTool hibernateTool = new HibernateTool();
		if(hibernateTool.get(User.class, getSuser_name()) == null){
			ServletActionContext.getResponse().getWriter().write("用户名可用");
			return null;
		}
		ServletActionContext.getResponse().getWriter().write("用户名已被注册");
		return null;
	}
}