package gushici.domain;

import javax.persistence.*;
import java.sql.Date;

/**
 * Created by Jason Song(wolfogre.com) on 2016/5/14.
 */
@Entity
@Table(name = "shici_feedback", schema = "shici")
public class ShiciFeedbackEntity {
	private Integer sfbId;
	private String sfbUser;
	private String sfbContent;
	private Date sfbDate;

	@Id
	@Column(name = "sfb_id")
	public Integer getSfbId() {
		return sfbId;
	}

	public void setSfbId(Integer sfbId) {
		this.sfbId = sfbId;
	}

	@Basic
	@Column(name = "sfb_user")
	public String getSfbUser() {
		return sfbUser;
	}

	public void setSfbUser(String sfbUser) {
		this.sfbUser = sfbUser;
	}

	@Basic
	@Column(name = "sfb_content")
	public String getSfbContent() {
		return sfbContent;
	}

	public void setSfbContent(String sfbContent) {
		this.sfbContent = sfbContent;
	}

	@Basic
	@Column(name = "sfb_date")
	public Date getSfbDate() {
		return sfbDate;
	}

	public void setSfbDate(Date sfbDate) {
		this.sfbDate = sfbDate;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		ShiciFeedbackEntity that = (ShiciFeedbackEntity) o;

		if (sfbId != null ? !sfbId.equals(that.sfbId) : that.sfbId != null) return false;
		if (sfbUser != null ? !sfbUser.equals(that.sfbUser) : that.sfbUser != null) return false;
		if (sfbContent != null ? !sfbContent.equals(that.sfbContent) : that.sfbContent != null) return false;
		if (sfbDate != null ? !sfbDate.equals(that.sfbDate) : that.sfbDate != null) return false;

		return true;
	}

	@Override
	public int hashCode() {
		int result = sfbId != null ? sfbId.hashCode() : 0;
		result = 31 * result + (sfbUser != null ? sfbUser.hashCode() : 0);
		result = 31 * result + (sfbContent != null ? sfbContent.hashCode() : 0);
		result = 31 * result + (sfbDate != null ? sfbDate.hashCode() : 0);
		return result;
	}
}
