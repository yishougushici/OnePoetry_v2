package gushici.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.PushRecord;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 诗词查询
 */
public class SearchAction extends ActionSupport {
	private String s_data;
	private String s_type;

	public String getS_data() {
		return s_data;
	}

	public void setS_data(String s_data) {
		this.s_data = s_data;
}

	public String getS_type() {
		return s_type;
	}

	public void setS_type(String s_type) {
		this.s_type = s_type;
	}

	@Override
	public String execute() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		actionContext.put("pageTitle", "诗词查询");
		return SUCCESS;
	}

	public String result() throws Exception {
		ActionContext actionContext = ActionContext.getContext();

		HibernateTool hibernateTool = new HibernateTool();
		if(getS_data() == null || getS_type() == null || getS_data().isEmpty() || getS_type().isEmpty())
		{
			actionContext.put("error_message", "输入不能为空");
			return SUCCESS;
		}
		List<PushRecord> resultList = new ArrayList<>();
		try{
			//期号，诗词，作者，内容
			if(getS_type().equals("all"))
				resultList = hibernateTool.query(PushRecord.class,"select * from `shiciall` WHERE `诗词` like '%" + getS_data() + "%' or `作者` like '%" + getS_data() + "%' or `作者` like '%" + getS_data() + "%'");
			if(getS_type().equals("期号"))
				resultList = hibernateTool.query(PushRecord.class,"select * from `shiciall` WHERE `期号` = '" + getS_data() + "'");
			if(getS_type().equals("诗词"))
				resultList = hibernateTool.query(PushRecord.class,"select * from `shiciall` WHERE `诗词` = '" + getS_data() + "'");
			if(getS_type().equals("作者"))
				resultList = hibernateTool.query(PushRecord.class,"select * from `shiciall` WHERE `作者` = '" + getS_data() + "'");
			if(getS_type().equals("内容"))
				resultList = hibernateTool.query(PushRecord.class,"select * from `shiciall` WHERE `内容` = '" + getS_data() + "'");
		} catch(Exception ex){
			actionContext.put("error_message", ex.getMessage());
			return SUCCESS;
		}
		if(resultList.isEmpty())
		{
			actionContext.put("error_message", "找不到数据");
			return SUCCESS;
		}
		actionContext.put("resultList", resultList);
		return SUCCESS;
	}
}
