package com.mycompany.newgyms.owner.product.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.owner.product.dao.OwnerProductDAO;
import com.mycompany.newgyms.product.vo.ProductImageVO;
import com.mycompany.newgyms.product.vo.ProductVO;

@Service("ownerProductService")
@Transactional(propagation = Propagation.REQUIRED)
public class OwnerProductServiceImpl implements OwnerProductService {
	@Autowired
	private OwnerProductDAO ownerProductDAO;
	
	@Override
	public List<ProductVO> ownerProductList(String member_id) throws Exception {
		List ownerProductList = ownerProductDAO.selectOwnerProductList(member_id);
		return ownerProductList;
	}
	
	@Override
	public int addNewProduct(Map newProductMap) throws Exception{
		int product_id = ownerProductDAO.insertNewProduct(newProductMap);
		/* ¿ÃπÃ¡ˆ
		ArrayList<ProductImageVO> imageList = (ArrayList)newProductMap.get("imageList");
		for(ProductImageVO productImageVO : imageList) {
			productImageVO.setProduct_id(product_id);
		}
		ownerProductDAO.insertProductImage(imageList);
		 * */
		return product_id;
	}
}
