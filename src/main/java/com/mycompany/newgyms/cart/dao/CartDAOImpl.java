package com.mycompany.newgyms.cart.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mycompany.newgyms.cart.vo.CartVO;
import com.mycompany.newgyms.product.vo.ProductVO;

@Repository("cartDAO")
public class CartDAOImpl  implements  CartDAO{
	@Autowired
	private SqlSession sqlSession;
	
	//장바구니 목록 가져오기
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException {
		List<CartVO> cartList =(List)sqlSession.selectList("mapper.cart.selectCartList",cartVO);
		return cartList;
	}
	
	//장바구니 상품 정보 가져오기
	public List<ProductVO> selectProductList(List<CartVO> cartList) throws DataAccessException {
		List<ProductVO> myProductList;
		myProductList = sqlSession.selectList("mapper.cart.selectProductList",cartList);
		return myProductList;
	}
	
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException {
		String  result =sqlSession.selectOne("mapper.cart.selectCountInCart",cartVO);
		return Boolean.parseBoolean(result);
	}
	
	public void insertProductInCart(CartVO cartVO) throws DataAccessException{
		int cart_id=selectMaxCartId();
		cartVO.setCart_id(cart_id);
		sqlSession.insert("mapper.cart.insertProductInCart",cartVO);
	}
	
	private int selectMaxCartId() throws DataAccessException{
		int cart_id =sqlSession.selectOne("mapper.cart.selectMaxCartId");
		return cart_id;
	}

	
	public void updateCartProductOption(CartVO cartVO) throws DataAccessException{
		sqlSession.insert("mapper.cart.updateCartProductOption",cartVO);
	}
	

	public void deleteEachCartProduct(int cart_id) throws DataAccessException{
		sqlSession.delete("mapper.cart.deleteEachCartProduct",cart_id);
	}
	public void deleteCartProduct(Map cartMap) throws DataAccessException {
		sqlSession.delete("mapper.cart.deleteCartProduct",cartMap);
	}

}
