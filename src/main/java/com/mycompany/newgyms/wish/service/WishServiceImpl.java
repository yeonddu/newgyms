package com.mycompany.newgyms.wish.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.wish.dao.WishDAO;

@Service("wishService")
@Transactional(propagation=Propagation.REQUIRED)
public class WishServiceImpl implements WishService{
	
	private static final String String = null;
	@Autowired
	private WishDAO wishDAO;
	
	@Override
	public void addWishList(String product_id, String member_id) throws Exception{
		wishDAO.insertWishList(product_id, member_id);
	}
}
