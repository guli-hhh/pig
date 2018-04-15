package com.github.pig.wx.mp.controller;

import com.github.pig.common.util.R;
import com.github.pig.common.util.UserUtils;
import com.github.pig.common.vo.UserVO;
import com.github.pig.common.web.BaseController;
import com.github.pig.wx.mp.service.TestService;
import com.github.pig.wx.mp.util.JwtHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@RestController
@RequestMapping(value = "/test")
public class TestController extends BaseController {

    @Autowired
    private TestService testService;

    @RequestMapping(value = "/test",method = RequestMethod.POST)
    public R<Map<String,Object>> Test(Map<String,Object> map, HttpServletRequest request){
        String username = JwtHelper.get(request,"user_name");
        UserVO user = testService.getUser(username);
        map.put("test","test");
        map.put("user",user);
        return new R<>(map);
    }
}
