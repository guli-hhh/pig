package com.sf.cloud.task.feign.feign.fallback;

import com.pig4cloud.pig.common.core.util.R;
import com.sf.cloud.task.feign.feign.RemoteUpmsService;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RemoteUpmsServiceFallbackImpl implements RemoteUpmsService {

    @Setter
    private Throwable cause;

    /**
     * 通过字典类型查找字典
     *
     * @param type 类型
     * @param from
     * @return 同类型字典
     */
    @Override
    public R getDictByType(String type, String from) {
        log.error("获取user Dict失败", cause);
        return null;
    }

	@Override
	public R listRoles() {
		log.error("获取role Dict失败", cause);
		return null;
	}
}
