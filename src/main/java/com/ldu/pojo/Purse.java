package com.ldu.pojo;

public class Purse {
	private Integer id;
	private Integer userId;
	private Float balance;//当前金额
	private Float recharge;//充值
	private Float withdrawals;//提现
	private Integer state;//申请状态
	
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
	public Float getBalance() {
		return balance;
	}
	public void setBalance(Float balance) {
		this.balance = balance;
	}
	public Float getRecharge() {
		return recharge;
	}
	public void setRecharge(Float recharge) {
		this.recharge = recharge;
	}
	public Float getWithdrawals() {
		return withdrawals;
	}
	public void setWithdrawals(Float withdrawals) {
		this.withdrawals = withdrawals;
	}
	
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "Purse [id=" + id + ", userId=" + userId + ", balance=" + balance + ", recharge=" + recharge
				+ ", withdrawals=" + withdrawals + ", state=" + state + "]";
	}
	

}
