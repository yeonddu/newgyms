package com.mycompany.newgyms.board.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mycompany.newgyms.board.vo.ArticleVO;

public interface BoardDAO {
	public List selectAllArticlesList() throws DataAccessException;
	public int insertNewArticle(Map articleMap) throws DataAccessException;

	public ArticleVO selectArticle(int articleNO) throws DataAccessException;
	public void updateArticle(Map articleMap) throws DataAccessException;
	public void deleteArticle(int articleNO) throws DataAccessException;
	
	public List selectImageFileList(int articleNO) throws DataAccessException;
	public int selectNewArticleNO() throws DataAccessException;
	public int selectNewImageFileNO() throws DataAccessException;

}