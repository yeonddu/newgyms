package com.mycompany.newgyms.cart.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("cartVO")
public class CartVO {
	private int cart_id;
	private int product_id;
	private String member_id;
	private String cart_option;
	private Date cart_entered_date;
	public int getCart_id() {
		return cart_id;
	}
	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getCart_option() {
		return cart_option;
	}
	public void setCart_option(String cart_option) {
		this.cart_option = cart_option;
	}
	public Date getCart_entered_date() {
		return cart_entered_date;
	}
	public void setCart_entered_date(Date cart_entered_date) {
		this.cart_entered_date = cart_entered_date;
	}
	
	
}
