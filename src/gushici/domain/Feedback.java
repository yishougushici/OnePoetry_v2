package gushici.domain;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.Date;

/**
 * Created by Jason Song(wolfogre.com) on 2016/5/14.
 */
@Entity
@Table(name = "shici_feedback")
public class Feedback {
	@Id
	private Integer sfb_id;
	private String sfb_user;
	private String sfb_content;
	private Date sfb_date;

	public Integer getSfb_id() {
		return sfb_id;
	}

	public void setSfb_id(Integer sfb_id) {
		this.sfb_id = sfb_id;
	}

	public String getSfb_user() {
		return sfb_user;
	}

	public void setSfb_user(String sfb_user) {
		this.sfb_user = sfb_user;
	}

	public String getSfb_content() {
		return sfb_content;
	}

	public void setSfb_content(String sfb_content) {
		this.sfb_content = sfb_content;
	}

	public Date getSfb_date() {
		return sfb_date;
	}

	public void setSfb_date(Date sfb_date) {
		this.sfb_date = sfb_date;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		Feedback feedback = (Feedback) o;

		if (sfb_id != null ? !sfb_id.equals(feedback.sfb_id) : feedback.sfb_id != null) return false;
		if (sfb_user != null ? !sfb_user.equals(feedback.sfb_user) : feedback.sfb_user != null) return false;
		if (sfb_content != null ? !sfb_content.equals(feedback.sfb_content) : feedback.sfb_content != null)
			return false;
		return sfb_date != null ? sfb_date.equals(feedback.sfb_date) : feedback.sfb_date == null;

	}

	@Override
	public int hashCode() {
		int result = sfb_id != null ? sfb_id.hashCode() : 0;
		result = 31 * result + (sfb_user != null ? sfb_user.hashCode() : 0);
		result = 31 * result + (sfb_content != null ? sfb_content.hashCode() : 0);
		result = 31 * result + (sfb_date != null ? sfb_date.hashCode() : 0);
		return result;
	}
}
