package com.ldu.pojo;
/**
 * 关注
 * @author lyq
 *
 */
public class Focus {
	
	private Integer id;

    private Integer goodsId;

    private Integer userId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Focus [id=" + id + ", goodsId=" + goodsId + ", userId=" + userId + "]";
	}
    
    


}
