package com.mycompany.newgyms.owner.product.service;

import com.mycompany.newgyms.product.vo.ProductVO;

import java.util.List;

public interface OwnerProductService {
	public List<ProductVO> ownerProductList(String member_id) throws Exception;
}
