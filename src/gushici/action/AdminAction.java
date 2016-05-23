package gushici.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.Feedback;
import gushici.domain.Original;
import gushici.domain.PushRecord;
import gushici.domain.Recommend;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 管理员模式
 */
public class AdminAction  extends ActionSupport {
	private Map<String, Object> dataMap;
	private String admin;
	private String password;
	private String scnum;
	private String sctitle;
	private String scauto;
	private String scdate;
	private String sccontent;

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

	public String getScnum() {
		return scnum;
	}

	public void setScnum(String scnum) {
		this.scnum = scnum;
	}

	public String getSctitle() {
		return sctitle;
	}

	public void setSctitle(String sctitle) {
		this.sctitle = sctitle;
	}

	public String getScauto() {
		return scauto;
	}

	public void setScauto(String scauto) {
		this.scauto = scauto;
	}

	public String getScdate() {
		return scdate;
	}

	public void setScdate(String scdate) {
		this.scdate = scdate;
	}

	public String getSccontent() {
		return sccontent;
	}

	public void setSccontent(String sccontent) {
		this.sccontent = sccontent;
	}

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	public AdminAction(){
		this.dataMap = new HashMap<>();
	}

	@Override
	public String execute() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		if(actionContext.getSession().get("admin") == null)
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

	public String setFeedback() throws Exception{
		return SUCCESS;
	}

	public String getFeedback() throws Exception{
		dataMap.clear();
		HibernateTool hibernateTool = new HibernateTool();
		Feedback feedback = (Feedback)hibernateTool.getOne(Feedback.class, "SELECT * FROM `shici_feedback` WHERE `sfb_pass` = 'N'");
		if(feedback == null)
			dataMap.put("result", false);
		else{
			dataMap.put("result", true);
			dataMap.put("date", feedback);
		}
		return SUCCESS;
	}

	public String setRecommend() throws Exception{
		return SUCCESS;
	}

	public String getRecommend() throws Exception{
		dataMap.clear();
		HibernateTool hibernateTool = new HibernateTool();
		Recommend recommend = (Recommend)hibernateTool.getOne(Recommend.class, "SELECT * FROM `shici_recommend` WHERE `srec_pass` = 'N'");
		if(recommend == null)
			dataMap.put("result", false);
		else{
			dataMap.put("result", true);
			dataMap.put("date", recommend);
		}
		return SUCCESS;
	}

	public String setOriginal() throws Exception{
		return SUCCESS;
	}

	public String getOriginal() throws Exception{
		dataMap.clear();
		HibernateTool hibernateTool = new HibernateTool();
		Original original = (Original)hibernateTool.getOne(Original.class, "SELECT * FROM `shici_original` WHERE `sorin_pass` = 'N'");
		if(original == null)
			dataMap.put("result", false);
		else{
			dataMap.put("result", true);
			dataMap.put("date", original);
		}
		return SUCCESS;
	}

	public String submitUpdate() throws Exception{
		//TODO:赶工，没有对参数二次验证
		dataMap.clear();
		PushRecord newPushRecord = new PushRecord();
		newPushRecord.set期号(Integer.parseInt(getScnum()));
		newPushRecord.set诗词(getSctitle());
		newPushRecord.set作者(getScauto());
		newPushRecord.set内容(getSccontent());
		newPushRecord.set日期(java.sql.Date.valueOf((getScdate())));
		HibernateTool hibernateTool = new HibernateTool();
		hibernateTool.save(newPushRecord);
		dataMap.put("result", true);
		return SUCCESS;
	}


}
