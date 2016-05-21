package gushici.domain;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Jason Song(wolfogre.com) on 2016/5/21.
 */
@Entity
@Table(name = "shici_err")
public class Wrong {
	@Id
	private Integer serr_id;
	private String serr_content;
	private Integer serr_err_location;
	private String serr_correct_letter;
	private String serr_sf_title;
	private String serr_sf_auth;

	public Integer getSerr_id() {
		return serr_id;
	}

	public void setSerr_id(Integer serr_id) {
		this.serr_id = serr_id;
	}

	public String getSerr_content() {
		return serr_content;
	}

	public void setSerr_content(String serr_content) {
		this.serr_content = serr_content;
	}

	public Integer getSerr_err_location() {
		return serr_err_location;
	}

	public void setSerr_err_location(Integer serr_err_location) {
		this.serr_err_location = serr_err_location;
	}

	public String getSerr_correct_letter() {
		return serr_correct_letter;
	}

	public void setSerr_correct_letter(String serr_correct_letter) {
		this.serr_correct_letter = serr_correct_letter;
	}

	public String getSerr_sf_title() {
		return serr_sf_title;
	}

	public void setSerr_sf_title(String serr_sf_title) {
		this.serr_sf_title = serr_sf_title;
	}

	public String getSerr_sf_auth() {
		return serr_sf_auth;
	}

	public void setSerr_sf_auth(String serr_sf_auth) {
		this.serr_sf_auth = serr_sf_auth;
	}
}
