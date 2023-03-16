package com.mycompany.newgyms.review.dao;

import java.util.ArrayList;

import org.springframework.dao.DataAccessException;

public interface ReviewDAO {
	public ArrayList selectproductReviewList(String product_id) throws DataAccessException;
}
