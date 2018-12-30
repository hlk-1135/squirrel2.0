package com.ldu.service;

import java.util.List;
import com.ldu.pojo.CommentExtend;
import com.ldu.pojo.Comments;
import com.ldu.pojo.Goods;

public interface GoodsService {
    /**
     * 发布商品
     * @param goods
     * @param duration 允许上架时长
     */
    public int addGood(Goods goods , Integer duration);

    /**
     * 通过主键获取商品
     * @param goodsId
     * @return
     */
    public Goods getGoodsByPrimaryKey(Integer goodsId);
    
    public Goods getGoodsById(Integer goodsId);

    /**
     * 更新商品信息
     * @param goods
     */
    public void updateGoodsByPrimaryKeyWithBLOBs(int goodsId ,Goods goods);

    /**
     * 通过主键删除商品
     * @param id
     */
    public void deleteGoodsByPrimaryKey(Integer id);//更新
    
    public void deleteGoodsByPrimaryKeys(Integer id);//删除

    /**
     * 获取所有商品信息
     */
    public List<Goods> getAllGoods();

    List<Goods> searchGoods(String name, String describle);

    /**
     * 通过最新发布分类获取商品信息
     */
    public List<Goods> getGoodsByStr(Integer limit,String name,String describle);

    /**
     * 通过商品分类获取商品信息
     */
    public List<Goods> getGoodsByCatelog(Integer id,String name,String describle);

    
    /**
     * 获取 最新发布 物品，根据时间排序,获取前limit个结果
     * @param limit
     * @return
     */
    public List<Goods> getGoodsOrderByDate(Integer limit);
    /**
     * 根据分类id,并进行时间排序,获取前limit个结果
     * @param catelogId
     * @param limit
     * @return
     */
    public List<Goods> getGoodsByCatelogOrderByDate(Integer catelogId,Integer limit);

    /**
     * 根据用户的id，查询出该用户的所有闲置
     * @param user_id
     * @return
     */
    public List<Goods> getGoodsByUserId(Integer user_id);

    /**
     * 提交订单时，根据goodsId修改商品状态
     * @param goods
     */
	public void updateGoodsByGoodsId(Goods goods);
	
	/**
	 * 获取商品数
	 * @return
	 */
	public int getGoodsNum();

	public List<Goods> getPageGoods(int pageNum, int pageSize);
	
	/**
	 * 模糊查询
	 * @param id
	 * @param name
	 * @param form
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public List<Goods> getPageGoodsByGoods(Integer id, String name, Integer form, int pageNum, int pageSize);

	
	public CommentExtend selectCommentsByGoodsId(Integer id);
	
	/**
	 * 新增评论
	 * @param id
	 */
	public void addComments(Comments comments);

}