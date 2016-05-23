package gushici.domain;


import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.sql.Date;

/**
 * Created by Jason Song(wolfogre.com) on 2016/4/24.
 */
@Entity
@Table(name = "shiciall")
@DynamicUpdate
@DynamicInsert
public class PushRecord {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int idNum;
	private int 期号;
	private String 诗词;
	private String 作者;
	@Type(type="org.hibernate.type.TextType")
	private String 内容;
	private Date 日期;

	public int getIdNum() {
		return idNum;
	}

	public void setIdNum(int idNum) {
		this.idNum = idNum;
	}

	public int get期号() {
		return 期号;
	}

	public void set期号(int 期号) {
		this.期号 = 期号;
	}

	public String get诗词() {
		return 诗词;
	}

	public void set诗词(String 诗词) {
		this.诗词 = 诗词;
	}

	public String get作者() {
		return 作者;
	}

	public void set作者(String 作者) {
		this.作者 = 作者;
	}

	public String get内容() {
		return 内容;
	}

	public void set内容(String 内容) {
		this.内容 = 内容;
	}

	public Date get日期() {
		return 日期;
	}

	public void set日期(Date 日期) {
		this.日期 = 日期;
	}
}
