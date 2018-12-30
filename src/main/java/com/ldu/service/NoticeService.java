package com.ldu.service;

import java.util.List;

import com.ldu.pojo.Notice;
import com.ldu.pojo.NoticeExtend;

public interface NoticeService {

	List<Notice> getNoticeList();
	
	public void insertSelective(Notice notice);
	
	



}
