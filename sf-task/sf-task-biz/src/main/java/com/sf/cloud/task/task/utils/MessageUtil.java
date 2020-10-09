package com.sf.cloud.task.task.utils;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.util.DigestUtils;

import java.io.IOException;
import java.util.Map;

@Slf4j
public class MessageUtil {

    private final String MESSAGE_TEMPLATE = "(${projectName}最近 ${recentDays} 天 ${deviceType} 离线)位置: ${address}, ${gatherAddress}, 离线数量: ${offLineNum}, 总数量: ${totalNum}。";

	private static String HUYI_URL = "http://106.ihuyi.com/webservice/sms.php?method=Submit";

    public static String createWaterMeterMsg(Map<String,String> valuesMap) {
//        StringSubstitutor sub = new StringSubstitutor(valuesMap);
//        StrUtil.
        return null;
    }

    /**
      * @Description 发送短信
      * @Return
      * @Author tuzhaoliang
      * @Date 2020/10/8 17:39
      **/
	public static boolean send(String msg, String mobile) {
		HttpClient client = new HttpClient();
		PostMethod method = new PostMethod(HUYI_URL);

		client.getParams().setContentCharset("GBK");
		method.setRequestHeader("ContentType","application/x-www-form-urlencoded;charset=GBK");
		String password = DigestUtils.md5DigestAsHex("e7d0feb4434fe53f5e8a5550df051a27".getBytes());
		NameValuePair[] data = {//提交短信
			//查看用户名 登录用户中心->验证码通知短信>产品总览->API接口信息->APIID
			new NameValuePair("account", "C03311515"),
			//查看密码 登录用户中心->验证码通知短信>产品总览->API接口信息-> APIKEY
			new NameValuePair("password", password),
			new NameValuePair("mobile", mobile),
			new NameValuePair("content", msg),
		};
		method.setRequestBody(data);

		try {
			client.executeMethod(method);

			String SubmitResult =method.getResponseBodyAsString();

			log.info(SubmitResult);

			Document doc = DocumentHelper.parseText(SubmitResult);
			Element root = doc.getRootElement();

			String code = root.elementText("code");
			String resultMsg = root.elementText("msg");
			String smsid = root.elementText("smsid");


			if("2".equals(code)){
				log.info("短信提交成功");
				return true;
			}

		} catch (IOException | DocumentException e) {
			log.error("互亿无线访问出错: ", e);
		}
		return false;
	}
}
