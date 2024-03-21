package com.pig4cloud.pig.mocuser.feign;

import cn.dev33.satoken.annotation.SaCheckLogin;
import cn.dev33.satoken.annotation.SaIgnore;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.lang.UUID;
import com.pig4cloud.pig.common.core.util.R;
import com.pig4cloud.pig.common.core.util.RedisUtils;
import com.pig4cloud.pig.mocuser.entity.mocUserEntity;
import com.pig4cloud.pig.mocuser.service.mocUserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.constraints.NotNull;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.pig4cloud.pig.common.core.util.QuanmSMSUtils;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/api")
public class UserWebapi {
	@Autowired
	mocUserService mocUserService;
	@Autowired
	QuanmSMSUtils quanmSMSUtils;

	@RequestMapping("/reg")
	public R Reg(String username, String password, String code, String phone) {

		if (RedisUtils.get(phone + "code")==null){
			return R.ok("验证码已过期或未发送");
		}
		String c = RedisUtils.get(phone + "code");
		if (c.equals(code)){
			mocUserEntity fandbyphone = mocUserService.fandbyphone(phone);
			if (fandbyphone!=null) {
				return R.ok("你的手机号已经注册其他账户");
			}else {
				mocUserEntity mocUserEntity = new mocUserEntity(username, UUID.randomUUID().toString(), System.currentTimeMillis(), 0, password, phone);
				return R.ok(mocUserService.save(mocUserEntity));
			}
		}else {
			return R.ok("验证码错误");
		}

	}

	/*** 发送验证码
	 *
	 * @param phone
	 * @param request
	 * @return
	 */
	@RequestMapping("/sendsms")
	public R sendsms(String phone, HttpServletRequest request){
//		String ipAddr = IpUtils.getIpAddr(request);
		String ipAddr = request.getHeader("ip");

		List<String> o1 = RedisUtils.get("banip");
		if (o1==null){
			o1=new ArrayList<>();
		}
		int i1 = o1.indexOf(ipAddr);
		if (i1!=-1){
			return R.ok("你的ip被拉黑");
		}
		Long expire = RedisUtils.get(phone + "code");
		if (expire>2400){
			return R.ok("发送过于频繁");
		}
		int ipnum1=0;

		if (RedisUtils.hasKey(ipAddr+"codenum")){
			ipnum1 = RedisUtils.get(ipAddr + "codenum");
			if (ipnum1>=20){
				return R.ok("今日你的ip发送验证码次数过多");
			}
		}
		RedisUtils.set(ipAddr + "codenum",0,300, TimeUnit.SECONDS);


		if (RedisUtils.hasKey(phone+"codenum")){
			int o = (int) RedisUtils. get(phone + "codenum");
			if (o>=10){
				return R.ok("今日发送验证码次数过多");
			}else {
				int i = (int) ((Math.random() * 9 + 1) * 10000);
				System.out.println(i);
//					String s = smsclenk.TexcellSmsSend(phone, String.valueOf(i));
				//发送验证码

				RedisUtils. set(phone+"code",i,300, TimeUnit.SECONDS);
				Long num = RedisUtils.getExpire(phone + "codenum");
				RedisUtils. set(phone+"codenum",o+1,num,TimeUnit.SECONDS);

				Long ipnum = RedisUtils.getExpire(ipAddr + "codenum");
				System.out.println(ipnum);
				RedisUtils. set(ipAddr+"codenum",ipnum1+1,ipnum,TimeUnit.SECONDS);

			}
		}else {
			RedisUtils. set(phone+"codenum",1,600,TimeUnit.SECONDS);
			//发送验证码
			int i = (int) ((Math.random() * 9 + 1) * 10000);
			System.out.println(i);
			//发送验证码
//				String s = smsclenk.TexcellSmsSend(phone, String.valueOf(i));
//				System.out.println(s);
			RedisUtils. set(phone+"code",i,300, TimeUnit.SECONDS);
			Long ipnum = RedisUtils.getExpire(ipAddr + "codenum");
			System.out.println(ipnum);
			RedisUtils. set(ipAddr+"codenum",ipnum1+1.0,ipnum,TimeUnit.SECONDS);
		}


		return R.ok("验证码发送成功");
	}

//	@SaIgnore
//	@RequestMapping("/reg")
//	public R reg(User user,String code){
//		if (!iscode(code, user.getPhone())) {
//			return R.ok("验证码错误或未发送验证码");
//		}
//		User fandbyphone = userService.fandbyphone(user.getPhone());
//		if (fandbyphone!=null) {
//			return R.ok("你的手机号已经注册其他账户");
//		}
//		user.setRegtime(System.currentTimeMillis());
//		Random random = new Random();
//		int i = random.nextInt(9);
//		user.setUuid(System.currentTimeMillis()+""+i);
//		userService.insertUser(user);
//		return R.ok();
//	}
	@SaIgnore
	@RequestMapping("/login")
	public R login(@RequestParam @NotNull String phone, @RequestParam @NotNull String pwd){
		mocUserEntity fandbyphone = mocUserService.fandbyphone(phone);
		if (fandbyphone==null){
			return R.ok("用户未注册");
		}
		if (pwd.equals(fandbyphone.getPwd())){
			StpUtil.login(fandbyphone,true);
			return R.ok(fandbyphone);
		}
		return R.ok("手机号或密码错误");
	}
	@SaCheckLogin
	@RequestMapping("/loginout")
	public R loginout(){
		StpUtil.logout(StpUtil.getLoginIdAsString());
		return R.ok();
	}
	@SaCheckLogin
	@RequestMapping("/upuser")
	public R upuser(mocUserEntity user){
		mocUserService.upuser(user);
		return R.ok();
	}
	@SaCheckLogin
	@RequestMapping("/fanduserbyuuid")
	public R fand(String uuid){
		return R.ok(mocUserService.fandbyuuid(uuid));
	}


	private static final int MAX_CODE_SEND_PER_DAY = 10; // 每日发送验证码最大次数
	private static final int MAX_IP_CODE_SEND_PER_DAY = 20; // 每个IP每日发送验证码最大次数
	private static final int CODE_SEND_INTERVAL = 2400; // 验证码发送间隔，单位秒
	private static final String SEND_FAILED = "发送失败"; // 发送失败提示字符串


	/**
	 * 发送验证码
	 * @param phone 需要发送验证码的手机号码
	 * @param request 用户的HTTP请求，用于获取用户IP地址
	 * @return 返回发送结果的R对象，成功或失败原因
	 */
	@RequestMapping("/sendsms")
	public R sendSms(String phone, HttpServletRequest request) {
		try {
			String ipAddr = request.getHeader("ip");
			if (isIpBlacklisted(ipAddr)) {
				return R.ok("你的ip被拉黑");
			}
			if (isCodeSendTooFrequent(phone, ipAddr)) {
				return R.ok("发送过于频繁");
			}
			if (isDailyLimitExceeded(ipAddr) || isDailyLimitExceeded(phone)) {
				return R.ok("今日发送验证码次数过多");
			}
			String result = sendCode(phone);
			if (SEND_FAILED.equals(result)) {
				return R.ok("发送失败，请稍后重试");
			}
			updateSendCount(phone, ipAddr);
			return R.ok("验证码发送成功");
		} catch (Exception e) {
			// 适当的异常处理逻辑
			e.printStackTrace();
			return R.ok("发送失败");
		}
	}

	private boolean isIpBlacklisted(String ipAddr) {
		List<String> banIps = RedisUtils.get("banip");
		return banIps != null && banIps.contains(ipAddr);
	}

	private boolean isCodeSendTooFrequent(String phone, String ipAddr) {
		Long expire = RedisUtils.get(phone + "code");
		return expire != null && expire > CODE_SEND_INTERVAL;
	}

	private boolean isDailyLimitExceeded(String key) {
		Integer sendCount = RedisUtils.get(key + "codenum");
		return sendCount != null && sendCount >= MAX_CODE_SEND_PER_DAY;
	}

	private String sendCode(String phone) {
		return quanmSMSUtils.sendcode(phone);
	}

	private void updateSendCount(String phone, String ipAddr) {
		int phoneSendCount = increaseSendCount(phone);
		int ipSendCount = increaseSendCount(ipAddr);
		RedisUtils.set(phone + "codenum", phoneSendCount, 600, TimeUnit.SECONDS);
		RedisUtils.set(ipAddr + "codenum", ipSendCount, 600, TimeUnit.SECONDS);
	}

	private int increaseSendCount(String key) {
		Integer sendCount = RedisUtils.get(key + "codenum");
		int newCount = sendCount == null ? 1 : sendCount + 1;
		RedisUtils.set(key + "codenum", newCount, 600, TimeUnit.SECONDS);
		return newCount;
	}




	/**
	 * 验证码校验函数
	 * @param code 需要校验的验证码字符串
	 * @param phone 验证码绑定的手机号码
	 * @return 校验结果，如果验证码有效且与存储的验证码匹配，则返回true，否则返回false
	 */
	public boolean iscode(String code, String phone) {
		// 检查Redis中是否存在以手机号+“code”为键的验证码
		Boolean aBoolean = RedisUtils.hasKey(phone + "code");
		if (aBoolean) {
			// 如果存在，从Redis获取存储的验证码进行比对
			String o = RedisUtils.get(phone + "code").toString();
			if (o.equals(code)) {
				// 验证码匹配成功，从Redis删除该验证码
				RedisUtils.get(phone + "code");
				RedisUtils.del(phone + "code");
				return true;
			}
			// 验证码不匹配，返回false
			return false;
		}
		// Redis中不存在该验证码，返回false
		return false;
	}
}
