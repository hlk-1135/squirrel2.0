package com.ldu.controller;

import com.ldu.pojo.Focus;
import com.ldu.pojo.Goods;
import com.ldu.pojo.GoodsExtend;
import com.ldu.pojo.Image;
import com.ldu.pojo.Notice;
import com.ldu.pojo.NoticeExtend;
import com.ldu.pojo.Purse;
import com.ldu.pojo.User;
import com.ldu.service.FocusService;
import com.ldu.service.GoodsService;
import com.ldu.service.ImageService;
import com.ldu.service.NoticeService;
import com.ldu.service.PurseService;
import com.ldu.service.UserService;
import com.ldu.util.DateUtil;
import com.ldu.util.MD5;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "/user")
public class UserController {

	@Resource
	private UserService userService;
	@Resource
	private GoodsService goodsService;
	@Resource
	private ImageService imageService;

	@Resource
	private FocusService focusService;

	@Resource
	private PurseService purseService;
	
	@Resource
	private NoticeService noticeService;

	/**
	 * 用户注册
	 * 
	 * @param user1
	 * @return
	 */
	@RequestMapping(value = "/addUser")
	public String addUser(HttpServletRequest request, @ModelAttribute("user") User user1) {
		String url = request.getHeader("Referer");
		User user = userService.getUserByPhone(user1.getPhone());
		if (user == null) {// 检测该用户是否已经注册
			String t = DateUtil.getNowDate();
			// 对密码进行MD5加密
			String str = MD5.md5(user1.getPassword());
			user1.setCreateAt(t);// 创建开始时间
			user1.setPassword(str);
			user1.setGoodsNum(0);
			user1.setStatus((byte) 1);//初始正常状态
			user1.setPower(100);
			userService.addUser(user1);
			purseService.addPurse(user1.getId());// 注册的时候同时生成钱包
		}
		return "redirect:" + url;
	}
	
	/**
	 * 注册验证账号
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/register",method = RequestMethod.POST)
	@ResponseBody
	public String register(HttpServletRequest request){
		String phone=request.getParameter("phone");
		User user = userService.getUserByPhone(phone);
		if(user==null) {
			return "{\"success\":true,\"flag\":false}";//用户存在，注册失败
		}else {
			return "{\"success\":true,\"flag\":true}";//用户不存在，可以注册
		}
	}
	
	/**
	 * 登陆验证密码
	 * @param request
	 * @return
	 */
	/*@RequestMapping(value = "/password",method = RequestMethod.POST)
	@ResponseBody
	public String password(HttpServletRequest request){
		String phone=request.getParameter("phone");
		String password=request.getParameter("password");
		if((phone==null||phone=="")&&(password==null||password=="")) {
			return "{\"success\":false,\"flag\":true}";
		}else {
			User user = userService.getUserByPhone(phone);
			if(user==null) {
				return "{\"success\":false,\"flag\":false}";//账号错误
			}
			String pwd = MD5.md5(password);
			if (pwd.equals(user.getPassword())) {
				return "{\"success\":true,\"flag\":false}";//密码正确
			}else {
				return "{\"success\":true,\"flag\":true}";//密码错误
			}
		}
		
	}*/
	

	/**
	 * 验证登录
	 * @param request
	 * @param user
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/login")
	public ModelAndView loginValidate(HttpServletRequest request, HttpServletResponse response, User user,
			ModelMap modelMap) {
		User cur_user = userService.getUserByPhone(user.getPhone());
		String url = request.getHeader("Referer");
		if (cur_user != null) {
			String pwd = MD5.md5(user.getPassword());
			if (pwd.equals(cur_user.getPassword())) {
				if(cur_user.getStatus()==1) {
				request.getSession().setAttribute("cur_user", cur_user);
				return new ModelAndView("redirect:" + url);
				}
			}
		}
		return new ModelAndView("redirect:" + url);
	}

	/**
	 * 更改用户名
	 * 
	 * @param request
	 * @param user
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/changeName")
	public ModelAndView changeName(HttpServletRequest request, User user, ModelMap modelMap) {
		String url = request.getHeader("Referer");
		// 从session中获取出当前用户
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		cur_user.setUsername(user.getUsername());// 更改当前用户的用户名
		userService.updateUserName(cur_user);// 执行修改操作
		request.getSession().setAttribute("cur_user", cur_user);// 修改session值
		return new ModelAndView("redirect:" + url);
	}

	/**
	 * 完善或修改信息
	 * 
	 * @param request
	 * @param user
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/updateInfo")
	public ModelAndView updateInfo(HttpServletRequest request, User user, ModelMap modelMap) {
		// 从session中获取出当前用户
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		cur_user.setUsername(user.getUsername());
		cur_user.setQq(user.getQq());
		userService.updateUserName(cur_user);// 执行修改操作
		request.getSession().setAttribute("cur_user", cur_user);// 修改session值
		return new ModelAndView("redirect:/user/basic");
	}

	/**
	 * 用户退出
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().setAttribute("cur_user", null);
		return "redirect:/goods/homeGoods";
	}

	/**
	 * 个人中心
	 * 
	 * @return
	 */
	@RequestMapping(value = "/home")
	public ModelAndView home(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer userId = cur_user.getId();
		int size=5;
		Purse myPurse = purseService.getPurseByUserId(userId);
		List<User> users=userService.getUserOrderByDate(size);
		List<Notice> notice=noticeService.getNoticeList();
		mv.addObject("notice", notice);
		mv.addObject("myPurse", myPurse);
		mv.addObject("users", users);
		mv.setViewName("/user/home");
		return mv;
	}

	/**
	 * 个人信息设置
	 * 
	 * @return
	 */
	@RequestMapping(value = "/basic")
	public ModelAndView basic(HttpServletRequest request) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer userId = cur_user.getId();
		Purse myPurse = purseService.getPurseByUserId(userId);
		ModelAndView mv = new ModelAndView();
		mv.addObject("myPurse", myPurse);
		mv.setViewName("/user/basic");
		return mv;
	}

	/**
	 * 我的闲置 查询出所有的用户商品以及商品对应的图片
	 * 
	 * @return 返回的model为 goodsAndImage对象,该对象中包含goods 和 images，参考相应的类
	 */
	@RequestMapping(value = "/allGoods")
	public ModelAndView goods(HttpServletRequest request) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer userId = cur_user.getId();
		List<Goods> goodsList = goodsService.getGoodsByUserId(userId);
		List<GoodsExtend> goodsAndImage = new ArrayList<GoodsExtend>();
		for (int i = 0; i < goodsList.size(); i++) {
			// 将用户信息和image信息封装到GoodsExtend类中，传给前台
			GoodsExtend goodsExtend = new GoodsExtend();
			Goods goods = goodsList.get(i);
			List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
			goodsExtend.setGoods(goods);
			goodsExtend.setImages(images);
			goodsAndImage.add(i, goodsExtend);
		}
		Purse myPurse = purseService.getPurseByUserId(userId);
		ModelAndView mv = new ModelAndView();
		mv.addObject("goodsAndImage", goodsAndImage);
		mv.setViewName("/user/goods");
		mv.addObject("myPurse", myPurse);
		return mv;
	}

	/**
	 * 我的关注 查询出所有的用户商品以及商品对应的图片
	 * 
	 * @return 返回的model为 goodsAndImage对象,该对象中包含goods 和 images，参考相应的类
	 */
	@RequestMapping(value = "/allFocus")
	public ModelAndView focus(HttpServletRequest request) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer userId = cur_user.getId();
		List<Focus> focusList = focusService.getFocusByUserId(userId);
		List<GoodsExtend> goodsAndImage = new ArrayList<GoodsExtend>();
		for (int i = 0; i < focusList.size(); i++) {
			// 将用户信息和image信息封装到GoodsExtend类中，传给前台
			GoodsExtend goodsExtend = new GoodsExtend();
			Focus focus = focusList.get(i);
			Goods goods = goodsService.getGoodsByPrimaryKey(focus.getGoodsId());
			List<Image> images = imageService.getImagesByGoodsPrimaryKey(focus.getGoodsId());
			goodsExtend.setGoods(goods);
			goodsExtend.setImages(images);
			goodsAndImage.add(i, goodsExtend);
		}
		Purse myPurse = purseService.getPurseByUserId(userId);
		ModelAndView mv = new ModelAndView();
		mv.addObject("goodsAndImage", goodsAndImage);
		mv.addObject("myPurse", myPurse);
		mv.setViewName("/user/focus");
		return mv;
	}

	/**
	 * 删除我的关注
	 * @return
	 */
	@RequestMapping(value = "/deleteFocus/{id}")
	public String deleteFocus(HttpServletRequest request, @PathVariable("id") Integer goods_id) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer user_id = cur_user.getId();
		focusService.deleteFocusByUserIdAndGoodsId(goods_id, user_id);

		return "redirect:/user/allFocus";

	}

	/**
	 * 添加我的关注
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addFocus/{id}")
	public String addFocus(HttpServletRequest request, @PathVariable("id") Integer goods_id) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer user_id = cur_user.getId();
		List<Focus> focus=focusService.getFocusByUserId(user_id);
		if(focus.isEmpty()) {
		focusService.addFocusByUserIdAndId(goods_id, user_id);
		}
		for (Focus myfocus : focus) {
			int goodsId=myfocus.getGoodsId();
			if(goodsId!=goods_id) {
				focusService.addFocusByUserIdAndId(goods_id, user_id);
			}
		}
		return "redirect:/user/allFocus";

	}

	/**
	 * 我的钱包
	 * 
	 * @return 返回的model为 goodsAndImage对象
	 */
	@RequestMapping(value = "/myPurse")
	public ModelAndView getMoney(HttpServletRequest request) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer user_id = cur_user.getId();
		Purse purse = purseService.getPurseByUserId(user_id);
		ModelAndView mv = new ModelAndView();
		mv.addObject("myPurse", purse);
		mv.setViewName("/user/purse");
		return mv;
	}

	/**
	 * 充值与提现 根据传过来的两个值进行判断是充值还是提现
	 * 
	 * @return 返回的model为 goodsAndImage对象
	 */
	@RequestMapping(value = "/updatePurse")
	public String updatePurse(HttpServletRequest request, Purse purse) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer user_id = cur_user.getId();
		purse.setUserId(user_id);
		purse.setState(0);
		if (purse.getRecharge() != null) {
			purseService.updatePurse(purse);
		}
		if (purse.getWithdrawals() != null) {
			purseService.updatePurse(purse);
		}
		return "redirect:/user/myPurse";
	}
	
	@RequestMapping(value = "/insertSelective",method = RequestMethod.POST)
	@ResponseBody
	public String insertSelective(HttpServletRequest request){
		String context=request.getParameter("context");
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Notice notice=new Notice();
		notice.setContext(context);
		Date dt = new Date();     
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		notice.setCreateAt(sdf.format(dt));
		notice.setStatus((byte) 0);
		notice.setUser(cur_user);
		if(context==null||context=="") {
			return "{\"success\":false,\"msg\":\"发布失败，请输入内容!\"}";
		}
	try {
			noticeService.insertSelective(notice);
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"发布失败!\"}";
		}
			return "{\"success\":true,\"msg\":\"发布成功!\"}";
		
	}
	
	

}
