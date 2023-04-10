package com.mycompany.newgyms.owner.product.service;

import java.util.List;

import com.mycompany.newgyms.owner.product.dao.OwnerProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.product.vo.ProductVO;

@Service("ownerProductService")
@Transactional(propagation = Propagation.REQUIRED)
public class OwnerProductServiceImpl implements OwnerProductService {
	@Autowired
	private OwnerProductDAO ownerProductDAO;
	
	public List<ProductVO> ownerProductList(String member_id) throws Exception {
		List ownerProductList = ownerProductDAO.selectOwnerProductList(member_id);
		return ownerProductList;
	}
}
