package com.mycompany.newgyms.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.board.dao.BoardDAO;
import com.mycompany.newgyms.board.vo.ArticleVO;

@Service("boardService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO boardDAO;
	
	public List<ArticleVO> listArticles() throws Exception {
		List<ArticleVO> articlesList = boardDAO.selectAllArticlesList();
		return articlesList;
	}
	
	// 단일 이미지 추가하기
	@Override
	public int addNewArticle(Map articleMap) throws Exception {
		int articleNO = boardDAO.selectNewArticleNO();
		articleMap.put("articleNO", articleNO);
		boardDAO.insertNewArticle(articleMap);
		return articleNO;
	}
	
	// 단일 파일 보이기
	@Override
	public ArticleVO viewArticle(int articleNO) throws Exception {
		ArticleVO articleVO = boardDAO.selectArticle(articleNO);
		return articleVO;
	}
	
	@Override
	public void modArticle(Map articleMap) throws Exception {
		boardDAO.updateArticle(articleMap);
	}
	
	@Override
	public void removeArticle(int articleNO) throws Exception {
		boardDAO.deleteArticle(articleNO);
	}
}
