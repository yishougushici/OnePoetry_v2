package gushici.action;

import com.opensymphony.xwork2.ActionSupport;

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
		return SUCCESS;
	}
}