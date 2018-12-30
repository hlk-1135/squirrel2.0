package com.ldu.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.ldu.dao.PurseMapper;
import com.ldu.pojo.Purse;
import com.ldu.service.PurseService;

@Service("PurserService")
public class PurseServiceImpl implements PurseService{
	 @Resource
	 private PurseMapper perseMapper;


	@Override
	public void updatePurseByuserId(Integer userId, Float balance) {
		// TODO Auto-generated method stub
		perseMapper.updatePurseByuserId(userId, balance);
		
	}


	@Override
	public void updatePurseOfdel(Integer userId, Float balance) {
		// TODO Auto-generated method stub
		perseMapper.updatePurseOfdel(userId, balance);
	}


	@Override
	public void addPurse(Integer userId) {
		// TODO Auto-generated method stub
		perseMapper.addPurse(userId);
	}


	@Override
	public Purse getPurseByUserId(Integer user_id) {
		// TODO Auto-generated method stub
		return perseMapper.selectPurseByUserId(user_id);
	}


	@Override
	public void updatePurse(Purse purse) {
		// TODO Auto-generated method stub
		perseMapper.updatePurse(purse);
		
	}


	@Override
	public int getPurseNum() {
		List<Purse> purse= perseMapper.selectPurseList();
		return purse.size();
	}


	@Override
	public List<Purse> getPagePurse(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Purse> purse =perseMapper.selectPurseList();
		return purse;
	}


	@Override
	public List<Purse> getPagePurseByPurse(Integer userId,Integer state, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Purse> purse =perseMapper.getPagePurseByPurse(userId,state);
		return purse;
	}


	@Override
	public Purse getPurseById(int id) {
		return perseMapper.selectPurseById(id);
	}


	@Override
	public void updateByPrimaryKey(Integer id, Purse purse) {
		purse.setId(id);
		perseMapper.updateByPrimaryKey(purse);
		
	}


	@Override
	public void updatePursePassById(Integer id,Purse purse) {
		purse.setId(id);
		perseMapper.updatePurseById(purse);
		
	}


	@Override
	public void updatePurseRefuseById(Integer id,Purse purse) {
		purse.setId(id);
		perseMapper.updatePurseById(purse);
		
	}


}
