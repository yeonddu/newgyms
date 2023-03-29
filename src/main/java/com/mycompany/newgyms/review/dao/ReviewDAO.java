package com.mycompany.newgyms.review.dao;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.dao.DataAccessException;

public interface ReviewDAO {
	public ArrayList selectproductReviewList(int product_id) throws DataAccessException;
	public ArrayList selectReviewList() throws DataAccessException;
	public Map<String, Object> selectReviewImage() throws DataAccessException;
}
