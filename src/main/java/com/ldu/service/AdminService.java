package com.ldu.service;

import com.ldu.pojo.Admin;

public interface AdminService {

	
	public Admin findAdmin(Long phone, String password);

	public Admin findAdminById(Integer id);

	public void updateAdmin(Admin admins);
	
	

}
