package com.mycompany.newgyms.owner.product.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mycompany.newgyms.product.vo.ProductImageVO;
import com.mycompany.newgyms.product.vo.ProductOptVO;

@Repository("ownerProductDAO")
public class OwnerProductDAOImpl implements OwnerProductDAO {
	@Autowired
	private SqlSession sqlSession;
	
	// 상품 목록
	@Override
	public List selectOwnerProductList(String member_id) throws DataAccessException {
		List ownerProductList = (List) sqlSession.selectList("mapper.owner_product.selectOwnerProductList", member_id);
		return ownerProductList;
	}
	
	private int selectProductID() throws DataAccessException{
		int goods_id = sqlSession.selectOne("mapper.owner_product.selectProductID");
		return goods_id + 1;
		
	}
	
	@Override
	public int insertNewProduct(Map newProductMap) throws DataAccessException {
		int product_id = selectProductID();
		newProductMap.put("product_id", product_id);
		sqlSession.insert("mapper.owner_product.insertNewProduct",newProductMap);
		
		return product_id;
	}
	
	@Override
	public void insertProductOption(List optionList)  throws DataAccessException {
		for(int i=0; i<optionList.size();i++){
			ProductOptVO productOptVO=(ProductOptVO)optionList.get(i);
			sqlSession.insert("mapper.owner_product.insertProductOption",productOptVO);
		}
	}
	
	@Override
	public void insertProductImage(List imageList)  throws DataAccessException {
		for(int i=0; i<imageList.size();i++){
			ProductImageVO productImageVO=(ProductImageVO)imageList.get(i);
			sqlSession.insert("mapper.owner_product.insertProductImage",productImageVO);
		}
	}
		
}
