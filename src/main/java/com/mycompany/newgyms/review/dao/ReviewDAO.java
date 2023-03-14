package com.mycompany.newgyms.review.dao;

import java.util.ArrayList;

import org.springframework.dao.DataAccessException;

public interface ReviewDAO {
	public ArrayList selectproductReview(String product_id) throws DataAccessException;
}
