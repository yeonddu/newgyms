package com.mycompany.newgyms.qna.dao;

import java.util.ArrayList;

import org.springframework.dao.DataAccessException;

public interface QnaDAO {
	public ArrayList selectproductQuestionList(String product_id) throws DataAccessException;
	public ArrayList selectproductAnswerList(String product_id) throws DataAccessException;
}
