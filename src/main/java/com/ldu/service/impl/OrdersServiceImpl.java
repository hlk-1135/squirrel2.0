package com.ldu.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.ldu.dao.OrdersMapper;
import com.ldu.pojo.Orders;
import com.ldu.service.OrdersService;

@Service("ordersService")
public class OrdersServiceImpl implements OrdersService {
	
	@Resource
	private OrdersMapper ordersMapper;

	public List<Orders> getOrdersByUserId(Integer user_id) {
		// TODO Auto-generated method stub
		List<Orders> orders=ordersMapper.selectOrdersByUserId(user_id);
		return orders;
	}

	@Override
	public List<Orders> getOrdersByUserAndGoods(Integer user_id) {
		// TODO Auto-generated method stub
		
		List<Orders> ordersOfSell=ordersMapper.selectOrdersByUserAndGoods(user_id);
		return ordersOfSell;
	}

	@Override
	public void addOrders(Orders orders) {
		// TODO Auto-generated method stub
		
		ordersMapper.addOrders(orders);
		
	}

	@Override
	public void deliverByOrderNum(Integer orderNum) {
		// TODO Auto-generated method stub
		ordersMapper.deliverByOrderNum(orderNum);
	}

	@Override
	public void receiptByOrderNum(Integer orderNum) {
		// TODO Auto-generated method stub
		ordersMapper.receiptByOrderNum(orderNum);
		
	}

	@Override
	public int getOrdersNum() {
		List<Orders> orders = ordersMapper.getOrdersList();
	    return orders.size();
	}

	@Override
	public List<Orders> getPageOrders(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Orders> list =ordersMapper.getOrdersList();
		return list;
	}

	@Override
	public Orders getOrdersById(int ordersId) {
		Orders orders = ordersMapper.selectById(ordersId);
	        return orders;
	}

	@Override
	public void updateByPrimaryKey(Integer id, Orders orders) {
			orders.setId(id);
	        this.ordersMapper.updateByPrimaryKey(orders);
		
	}

	@Override
	public void deleteOrdersByPrimaryKeys(int id) {
		 ordersMapper.deleteByPrimaryKeys(id);
	}

	@Override
	public List<Orders> getPageOrdersByOrders(Long orderNum, String orderInformation, Integer orderState, int pageNum,
			int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Orders> orders = ordersMapper.getPageOrdersByOrders(orderNum,orderInformation,orderState);
		return orders;
	}


}
