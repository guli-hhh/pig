//package com.pig4cloud.pig.mocuser.feign;
//
//import java.util.concurrent.TimeUnit;
//
//// 假设我们有一个第三方短信服务接口SmsService
//
//public class VerificationCodeService {
//
//    private final SmsService smsService;
//    // 使用ThreadLocal来存储用户的验证码信息，避免多线程问题
//    private final ThreadLocal<VerificationInfo> verificationInfoThreadLocal = new ThreadLocal<>();
//
//    // 验证码有效时长（例如5分钟）
//    private static final int CODE_VALIDITY_PERIOD_MINUTES = 5;
//    // 同一手机号每天允许获取验证码的最大次数（例如3次）
//    private static final int MAX_REQUEST_TIMES_PER_DAY = 3;
//
//    public VerificationCodeService(SmsService smsService) {
//        this.smsService = smsService;
//    }
//
//    /**
//     * 发送短信验证码
//     * @param phoneNumber 手机号码
//     */
//    public void sendVerificationCode(String phoneNumber) {
//        // 检查是否超过每日最大请求次数
//        if (checkDailyRequestLimit(phoneNumber)) {
//            // 生成新的验证码
//            String code = generateVerificationCode();
//
//            // 存储验证码及其过期时间
//            VerificationInfo info = new VerificationInfo(code, System.currentTimeMillis() + TimeUnit.MINUTES.toMillis(CODE_VALIDITY_PERIOD_MINUTES));
//            verificationInfoThreadLocal.set(info);
//
//            // 调用短信服务发送验证码
//            smsService.sendSMS(phoneNumber, "Your verification code is: " + code);
//
//            // ...此处可添加日志记录或通知等操作
//        } else {
//            throw new ExcessiveRequestsException("Exceeded the maximum number of daily requests for SMS verification code.");
//        }
//    }
//
//    /**
//     * 验证短信验证码
//     * @param phoneNumber 手机号码
//     * @param inputCode 输入的验证码
//     * @return 验证结果
//     */
//    public boolean verifyCode(String phoneNumber, String inputCode) {
//        VerificationInfo info = verificationInfoThreadLocal.get();
//
//        // 检查验证码是否存在并且未过期
//        if (info != null && info.getCode().equals(inputCode) && info.getExpireTime() > System.currentTimeMillis()) {
//            // 验证通过后清除验证码信息
//            verificationInfoThreadLocal.remove();
//            return true;
//        } else {
//            throw new VerificationCodeExpiredException("The verification code has expired or is incorrect.");
//        }
//    }
//
//    /**
//     * 检查是否超过每日最大请求次数
//     * @param phoneNumber 手机号码
//     * @return 是否允许发送验证码
//     */
//    private boolean checkDailyRequestLimit(String phoneNumber) {
//        // 这里应实现从数据库或其他存储中获取该手机号今天的请求次数，并进行判断
//        // 简化起见，这里假设已经实现了这个逻辑并返回true/false
//        // 示例：return getTodayRequestCount(phoneNumber) < MAX_REQUEST_TIMES_PER_DAY;
//        return true;
//    }
//
//    /**
//     * 生成随机验证码
//     * @return 验证码字符串
//     */
//    private String generateVerificationCode() {
//        // 实际情况下，这里应生成一个随机的6位数字或其他格式的验证码
//        // 示例简化：return RandomStringUtils.randomNumeric(6);
//        return "123456";
//    }
//
//    // 示例中的VerificationInfo类
//    static class VerificationInfo {
//        private String code;
//        private long expireTime;
//
//        public VerificationInfo(String code, long expireTime) {
//            this.code = code;
//            this.expireTime = expireTime;
//        }
//
//        public String getCode() {
//            return code;
//        }
//
//        public long getExpireTime() {
//            return expireTime;
//        }
//    }
//}
