package gushici.action.game;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import gushici.HibernateTool;
import gushici.domain.Sentence;
import gushici.domain.User;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

/**
 * 诗词游戏
 */
public class RoundAction extends ActionSupport {
	private Map<String, Object> dataMap;
	private String role;
	private String content;

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public RoundAction() {
		this.dataMap = new HashMap<>();
	}

	@Override
	public String execute() throws Exception {
		ActionContext actionContext = ActionContext.getContext();
		actionContext.getSession().remove("roundDialogue");
		if(actionContext.getSession().get("user") == null){
			return LOGIN;
		}
		User user = (User)(new HibernateTool()).get(User.class, ((User)actionContext.getSession().get("user")).getSuesr_name());
		actionContext.getSession().put("user", user);
		actionContext.getSession().put("score", user.getSuesr_sround_score());
		actionContext.put("pageTitle", "诗词接龙");
		actionContext.put("isGame", true);
		return SUCCESS;
	}

	public String checkSentence() throws Exception {
		dataMap.clear();

		ActionContext actionContext = ActionContext.getContext();
		RoundDialogue roundDialogue = (RoundDialogue)actionContext.getSession().get("roundDialogue");
		User user = (User)actionContext.getSession().get("user");

		if(roundDialogue == null){
			roundDialogue = new RoundDialogue();
		}

		if("match".equals(getRole())){
			roundDialogue.add(getContent(), false);
			actionContext.getSession().put("roundDialogue", roundDialogue);
			return SUCCESS;
		}

		if(!roundDialogue.isMyTurn()){
			dataMap.put("result",false);
			dataMap.put("reason","对方未答题");
			return SUCCESS;
		}

		if(!roundDialogue.empty() && roundDialogue.getLastCharacter() != getContent().toCharArray()[0]){
			dataMap.put("result",false);
			dataMap.put("reason","不符合接龙要求，第一个汉字应为\"" + roundDialogue.getLastCharacter() + "\"");
			return SUCCESS;
		}

		if(roundDialogue.isUsed(getContent())){
			dataMap.put("result",false);
			dataMap.put("reason","该句古诗词你已经用过");
			return SUCCESS;
		}

		HibernateTool hibernateTool = new HibernateTool();
		if(hibernateTool.get(Sentence.class,getContent()) != null){
			dataMap.put("result",true);
			roundDialogue.add(getContent(), true);
			actionContext.getSession().put("roundDialogue", roundDialogue);
			user.setSuesr_sround_score(user.getSuesr_sround_score() + 1);
			hibernateTool.update(user);
			actionContext.getSession().put("user", user);
			dataMap.put("score", user.getSuesr_sround_score());
			return SUCCESS;
		}

		dataMap.put("result",false);
		switch (isValidPoetry(getContent())){
			case -1:
				dataMap.put("reason","找不到这句古诗词");break;
			case 0:
				dataMap.put("reason","找不到这句古诗词");break;
			case 1:
				dataMap.put("result",true);break;
			case 2:
				dataMap.put("reason","找不到这句古诗词");break;
		}

		if((Boolean)dataMap.get("result"))
		{
			Sentence sentence = new Sentence();
			sentence.setSsen_content(getContent());
			hibernateTool.save(sentence);
			roundDialogue.add(getContent(), true);
			user.setSuesr_sround_score(user.getSuesr_sround_score() + 1);
			hibernateTool.update(user);
			actionContext.getSession().put("user", user);
			dataMap.put("score", user.getSuesr_sround_score());
			actionContext.getSession().put("roundDialogue", roundDialogue);
		}
		return SUCCESS;
	}

	public String timeout() throws Exception{
		dataMap.clear();
		ActionContext actionContext = ActionContext.getContext();
		User user = (User)actionContext.getSession().get("user");
		user.setSuesr__serr_score(Math.max(user.getSuesr__serr_score() - 1, 0));
		dataMap.put("score", user.getSuesr__serr_score());
		HibernateTool hibernateTool = new HibernateTool();
		hibernateTool.update(user);
		return SUCCESS;
	}

	public String restart() throws Exception{
		dataMap.clear();
		ActionContext actionContext = ActionContext.getContext();
		RoundDialogue roundDialogue = (RoundDialogue)actionContext.getSession().get("roundDialogue");
		roundDialogue.clear();
		actionContext.getSession().put("roundDialogue", roundDialogue);
		dataMap.put("result",true);
		return SUCCESS;
	}

	private int isValidPoetry(String poetry) throws UnsupportedEncodingException {
		String urlStr = "http://www.shicimingju.com/chaxun/shiju/"+ URLEncoder.encode(poetry, "utf8");
		try {
			URL url = new URL(urlStr);
			//发送请求
			URLConnection urlConnection = url.openConnection();
			InputStream inputStream = urlConnection.getInputStream();
			//读取内容
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream,"utf8"));

			String line;
			int recode = 0;

			while ((line = bufferedReader.readLine()) != null) {
				System.out.println(line);
				if (line.contains("、<em>"+poetry+"</em></li>")){
					return 1;
				}
				else if(line.contains("<em>"+poetry+"</em>")){
					recode=2;
				}
			}
			return recode;
		}
		catch(Exception e){
			e.printStackTrace();
			return -1;
		}
	}
}
