package gushici.domain;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Jason Song(wolfogre.com) on 2016/5/21.
 */
@Entity
@Table(name = "shici_sentence")
public class Sentence {
	@Id
	private String ssen_content;

	public String getSsen_content() {
		return ssen_content;
	}

	public void setSsen_content(String ssen_content) {
		this.ssen_content = ssen_content;
	}
}
