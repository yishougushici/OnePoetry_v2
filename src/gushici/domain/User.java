package gushici.domain;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Jason Song(wolfogre.com) on 2016/5/14.
 */
@Entity
@Table(name = "shici_user")
public class User {
	@Id
	private String suesr_name;
	private String suser_password;
	private String suser_email;
	private Integer suesr__serr_score;
	private Integer suesr_sa_score;
	private Integer suesr_sround_score;
	private String suser_introduce;

	public String getSuesr_name() {
		return suesr_name;
	}

	public void setSuesr_name(String suesr_name) {
		this.suesr_name = suesr_name;
	}

	public String getSuser_password() {
		return suser_password;
	}

	public void setSuser_password(String suser_password) {
		this.suser_password = suser_password;
	}

	public String getSuser_email() {
		return suser_email;
	}

	public void setSuser_email(String suser_email) {
		this.suser_email = suser_email;
	}

	public Integer getSuesr__serr_score() {
		return suesr__serr_score;
	}

	public void setSuesr__serr_score(Integer suesr__serr_score) {
		this.suesr__serr_score = suesr__serr_score;
	}

	public Integer getSuesr_sa_score() {
		return suesr_sa_score;
	}

	public void setSuesr_sa_score(Integer suesr_sa_score) {
		this.suesr_sa_score = suesr_sa_score;
	}

	public Integer getSuesr_sround_score() {
		return suesr_sround_score;
	}

	public void setSuesr_sround_score(Integer suesr_sround_score) {
		this.suesr_sround_score = suesr_sround_score;
	}

	public String getSuser_introduce() {
		return suser_introduce;
	}

	public void setSuser_introduce(String suser_introduce) {
		this.suser_introduce = suser_introduce;
	}
}
