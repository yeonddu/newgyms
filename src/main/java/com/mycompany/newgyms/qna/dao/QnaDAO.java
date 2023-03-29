package com.mycompany.newgyms.qna.dao;

import java.util.ArrayList;

import org.springframework.dao.DataAccessException;

public interface QnaDAO {
	public ArrayList selectproductQuestionList(int product_id) throws DataAccessException;
	public ArrayList selectproductAnswerList(int product_id) throws DataAccessException;
}
