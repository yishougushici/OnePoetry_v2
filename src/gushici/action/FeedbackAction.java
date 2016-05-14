package gushici.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.Feedback;
import gushici.domain.User;
import org.apache.struts2.ServletActionContext;

import java.sql.Date;

/**
 * 反馈建议
 */
public class FeedbackAction extends ActionSupport {
	private String petName;
	private String canPublic;
	private String feedback;

	public String getPetName() {
		return petName;
	}

	public void setPetName(String petName) {
		this.petName = petName;
	}

	public String getCanPublic() {
		return canPublic;
	}

	public void setCanPublic(String canPublic) {
		this.canPublic = canPublic;
	}

	public String getFeedback() {
		return feedback;
	}

	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}

	@Override
	public String execute() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		actionContext.put("pageTitle", "反馈建议");
		return SUCCESS;
	}

	public String add() throws Exception {
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		if(getPetName() == null || getPetName().isEmpty()) {
			ServletActionContext.getResponse().getWriter().write("请输入用户名");
			return null;
		}
		if(getPetName().contains("'")) {
			ServletActionContext.getResponse().getWriter().write("SQL注入死全家");
			return null;
		}

		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		if(getFeedback() == null || getFeedback().isEmpty()) {
			ServletActionContext.getResponse().getWriter().write("请输入反馈");
			return null;
		}
		if(getFeedback().contains("'")) {
			ServletActionContext.getResponse().getWriter().write("SQL注入死全家");
			return null;
		}

		HibernateTool hibernateTool = new HibernateTool();
		Feedback feedback = new Feedback();
		feedback.setSfb_user(getPetName());
		feedback.setSfb_public("true".equals(getCanPublic()));
		feedback.setSfb_content(getFeedback());
		feedback.setSfb_date(new Date(new java.util.Date().getTime()));
		hibernateTool.save(feedback);
		ServletActionContext.getResponse().getWriter().write("反馈成功");
		return null;
	}
}