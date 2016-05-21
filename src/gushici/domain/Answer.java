package gushici.domain;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Jason Song(wolfogre.com) on 2016/5/21.
 */
@Entity
@Table(name = "shici_ans")
public class Answer {
	@Id
	private Integer sa_id;
	private String sa_head;
	private String sa_tail;
	private String sa_title;
	private String sa_author;

	public Integer getSa_id() {
		return sa_id;
	}

	public void setSa_id(Integer sa_id) {
		this.sa_id = sa_id;
	}

	public String getSa_head() {
		return sa_head;
	}

	public void setSa_head(String sa_head) {
		this.sa_head = sa_head;
	}

	public String getSa_tail() {
		return sa_tail;
	}

	public void setSa_tail(String sa_tail) {
		this.sa_tail = sa_tail;
	}

	public String getSa_title() {
		return sa_title;
	}

	public void setSa_title(String sa_title) {
		this.sa_title = sa_title;
	}

	public String getSa_author() {
		return sa_author;
	}

	public void setSa_author(String sa_author) {
		this.sa_author = sa_author;
	}
}
