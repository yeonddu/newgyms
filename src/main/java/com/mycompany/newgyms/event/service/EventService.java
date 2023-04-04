package com.mycompany.newgyms.event.service;

import java.util.List;
import java.util.Map;

import com.mycompany.newgyms.event.vo.EventVO;

public interface EventService {
	public List<EventVO> listEvents() throws Exception;
	public List<EventVO> sortEvent(String sort) throws Exception;
	public int addNewEvent(Map eventMap) throws Exception;
	public EventVO viewEvent(int event_no) throws Exception;
	public void modEvent(Map eventMap) throws Exception;
	public void removeEvent(int event_no) throws Exception;
}
