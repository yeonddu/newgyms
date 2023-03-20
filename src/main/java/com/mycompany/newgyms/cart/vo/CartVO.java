package com.mycompany.newgyms.cart.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("cartVO")
public class CartVO {
	private int cart_id;
	private int product_id;
	private String member_id;
	private String cart_option_name;
	private String cart_option_price;
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
	
	public String getCart_option_name() {
		return cart_option_name;
	}
	public void setCart_option_name(String cart_option_name) {
		this.cart_option_name = cart_option_name;
	}
	public String getCart_option_price() {
		return cart_option_price;
	}
	public void setCart_option_price(String cart_option_price) {
		this.cart_option_price = cart_option_price;
	}
	public Date getCart_entered_date() {
		return cart_entered_date;
	}
	public void setCart_entered_date(Date cart_entered_date) {
		this.cart_entered_date = cart_entered_date;
	}
	
	
}
