package gushici.domain;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Calendar;

/**
 * Created by Jason Song(wolfogre.com) on 2016/5/16.
 */
@Entity
@Table(name = "shici_original")
@DynamicUpdate
@DynamicInsert
public class Original {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer sorin_id;
	private String sorin_title;
	private String sorin_auth;
	@Type(type="org.hibernate.type.TextType")
	private String sorin_content;
	@Type(type = "org.hibernate.type.TrueFalseType")
	private Boolean sorin_pass;
	private Calendar sorin_time;

	public Integer getSorin_id() {
		return sorin_id;
	}

	public void setSorin_id(Integer sorin_id) {
		this.sorin_id = sorin_id;
	}

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

	public Boolean getSorin_pass() {
		return sorin_pass;
	}

	public void setSorin_pass(Boolean sorin_pass) {
		this.sorin_pass = sorin_pass;
	}

	public Calendar getSorin_time() {
		return sorin_time;
	}

	public void setSorin_time(Calendar sorin_time) {
		this.sorin_time = sorin_time;
	}
}
