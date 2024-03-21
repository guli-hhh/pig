package com.pig4cloud.pig.mocuser.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.pig4cloud.pig.mocuser.entity.mocUserEntity;
import com.pig4cloud.pig.mocuser.mapper.mocUserMapper;
import com.pig4cloud.pig.mocuser.service.mocUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
/**
 * moc用户系统
 *
 * @author pig
 * @date 2024-03-21 18:34:40
 */
@Service
public class mocUserServiceImpl extends ServiceImpl<mocUserMapper, mocUserEntity> implements mocUserService {
	@Autowired
	private mocUserMapper userMapper;

	/*** 用户修改
	 *
	 * @param user
	 * @return
	 */
	@Override
	public mocUserEntity upuser(mocUserEntity user){
		mocUserEntity user1 = userMapper.selectById(user.getId());
		user1.setAge(user.getAge());
		user1.setBilibili(user.getBilibili());
		user1.setDouyin(user.getDouyin());
		user1.setEmail(user.getEmail());
		user1.setKuaishou(user.getKuaishou());
		user1.setName(user.getName());
		user1.setQq(user.getQq());
		user1.setWchat(user.getWchat());
//        user1.setUpdateTime(System.currentTimeMillis());
		UpdateWrapper<mocUserEntity> userUpdateWrapper = new UpdateWrapper<>();
		userUpdateWrapper.eq("id",user1.getId());
		userMapper.update(user1,userUpdateWrapper);
		return user1;
	}

	/*** 使用uuid查询用户
	 *
	 * @param uuid
	 * @return
	 */
	@Override
	public mocUserEntity fandbyuuid(String uuid){
		QueryWrapper<mocUserEntity> userQueryWrapper = new QueryWrapper<>();
		userQueryWrapper.eq("uuid",uuid);
		mocUserEntity user = userMapper.selectOne(userQueryWrapper);
		return user;
	}

	/*** 通过手机号查询用户
	 *
	 * @param phone
	 * @return
	 */
	@Override
	public mocUserEntity fandbyphone(String phone){
		QueryWrapper<mocUserEntity> userQueryWrapper = new QueryWrapper<>();
		userQueryWrapper.eq("phone",phone);
		return userMapper.selectOne(userQueryWrapper);
	}
}
