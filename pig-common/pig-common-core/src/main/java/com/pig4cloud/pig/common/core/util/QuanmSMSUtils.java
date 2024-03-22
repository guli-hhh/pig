package com.pig4cloud.pig.common.core.util; /**
 author:果氢
 文件所属项目:QDC SMS SDK
 文件描述:QuanmSMS SDK (泉鸣开放平台sms接口SDK)，包含执行短信业务所需的方法
 官网：dev.quanmwl.com
 发布日期:2023-8-3
 */
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Bean;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Map;
import java.util.Random;

public class QuanmSMSUtils {
    private final String openID;
    private final String apiKey;
    private final int defModelID;
    private final String apiGateway;

    public QuanmSMSUtils() {
        this.openID ="712";
        this.apiKey = "771d6214d52511eea3f40242ac110004";
        this.defModelID = 0;
        this.apiGateway = "http://dev.quanmwl.com";
    }
//    QuanmSMSUtils.create("712", "771d6214d52511eea3f40242ac110004", 0)
//
//    public static QuanmSMSUtils create(String openID, String apiKey, int defModelID) {
//        return new QuanmSMSUtils(openID, apiKey, defModelID, "http://dev.quanmwl.com");
//    }

    private String sign(String tel, String modelID, String modelArgs) {
        String serverSignData = openID + apiKey + tel + modelID + modelArgs;
        return getMD5Hash(serverSignData);
    }

    private String getMD5Hash(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            // Convert the byte array to a hexadecimal string
            StringBuilder hexString = new StringBuilder();
            for (byte b : messageDigest) {
                String hex = Integer.toHexString(0xFF & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 algorithm not found.", e);
        }
    }

    public  String sendSMS(String tel, int modelID, Map<String, String> modelArges) {
        String apiUrl = apiGateway + "/v1/sms";
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonString;
        try {
            jsonString = objectMapper.writeValueAsString(modelArges);
        } catch (JsonProcessingException e) {
            return "json convert error";
        }
        String requestBody = String.format("openID=%s&tel=%s&sign=%s&model_id=%s&model_args=%s",
                openID, tel, sign(tel, String.valueOf(defModelID), jsonString), modelID, jsonString);
        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(apiUrl))
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                    .header("Content-Type", "application/x-www-form-urlencoded")
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            int statusCode = response.statusCode();

            if (statusCode != 200) {
                return "Server Error";
            }

            return response.body();
        } catch (IOException | URISyntaxException | InterruptedException e) {
            return "Server Error: " + e.getMessage();
        }
    }
    public String sendcode(String phone){

        int i = (int) ((Math.random() * 9 + 1) * 10000);
        System.out.println(i);
        String s = new QuanmSMSUtils().sendSMS(phone, 0, Map.of("code", String.valueOf(i)));
        JSONObject jsonObject = JSONObject.parseObject(s);
        if (jsonObject.getString("state").equals("200")) {
            return String.valueOf(i);
        }
        return "发送失败";
    }
	@Bean
	public QuanmSMSUtils getbean(){
		return new QuanmSMSUtils();
	}


//    public static void main(String[] args) {
//        System.out.println(sendcode("18185862043"));
//    }
}
