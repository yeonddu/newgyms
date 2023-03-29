package com.mycompany.newgyms.product.service;

import java.util.List;
import java.util.Map;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.product.vo.ProductOptVO;
import com.mycompany.newgyms.product.vo.ProductVO;

public interface ProductService {
	public List<ProductVO> productList(Map listMap) throws Exception;

	public Map productDetail(int product_id) throws Exception;
	public MemberVO ownerDetail(String member_id) throws Exception;
	
	public List<ProductOptVO> productOptionList(int product_id) throws Exception;
	public Map productImage(int product_id) throws Exception;

	public List<ProductVO> productSorting(Map sortMap) throws Exception;
	public List<ProductVO> searchProduct(String searchWord) throws Exception;
	public List<ProductVO> searchProductByCondition(Map searchMap) throws Exception;
	
}
