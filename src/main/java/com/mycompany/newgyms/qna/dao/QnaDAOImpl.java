package com.mycompany.newgyms.qna.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository("qnaDAO")
public class QnaDAOImpl implements QnaDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public ArrayList selectproductQuestionList(String product_id) throws DataAccessException{
		ArrayList questionList = new ArrayList();
		questionList=(ArrayList)sqlSession.selectList("mapper.qna.selectProductQuestionList",product_id);
		return questionList;
	}
	
	public ArrayList selectproductAnswerList(String product_id) throws DataAccessException{
		ArrayList answerList = new ArrayList();
		answerList=(ArrayList)sqlSession.selectList("mapper.qna.selectProductAnswerList",product_id);
		return answerList;
	}
	 
}
