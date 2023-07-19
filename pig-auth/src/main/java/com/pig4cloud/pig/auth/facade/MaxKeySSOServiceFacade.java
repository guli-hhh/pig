package com.pig4cloud.pig.auth.facade;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.IOException;

@Service
public class MaxKeySSOServiceFacade {

	@Value("${sso.maxkey.oauth2.maxkey_token_uri:http://sso.maxkey.top/sign/authz/oauth/v20/token?client_id=%s&client_secret=%s&grant_type=%s&redirect_uri=%s&code=%s}")
	private String maxkeyTokenUri;

	@Value("${sso.maxkey.oauth2.maxkey_getme_uri:http://sso.maxkey.top/sign/api/oauth/v20/me?access_token=%s}")
	private String maxkeyGetmeUri;

	@Value("${sso.maxkey.oauth2.client_id:b32834accb544ea7a9a09dcae4a36403}")
	private String clientId;

	@Value("${sso.maxkey.oauth2.response_type:code}")
	private String responseType;

	@Value("${sso.maxkey.oauth2.redirect_uri:http://localhost:8080/login}")
	private String redirectUri;

	@Value("${sso.maxkey.oauth2.client_secret:E9UO53P3JH52aQAcnLP2FlLv8olKIB7u}")
	private String clientSecret;
	@Value("${sso.maxkey.oauth2.grant_type:authorization_code}")
	private String grantType;

	@Resource
	OkHttpClient okHttpClient;


	// TODO
	public String getUserInfoByToken(String accessToken) {
		String userInfo;
		try {
			String url = String.format(maxkeyGetmeUri, accessToken);
			Request request = new Request.Builder()
					//参数放到链接后面
					.url(url).build();
			//发送请求
			Response response = okHttpClient.newCall(request).execute();
			//将响应数据转换字符传（实际是json字符传）
			userInfo = response.body().string();
			JSONObject jsonObject = JSON.parseObject(userInfo);
			System.out.println(jsonObject);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return userInfo;
	}

	// TODO
	public String getTokenByCode(String code) {
		String accessToken;
		try {
			String url = String.format(maxkeyTokenUri, clientId, clientSecret, grantType, redirectUri, code);
			Request request = new Request.Builder()
					//参数放到链接后面
					.url(url).build();
			//发送请求
			Response response = okHttpClient.newCall(request).execute();
			//将响应数据转换字符传（实际是json字符传）

			accessToken = JSONObject.parseObject(response.body().string()).getString("access_token");

		} catch (IOException e) {
			throw new RuntimeException(e);
		}

		return accessToken;
	}

}
