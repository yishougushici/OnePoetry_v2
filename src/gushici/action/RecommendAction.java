package gushici.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.Recommend;
import gushici.domain.User;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletResponse;

/**
 * 诗词推荐
 */
public class RecommendAction  extends ActionSupport {
	public String srec_title;
	public String srec_auth;
	public String srec_content;
	public String srec_reson;

	public String getSrec_title() {
		return srec_title;
	}

	public void setSrec_title(String srec_title) {
		this.srec_title = srec_title;
	}

	public String getSrec_auth() {
		return srec_auth;
	}

	public void setSrec_auth(String srec_auth) {
		this.srec_auth = srec_auth;
	}

	public String getSrec_content() {
		return srec_content;
	}

	public void setSrec_content(String srec_content) {
		this.srec_content = srec_content;
	}

	public String getSrec_reson() {
		return srec_reson;
	}

	public void setSrec_reson(String srec_reson) {
		this.srec_reson = srec_reson;
	}

	@Override
	public String execute() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("user") == null){
			return LOGIN;
		}
		actionContext.put("pageTitle", "诗词推荐");
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
		if(getSrec_auth() == null || getSrec_content() == null || getSrec_reson() == null || getSrec_title() == null
				|| getSrec_auth().isEmpty() || getSrec_content().isEmpty() || getSrec_reson().isEmpty() || getSrec_title() == null){
			httpServletResponse.getWriter().write("输入不能为空");
			return null;
		}
		if(getSrec_auth().contains("'") || getSrec_content().contains("'") || getSrec_reson().contains("'") || getSrec_title().contains("'")){
			httpServletResponse.getWriter().write("SQL注入死全家");
			return null;
		}

		Recommend recommend = new Recommend();
		recommend.setSrec_auth(getSrec_auth());
		recommend.setSrec_content(getSrec_content());
		recommend.setSrec_reson(getSrec_reson());
		recommend.setSrec_title(getSrec_title());
		recommend.setSrec_suser(((User)actionContext.getSession().get("user")).getSuesr_name());

		(new HibernateTool()).save(recommend);
		httpServletResponse.getWriter().write("成功");
		return null;
	}
}
