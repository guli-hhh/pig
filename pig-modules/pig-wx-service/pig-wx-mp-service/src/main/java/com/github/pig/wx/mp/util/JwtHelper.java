package com.github.pig.wx.mp.util;

import com.github.pig.common.constant.CommonConstant;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Base64;

public class JwtHelper {

    /**
     * 根据用户请求中的token 获取用户名
     *
     * @param request Request
     * @return “”、username
     */
    public static String get(HttpServletRequest request,String Key) {
        String username = "";
        String authorization = request.getHeader(CommonConstant.REQ_HEADER);
        if (StringUtils.isEmpty(authorization)) {
            return username;
        }
        String token = StringUtils.substringAfter(authorization, CommonConstant.TOKEN_SPLIT);
        if (StringUtils.isEmpty(token)) {
            return username;
        }
        String key = Base64.getEncoder().encodeToString(CommonConstant.SIGN_KEY.getBytes());
        try {
            Claims claims = Jwts.parser().setSigningKey(key).parseClaimsJws(token).getBody();
            username = claims.get(Key).toString();
        } catch (Exception ex) {
            //log.error("用户名解析异常,token:{},key:{}", token, key);
        }
        return username;
    }

    /**
     * 通过token 获取用户名
     *
     * @param authorization token
     * @return 用户名
     */
    public static String get(String authorization,String Key) {
        String username = "";
        String token = StringUtils.substringAfter(authorization, CommonConstant.TOKEN_SPLIT);
        if (StringUtils.isEmpty(token)) {
            return username;
        }
        String key = Base64.getEncoder().encodeToString(CommonConstant.SIGN_KEY.getBytes());
        try {
            Claims claims = Jwts.parser().setSigningKey(key).parseClaimsJws(token).getBody();
            username = claims.get(Key).toString();
        } catch (Exception ex) {
            //System.out.println("用户名解析异常,token:{},key:{}", token, key);
        }
        return username;
    }


}
