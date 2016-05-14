package gushici.domain;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Calendar;

/**
 * Created by Jason Song(wolfogre.com) on 2016/5/14.
 */
@Entity
@Table(name = "shici_recommend")
@DynamicUpdate
@DynamicInsert
public class Recommend {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public Integer srec_id;
	public String srec_title;
	public String srec_auth;
	@Type(type="org.hibernate.type.TextType")
	public String srec_content;
	@Type(type="org.hibernate.type.TextType")
	public String srec_reson;
	public String srec_suser;
	public Calendar srec_time;
	@Type(type = "org.hibernate.type.TrueFalseType")
	public Boolean srec_pass;

	public Integer getSrec_id() {
		return srec_id;
	}

	public void setSrec_id(Integer srec_id) {
		this.srec_id = srec_id;
	}

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

	public String getSrec_suser() {
		return srec_suser;
	}

	public void setSrec_suser(String srec_suser) {
		this.srec_suser = srec_suser;
	}

	public Calendar getSrec_time() {
		return srec_time;
	}

	public void setSrec_time(Calendar srec_time) {
		this.srec_time = srec_time;
	}

	public Boolean getSrec_pass() {
		return srec_pass;
	}

	public void setSrec_pass(Boolean srec_pass) {
		this.srec_pass = srec_pass;
	}
}
