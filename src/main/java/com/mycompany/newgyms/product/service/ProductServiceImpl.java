package com.mycompany.newgyms.product.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.product.dao.ProductDAO;
import com.mycompany.newgyms.product.vo.ProductImageVO;
import com.mycompany.newgyms.product.vo.ProductOptVO;
import com.mycompany.newgyms.product.vo.ProductVO;
import com.mycompany.newgyms.review.vo.ReviewVO;

@Service("productService")
@Transactional(propagation = Propagation.REQUIRED)
public class ProductServiceImpl implements ProductService {

	private static final String String = null;
	@Autowired
	private ProductDAO productDAO;

	public List<ProductVO> productList(Map listMap) throws Exception {
		List productList = productDAO.selectProductList(listMap);
		return productList;
	}

	public Map productDetail(int product_id) throws Exception {
		ProductVO productVO = productDAO.selectProductDetail(product_id);
		Map productMap = new HashMap();
		productMap.put("productVO", productVO);
		return productMap;
	}

	/* 옵션 */
	public List<ProductOptVO> productOptionList(int product_id) throws Exception {
		List<ProductOptVO> productOptList = productDAO.selectProductOptionList(product_id);
		return productOptList;
	}

	/* 이미지 */
	public Map productImage(int product_id) throws Exception {
		Map imageMap = productDAO.selectProductImage(product_id);
		return imageMap;
	}

	/* 사업자 정보 가져오기 */
	public MemberVO ownerDetail(String member_id) throws Exception {
		MemberVO memberVO = productDAO.selectOwnerDetail(member_id);
		return memberVO;
	}

	public List<ProductVO> productSorting(Map sortMap) throws Exception {
		List productList = productDAO.selectSortedProduct(sortMap);
		return productList;
	}

	public List<ProductVO> searchProduct(String searchWord) throws Exception {
		List productList = productDAO.selectProductBySearchWord(searchWord);
		return productList;
	}

	public List<ProductVO> searchProductByCondition(Map searchMap) throws Exception {
		List productList = productDAO.searchProductByCondition(searchMap);
		return productList;
	}

}