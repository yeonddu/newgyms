package com.mycompany.newgyms.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mycompany.newgyms.order.vo.OrderVO;

@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO{
	@Autowired
	private SqlSession sqlSession;
	
   @Override
   public String orderPoint(String member_id) throws DataAccessException {
      String result = sqlSession.selectOne("mapper.order.orderPoint", member_id);
       return result;
   }
   
   @Override
	public List<OrderVO> selectOrderProductList(Map orderMap) throws DataAccessException {
		List<OrderVO> myOrderList = sqlSession.selectList("mapper.order.selectOrderProductList",orderMap);
		return myOrderList;
	}

   @Override
   public int insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException{
		int order_id = selectOrderID()+1;
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO = (OrderVO)myOrderList.get(i);
			orderVO.setOrder_id(order_id);
			sqlSession.insert("mapper.order.insertNewOrder", orderVO);
		}
		return order_id;
	}
   
   private int selectOrderID() throws DataAccessException{
		return sqlSession.selectOne("mapper.order.selectOrderID");
		
	}
}
