package com.github.pig.wx.mp.service.impl;

import com.github.pig.common.util.UserUtils;
import com.github.pig.common.vo.UserVO;
import com.github.pig.wx.mp.feign.UserService;
import com.github.pig.wx.mp.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TestServiceImpl implements TestService {

    @Autowired
    private UserService userService;


    @Override
    public UserVO getUser(String username) {
        String name = UserUtils.getUserName();

        return userService.findUserByUsername(name);
    }
}
