package com.pig4cloud.pig.mocuser.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.pig4cloud.pig.mocuser.entity.mocUserEntity;

public interface mocUserService extends IService<mocUserEntity> {

	mocUserEntity upuser(mocUserEntity user);

	mocUserEntity fandbyuuid(String uuid);

	mocUserEntity fandbyphone(String phone);
}
