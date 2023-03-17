package com.mycompany.newgyms.cart.service;

import java.util.List;
import java.util.Map;

import com.mycompany.newgyms.cart.vo.CartVO;

public interface CartService {
	public Map<String ,List> myCartList(CartVO cartVO) throws Exception;
	/*
	public boolean findCartProduct(CartVO cartVO) throws Exception;
	public void addProductInCart(CartVO cartVO) throws Exception;
	public boolean modifyCartQty(CartVO cartVO) throws Exception;
	public void removeCartProduct(int cart_id) throws Exception;
	 */
}
