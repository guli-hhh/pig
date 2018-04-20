package com.github.pig.cms.blog.controller.article;

import com.github.pig.cms.blog.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author 毛子坤
 * @Title: ${file_name}
 * @Package ${package_name}
 * @Description: ${todo}
 * @date 2018/4/2014:04
 */
@Controller
@RequestMapping("/article")
public class ArticleController extends BaseController {

    @RequestMapping(value = "/hello",method = RequestMethod.GET)
    public String hello(){
        HttpSession session = request.getSession();
        session.setAttribute("Authorization","Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJleHAiOjE1MjQyNTM4MTAsImF1dGhvcml0aWVzIjpbIlJPTEVfQURNSU4iLCJST0xFX1VTRVIiXSwianRpIjoiMTQ0YWI4MDktY2YwNC00NjExLTgwODEtZDMzNzc2NzBkZmVmIiwiY2xpZW50X2lkIjoicGlnIn0.l_RzEzIO8wRCdzoOJhN9Ed5VSRr8BxD_Hcf0DVw_GzU");
        return "helloword";
    }

    @RequestMapping(value = "/setHeader",method = RequestMethod.GET)
    public String setHeader(HttpServletResponse response){
        HttpSession session = request.getSession();
        session.getAttribute("Authorization");
        return "helloword";
    }
}
