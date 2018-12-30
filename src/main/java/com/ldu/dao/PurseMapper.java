package com.ldu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ldu.pojo.Purse;

public interface PurseMapper {
	
	public void updatePurseByuserId(Integer userId, Float balance);

	public void updatePurseOfdel(Integer userId, Float balance);

	public void addPurse(Integer userId);

	public Purse selectPurseByUserId(Integer user_id);

	public void updatePurse(Purse purse);

	public List<Purse> selectPurseList();

	public List<Purse> getPagePurseByPurse(@Param("userId")Integer userId,@Param("state")Integer state);

	public Purse selectPurseById(int id);

	public void updateByPrimaryKey(Purse purse);

	public void updatePurseById(Purse purse);

	


}
