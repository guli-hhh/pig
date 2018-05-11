package com.github.pig.cms.blog.controller.article;

import com.github.pig.common.web.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author 毛子坤
 * @Title: ${file_name}
 * @Package ${package_name}
 * @Description: ${todo}
 * @date 2018/4/2014:04
 */
@RestController
@RequestMapping("/article")
public class ArticleController extends BaseController {

    @RequestMapping(value = "/hello",method = RequestMethod.GET)
    public String hello(){
        return "helloword";
    }

}
