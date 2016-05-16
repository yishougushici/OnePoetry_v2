package gushici.action;


import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.Original;
import gushici.domain.Recommend;
import gushici.domain.User;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletResponse;

/**
 * 原创诗词
 */
public class OriginalAction extends ActionSupport {
	public String sorin_title;
	public String sorin_auth;
	public String sorin_content;

	public String getSorin_title() {
		return sorin_title;
	}

	public void setSorin_title(String sorin_title) {
		this.sorin_title = sorin_title;
	}

	public String getSorin_auth() {
		return sorin_auth;
	}

	public void setSorin_auth(String sorin_auth) {
		this.sorin_auth = sorin_auth;
	}

	public String getSorin_content() {
		return sorin_content;
	}

	public void setSorin_content(String sorin_content) {
		this.sorin_content = sorin_content;
	}

	@Override
	public String execute() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("user") == null){
			return LOGIN;
		}
		actionContext.put("pageTitle", "原创投稿");
		return SUCCESS;
	}

	public String add() throws Exception {
		HttpServletResponse httpServletResponse =  ServletActionContext.getResponse();
		httpServletResponse.setContentType("text/html;charset=UTF-8");
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("user") == null){
			httpServletResponse.getWriter().write("登录已过期");
			return null;
		}
		if(getSorin_auth() == null || getSorin_content() == null || getSorin_title() == null
				|| getSorin_auth().isEmpty() || getSorin_content().isEmpty() || getSorin_title().isEmpty()){
			httpServletResponse.getWriter().write("输入不能为空");
			return null;
		}
		if(getSorin_auth().contains("'") || getSorin_content().contains("'") || getSorin_title().contains("'")){
			httpServletResponse.getWriter().write("SQL注入死全家");
			return null;
		}

		Original original = new Original();
		original.setSorin_auth(getSorin_auth());
		original.setSorin_content(getSorin_content());
		original.setSorin_title(getSorin_title());

		(new HibernateTool()).save(original);
		httpServletResponse.getWriter().write("成功");
		return null;
	}
}
