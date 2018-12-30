package com.ldu.dao;

import com.ldu.pojo.Admin;

public interface AdminMapper {
	
	
	public Admin findAdmin(Long phone, String password);

	public Admin findAdminById(Integer id);

	public void updateAdmin(Admin admins);

}
