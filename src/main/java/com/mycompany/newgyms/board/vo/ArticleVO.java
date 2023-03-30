package com.mycompany.newgyms.board.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;

import org.springframework.stereotype.Component;

@Component("ArticleVO")
public class ArticleVO {
	private int level;
	private int articleNO;
	private int parentNO;
	private String board_title;
	private String board_content;
	private String board_image;
	private Date board_write_date;
	private String member_id;
	
	public ArticleVO() {
		
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getArticleNO() {
		return articleNO;
	}

	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}

	public int getParentNO() {
		return parentNO;
	}

	public void setParentNO(int parentNO) {
		this.parentNO = parentNO;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public String getBoard_image() {
		try {
			if (board_image != null && board_image.length() != 0) {
				board_image = URLDecoder.decode(board_image, "UTF-8");	} 
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
		}
		return board_image;
	}

	public void setBoard_image(String board_image) {
		try {
			this.board_image = URLEncoder.encode(board_image, "UTF-8");
			// ���� �̸��� Ư�����ڰ� ���� ��� ���ڵ�
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
		}
		this.board_image = board_image;
	}

	public Date getBoard_write_date() {
		return board_write_date;
	}

	public void setBoard_write_date(Date board_write_date) {
		this.board_write_date = board_write_date;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	
}