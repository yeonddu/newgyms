package com.mycompany.newgyms.cart.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mycompany.newgyms.cart.vo.CartVO;
import com.mycompany.newgyms.product.vo.ProductVO;

public interface CartDAO {
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException;
	public List<ProductVO> selectProductList(List<CartVO> cartList) throws DataAccessException;
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException;
	public void insertProductInCart(CartVO cartVO) throws DataAccessException;
	public void updateCartProductOption(CartVO cartVO) throws DataAccessException;
	public void deleteCartProduct(int cart_id) throws DataAccessException;
}
