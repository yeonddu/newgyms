package com.mycompany.newgyms.wish.dao;

import org.springframework.stereotype.Repository;


public interface WishDAO {
	public void insertWishList(String product_id, String member_id) throws Exception;
}
