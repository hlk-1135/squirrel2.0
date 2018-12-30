package com.ldu.controller;

import com.ldu.pojo.User;
import com.ldu.service.UserService;
import com.ldu.util.UserGrid;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by lenovo on 2017/5/9.
 */
@Controller
public class MainController {

    @Resource
    private UserService userService;
    
	/*查找所有用户*/
	@RequestMapping(value = "/userList")
	@ResponseBody
	public UserGrid getUserList(@RequestParam("current") int current, @RequestParam("rowCount") int rowCount) {
		int total = userService.getUserNum();
		List<User> list = userService.getPageUser(current, rowCount);
		UserGrid userGrid = new UserGrid();
		userGrid.setCurrent(current);
		userGrid.setRowCount(rowCount);
		userGrid.setRows(list);
		userGrid.setTotal(total);
		return userGrid;
	}
}
