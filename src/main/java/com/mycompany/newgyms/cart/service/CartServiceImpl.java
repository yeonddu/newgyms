package com.mycompany.newgyms.cart.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.cart.dao.CartDAO;
import com.mycompany.newgyms.cart.vo.CartVO;
import com.mycompany.newgyms.product.vo.ProductVO;

@Service("cartService")
@Transactional(propagation=Propagation.REQUIRED)
public class CartServiceImpl  implements CartService{
	@Autowired
	private CartDAO cartDAO;
		
	public Map<String ,List> myCartList(CartVO cartVO) throws Exception{
		Map<String,List> cartMap=new HashMap<String,List>();
		
		//장바구니 목록 가져오기
		List<CartVO> myCartList=cartDAO.selectCartList(cartVO);
		if(myCartList.size()==0){ 
			System.out.println("장바구니가 비어있습니다.");
			return null;
		}
		
		//장바구니 상품 정보 가져오기
		List<ProductVO> myProductList=cartDAO.selectProductList(myCartList);
		cartMap.put("myCartList", myCartList);
		cartMap.put("myProductList",myProductList);
		return cartMap;
	}
	
	public boolean findCartProduct(CartVO cartVO) throws Exception{
		return cartDAO.selectCountInCart(cartVO);
	}	
	
	public void addProductInCart(CartVO cartVO) throws Exception{
		cartDAO.insertProductInCart(cartVO);
	}
	
	public boolean modifyCartOption(CartVO cartVO) throws Exception{
		boolean result=true;
		cartDAO.updateCartProductOption(cartVO);
		return result;
	}

	public void removeCartProduct(int cart_id) throws Exception{
		cartDAO.deleteCartProduct(cart_id);
	}
	
}
