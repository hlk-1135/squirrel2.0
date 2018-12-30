package com.ldu.pojo;
/**
 * 订单
 * @author lyq
 *
 */
public class Orders {
	private Integer id;

	private Integer userId;
    
	private Goods goods;
	
	private Integer goodsId;

    private Long orderNum;
    
    private Float orderPrice;

    private Integer orderState;
    
    private String orderInformation;

    private String orderDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	
	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public Long getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Long orderNum) {
		this.orderNum = orderNum;
	}

	public Float getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(Float orderPrice) {
		this.orderPrice = orderPrice;
	}

	public Integer getOrderState() {
		return orderState;
	}

	public void setOrderState(Integer orderState) {
		this.orderState = orderState;
	}

	public String getOrderInformation() {
		return orderInformation;
	}

	public void setOrderInformation(String orderInformation) {
		this.orderInformation = orderInformation;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	@Override
	public String toString() {
		return "Orders [id=" + id + ", userId=" + userId + ", goods=" + goods + ", orderNum=" + orderNum
				+ ", orderPrice=" + orderPrice + ", orderState=" + orderState + ", orderInformation=" + orderInformation
				+ ", orderDate=" + orderDate + "]";
	}

	

	

}
