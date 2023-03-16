package com.mycompany.newgyms.qna.service;

import java.util.List;

import com.mycompany.newgyms.qna.vo.QnaVO;

public interface QnaService {
	public List<QnaVO> productQuestionList(String product_id) throws Exception;
	public List<QnaVO> productAnswerList(String product_id) throws Exception;
}
