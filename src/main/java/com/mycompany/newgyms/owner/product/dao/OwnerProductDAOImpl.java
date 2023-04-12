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
	
	
	// 惑前 格废
	@Override
	public List selectOwnerProductList(Map condMap) throws DataAccessException {
		List ownerProductList = (List) sqlSession.selectList("mapper.owner_product.selectOwnerProductList", condMap);
		return ownerProductList;
	}
	
	@Override
	public String maxNumSelect(Map condMap) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.owner_product.maxNumSelect", condMap);
		return result;
	}
	
	private int selectProductID() throws DataAccessException{
		int product_id = sqlSession.selectOne("mapper.owner_product.selectProductID");
		return product_id;
		
	}
	
	@Override
	public int insertNewProduct(Map newProductMap) throws DataAccessException {
		int product_id = selectProductID();
		newProductMap.put("product_id", product_id);
		sqlSession.insert("mapper.owner_product.insertNewProduct",newProductMap);
		
		/*可记*/
		
		return product_id;
	}
	
	@Override
	public void insertProductOption(List<ProductOptVO> optionList)  throws DataAccessException {
		
		for(int i=0; i<optionList.size();i++){
			ProductOptVO productOptVO =(ProductOptVO)optionList.get(i);
			sqlSession.insert("mapper.owner_product.insertNewProductOption",productOptVO);
		}
	}
	
	@Override
	public void insertProductImage(List imageList)  throws DataAccessException {
		for(int i=0; i<imageList.size();i++){
			ProductImageVO productImageVO=(ProductImageVO)imageList.get(i);
			sqlSession.insert("mapper.owner_product.insertProductImage",productImageVO);
		}
	}
		
	//惑前 昏力
	@Override
	public void deleteProduct(int product_id) throws DataAccessException {
		sqlSession.delete("mapper.owner_product.deleteProduct", product_id);
	}
	

}
