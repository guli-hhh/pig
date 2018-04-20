package com.github.pig.cms.blog.common.config.intercepter;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class Intercepter implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
		 return true;
	}

	@Override
	public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
//		User user = null;
//		if(StringUtils.isNotBlank(ITBC.getCurrUserId())){
//			user = userService.get(ITBC.getCurrUserId());
//		}
//
//		if(null != modelAndView){
//			boolean flag = false;
//			if(null!=user){
//				flag = true;
//				String _userString = JSON.toJSONString(user);
//				JSONObject _user = JSONObject.parseObject(_userString);
//				modelAndView.addObject(ITBC._USER,_user);
//				modelAndView.addObject(ITBC.JSON_USER,_userString);
//			}
//			modelAndView.addObject(ITBC.ITBC_FRONT,ITBC.SERVER_NAME_FRONT);
//			modelAndView.addObject(ITBC.ITBC_ADMIN,ITBC.SERVER_NAME_ADMIN);
//			modelAndView.addObject(ITBC.ITBC_NGINX,ITBCNginx);
//			modelAndView.addObject(ITBC.IS_LOGIN,flag);
//		}

	}

	@Override
	public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}


}
