package com.mycompany.newgyms.owner.product.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mycompany.newgyms.product.vo.ProductVO;

public interface OwnerProductDAO {
	public List<ProductVO> selectOwnerProductList(String member_id) throws DataAccessException;
	public int insertNewProduct(Map newProductMap) throws DataAccessException;
	public void insertProductOption(List optionList)  throws DataAccessException;
	public void insertProductImage(List fileList)  throws DataAccessException;

}
