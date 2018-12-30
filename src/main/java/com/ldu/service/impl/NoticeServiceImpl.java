package com.ldu.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.ldu.dao.NoticeMapper;
import com.ldu.pojo.Notice;
import com.ldu.pojo.NoticeExtend;
import com.ldu.service.NoticeService;

@Service("NoticeService")
public class NoticeServiceImpl implements NoticeService{
	 @Resource
	 private NoticeMapper noticeMapper;

	@Override
	public List<Notice> getNoticeList() {
		
		return noticeMapper.getNoticeList();
	}

	@Override
	public void insertSelective(Notice notice) {
		noticeMapper.insertSelective(notice);
		
	}




}
