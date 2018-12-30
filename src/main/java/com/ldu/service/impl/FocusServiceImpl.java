package com.ldu.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ldu.dao.FocusMapper;
import com.ldu.pojo.Focus;
import com.ldu.service.FocusService;

@Service("focusService")
public class FocusServiceImpl implements FocusService {
	
	 @Resource
	 private FocusMapper focusMapper;

	 /**
	  * 根据用户id获取我的关注
	  */
	 public List<Focus> getFocusByUserId(Integer user_id) {
		List<Focus> focusList = focusMapper.getFocusByUserId(user_id);
				
        return focusList;
	}
	 
	 /*
	  * 根据用户id和关注id删除
	  */

	public void deleteFocusByUserIdAndGoodsId(Integer goods_id, Integer user_id) {
		
		focusMapper.deleteFocusByUserIdAndGoodsId(goods_id, user_id);
		
	}
	/*
	  * 添加我的关注
	  */
	public void addFocusByUserIdAndId(Integer goods_id, Integer user_id) {
		
		focusMapper.addFocusByUserIdAndGoodsId(goods_id,user_id);
		
	}

}
