package gushici.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.Feedback;
import gushici.domain.Original;
import gushici.domain.PushRecord;
import gushici.domain.Recommend;

import java.sql.Date;
import java.text.SimpleDateFormat;
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
	private String id;
	private String mode;
	private String option;

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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
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
		dataMap.clear();
		HibernateTool hibernateTool = new HibernateTool();
		Feedback feedback = (Feedback)hibernateTool.get(Feedback.class, Integer.parseInt(getId()));
		if(feedback == null)
			dataMap.put("result", false);
		else{
			if("Y".equals(getOption())){
				feedback.setSfb_pass('Y');
				hibernateTool.update(feedback);
			}
			if("I".equals(getOption())){
				feedback.setSfb_pass('I');
				hibernateTool.update(feedback);
			}
			dataMap.put("result", true);
		}
		return SUCCESS;
	}

	public String getFeedback() throws Exception{
		dataMap.clear();
		HibernateTool hibernateTool = new HibernateTool();
		Feedback feedback = null;
		if("previous".equals(getMode())){
			feedback = (Feedback)hibernateTool.getOne(Feedback.class, "SELECT * FROM `shici_feedback` WHERE `sfb_pass` = 'N' AND `sfb_id` < " + Integer.parseInt(getId()));
		}
		if("next".equals(getMode())){
			feedback = (Feedback)hibernateTool.getOne(Feedback.class, "SELECT * FROM `shici_feedback` WHERE `sfb_pass` = 'N' AND `sfb_id` > " + Integer.parseInt(getId()));
		}
		if(feedback == null)
			dataMap.put("result", false);
		else{
			dataMap.put("result", true);
			HashMap<String ,Object> temp = new HashMap<>();
			temp.put("sfb_id", feedback.getSfb_id());
			temp.put("sfb_content", feedback.getSfb_content());
			temp.put("sfb_date", new SimpleDateFormat("yyyy年MM月dd日").format(feedback.getSfb_date()));
			temp.put("sfb_pass", feedback.getSfb_pass());
			temp.put("sfb_public", feedback.getSfb_public());
			temp.put("sfb_user", feedback.getSfb_user());
			dataMap.put("data", temp);
		}
		return SUCCESS;
	}

	public String setRecommend() throws Exception{
		dataMap.clear();
		HibernateTool hibernateTool = new HibernateTool();
		Recommend recommend = (Recommend)hibernateTool.get(Recommend.class, Integer.parseInt(getId()));
		if(recommend == null)
			dataMap.put("result", false);
		else{
			if("Y".equals(getOption())){
				recommend.setSrec_pass('Y');
				hibernateTool.update(recommend);
			}
			if("I".equals(getOption())){
				recommend.setSrec_pass('I');
				hibernateTool.update(recommend);
			}
			dataMap.put("result", true);
		}
		return SUCCESS;
	}

	public String getRecommend() throws Exception{
		dataMap.clear();
		HibernateTool hibernateTool = new HibernateTool();
		Recommend recommend = null;
		if("previous".equals(getMode())){
			recommend = (Recommend)hibernateTool.getOne(Recommend.class, "SELECT * FROM `shici_recommend` WHERE `srec_pass` = 'N' AND `srec_id` < " + Integer.parseInt(getId()));
		}
		if("next".equals(getMode())){
			recommend = (Recommend)hibernateTool.getOne(Recommend.class, "SELECT * FROM `shici_recommend` WHERE `srec_pass` = 'N' AND `srec_id` > " + Integer.parseInt(getId()));
		}
		if(recommend == null)
			dataMap.put("result", false);
		else{
			dataMap.put("result", true);
			HashMap<String ,Object> temp = new HashMap<>();
			temp.put("srec_auth", recommend.getSrec_auth());
			temp.put("srec_content", recommend.getSrec_content());
			temp.put("srec_time", new SimpleDateFormat("yyyy年MM月dd日").format(recommend.getSrec_time().getTime()));
			temp.put("srec_pass", recommend.getSrec_pass());
			temp.put("srec_reson", recommend.getSrec_reson());
			temp.put("srec_id", recommend.getSrec_id());
			temp.put("srec_title", recommend.getSrec_title());
			temp.put("srec_suser", recommend.getSrec_suser());
			dataMap.put("data", temp);
		}
		return SUCCESS;
	}

	public String setOriginal() throws Exception{
		dataMap.clear();
		HibernateTool hibernateTool = new HibernateTool();
		Original original = (Original)hibernateTool.get(Original.class, Integer.parseInt(getId()));
		if(original == null)
			dataMap.put("result", false);
		else{
			if("Y".equals(getOption())){
				original.setSorin_pass('Y');
				hibernateTool.update(original);
			}
			if("I".equals(getOption())){
				original.setSorin_pass('I');
				hibernateTool.update(original);
			}
			dataMap.put("result", true);
		}
		return SUCCESS;
	}

	public String getOriginal() throws Exception{
		dataMap.clear();
		HibernateTool hibernateTool = new HibernateTool();
		Original original = null;
		if("previous".equals(getMode())){
			original = (Original)hibernateTool.getOne(Original.class, "SELECT * FROM `shici_original` WHERE `sorin_pass` = 'N' AND `sorin_id` < " + Integer.parseInt(getId()));
		}
		if("next".equals(getMode())){
			original = (Original)hibernateTool.getOne(Original.class, "SELECT * FROM `shici_original` WHERE `sorin_pass` = 'N' AND `sorin_id` > " + Integer.parseInt(getId()));
		}
		if(original == null)
			dataMap.put("result", false);
		else{
			dataMap.put("result", true);
			HashMap<String ,Object> temp = new HashMap<>();
			temp.put("sorin_auth", original.getSorin_auth());
			temp.put("sorin_content", original.getSorin_content());
			temp.put("sorin_time", new SimpleDateFormat("yyyy年MM月dd日").format(original.getSorin_time().getTime()));
			temp.put("sorin_pass", original.getSorin_pass());
			temp.put("sorin_id", original.getSorin_id());
			temp.put("sorin_title", original.getSorin_title());
			dataMap.put("data", temp);
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
