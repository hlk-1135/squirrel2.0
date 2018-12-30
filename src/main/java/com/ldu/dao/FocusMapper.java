package com.ldu.dao;

import java.util.List;

import com.ldu.pojo.Focus;

public interface FocusMapper {
	
	 /**
     * 查询登录用户的所有关注商品
     * @param user_id
     * @return
     */
    public List<Focus> getFocusByUserId(Integer user_id);
    
    /**
     * 根据用户id和关注id删除关注的商品
     * @param id 关注id
     * @param user_id 用户id
     */
    
    public void deleteFocusByUserIdAndGoodsId(Integer goods_id,Integer user_id);

    /**
     * 添加关注
     * @param goods_id
     * @param user_id
     */
	public void addFocusByUserIdAndGoodsId(Integer goods_id, Integer user_id);

}
