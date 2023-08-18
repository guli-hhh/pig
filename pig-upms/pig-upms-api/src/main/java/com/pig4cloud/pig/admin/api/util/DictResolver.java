package com.pig4cloud.pig.admin.api.util;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.pig4cloud.pig.admin.api.entity.SysDictItem;
import com.pig4cloud.pig.admin.api.feign.RemoteDictService;
import com.pig4cloud.pig.common.core.util.SpringContextHolder;
import lombok.experimental.UtilityClass;
import org.apache.commons.collections4.CollectionUtils;

import java.util.List;

/**
 * @author fxz
 * @date 2022/3/24 字典解析器
 */
@UtilityClass
public class DictResolver {

	/**
	 * 根据字典类型获取所有字典项
	 *
	 * @param type 字典类型
	 * @return 字典数据项集合
	 */
	public List<SysDictItem> getDictItemsByType(String type) {
		Assert.isTrue(StrUtil.isNotBlank(type), "参数不合法" );

		RemoteDictService remoteDictService = SpringContextHolder.getBean(RemoteDictService.class);

		return remoteDictService.getDictByType(type).getData();
	}

	/**
	 * 根据字典类型以及字典项字典值获取字典标签
	 *
	 * @param type      字典类型
	 * @param itemValue 字典项字典值
	 * @return 字典项标签值
	 */
	public String getDictItemLabel(String type, String itemValue) {
		Assert.isTrue(StrUtil.isNotBlank(type) && StrUtil.isNotBlank(itemValue), "参数不合法" );

		SysDictItem sysDictItem = getDictItemByItemValue(type, itemValue);

		return ObjectUtil.isNotEmpty(sysDictItem) ? sysDictItem.getLabel() : "";
	}

	/**
	 * 根据字典类型以及字典标签获取字典值
	 *
	 * @param type      字典类型
	 * @param itemLabel 字典数据标签
	 * @return 字典数据项值
	 */
	public String getDictItemValue(String type, String itemLabel) {
		Assert.isTrue(StrUtil.isNotBlank(type) && StrUtil.isNotBlank(itemLabel), "参数不合法" );

		SysDictItem sysDictItem = getDictItemByItemLabel(type, itemLabel);

		return ObjectUtil.isNotEmpty(sysDictItem) ? sysDictItem.getValue() : "";
	}

	/**
	 * 根据字典类型以及字典值获取字典项
	 *
	 * @param type      字典类型
	 * @param itemValue 字典数据值
	 * @return 字典数据项
	 */
	public SysDictItem getDictItemByItemValue(String type, String itemValue) {
		Assert.isTrue(StrUtil.isNotBlank(type) && StrUtil.isNotBlank(itemValue), "参数不合法" );

		List<SysDictItem> dictItemList = getDictItemsByType(type);

		if (CollectionUtils.isNotEmpty(dictItemList)) {
			return dictItemList.stream().filter(item -> itemValue.equals(item.getValue())).findFirst().orElse(null);
		}

		return null;
	}

	/**
	 * 根据字典类型以及字典标签获取字典项
	 *
	 * @param type      字典类型
	 * @param itemLabel 字典数据项标签
	 * @return 字典数据项
	 */
	public SysDictItem getDictItemByItemLabel(String type, String itemLabel) {
		Assert.isTrue(StrUtil.isNotBlank(type) && StrUtil.isNotBlank(itemLabel), "参数不合法" );

		List<SysDictItem> dictItemList = getDictItemsByType(type);

		if (CollectionUtils.isNotEmpty(dictItemList)) {
			return dictItemList.stream().filter(item -> itemLabel.equals(item.getLabel())).findFirst().orElse(null);
		}

		return null;
	}

}
