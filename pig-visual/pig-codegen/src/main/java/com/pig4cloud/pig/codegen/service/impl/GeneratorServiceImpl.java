/*
 * Copyright (c) 2020 pig4cloud Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.pig4cloud.pig.codegen.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.io.IoUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.annotation.UseDataSource;
import com.mybatisflex.core.FlexGlobalConfig;
import com.mybatisflex.core.datasource.DataSourceKey;
import com.mybatisflex.core.datasource.FlexDataSource;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.pig4cloud.pig.codegen.entity.GenConfig;
import com.pig4cloud.pig.codegen.entity.GenDatasourceConf;
import com.pig4cloud.pig.codegen.entity.GenFormConf;
import com.pig4cloud.pig.codegen.entity.table.GenDatasourceConfTableDef;
import com.pig4cloud.pig.codegen.mapper.GenFormConfMapper;
import com.pig4cloud.pig.codegen.mapper.GeneratorMapper;
import com.pig4cloud.pig.codegen.service.GenCodeService;
import com.pig4cloud.pig.codegen.service.GenDatasourceConfService;
import com.pig4cloud.pig.codegen.service.GeneratorService;
import com.pig4cloud.pig.codegen.support.StyleTypeEnum;
import com.zaxxer.hikari.HikariDataSource;
import lombok.RequiredArgsConstructor;
import org.jasypt.encryption.StringEncryptor;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipOutputStream;

import static com.pig4cloud.pig.codegen.entity.table.GenDatasourceConfTableDef.GEN_DATASOURCE_CONF;
import static com.pig4cloud.pig.codegen.entity.table.GenFormConfTableDef.GEN_FORM_CONF;

/**
 * @author lengleng
 * @date 2018-07-30
 * <p>
 * 代码生成器
 */
@Service
@RequiredArgsConstructor
public class GeneratorServiceImpl implements GeneratorService {

	private final GeneratorMapper generatorMapper;

	private final GenFormConfMapper genFormConfMapper;
	private final GenDatasourceConfService genDatasourceConfService;

	private final Map<String, GenCodeService> genCodeServiceMap;

	private final StringEncryptor stringEncryptor;

	/**
	 * 分页查询表
	 *
	 * @param tableName 查询条件
	 * @param dsName
	 * @return
	 */
	@Override
	public Page<List<Map<String, Object>>> getPage(Page page, String tableName, String dsName) {
		if (StrUtil.isNotBlank(dsName)){
			GenDatasourceConf datasourceConf = genDatasourceConfService.getOne(QueryWrapper.create()
					.where(GEN_DATASOURCE_CONF.NAME.eq(dsName)));
			FlexDataSource flexDataSource = FlexGlobalConfig.getDefaultConfig()
					.getDataSource();
			//新的数据源
			HikariDataSource newDataSource = new HikariDataSource();
			newDataSource.setJdbcUrl(datasourceConf.getUrl());
			newDataSource.setPassword(stringEncryptor.decrypt(datasourceConf.getPassword()));
			newDataSource.setUsername(datasourceConf.getUsername());
			flexDataSource.addDataSource(dsName, newDataSource);
			List<Map<String, Object>> result = DataSourceKey.use(dsName, () -> generatorMapper.queryList(page, tableName));
			page.setRecords(result);
			page.setPageNumber(result.size());
			return page;
		}
		List<Map<String, Object>> result = generatorMapper.queryList(page, tableName);
		page.setRecords(result);
		page.setPageNumber(result.size());
		return page;
	}

	/**
	 * 预览代码
	 *
	 * @param genConfig 查询条件
	 * @return
	 */
	@Override
	public Map<String, String> previewCode(GenConfig genConfig) {
		// 根据tableName 查询最新的表单配置
		List<GenFormConf> formConfList = genFormConfMapper.selectListByQuery(QueryWrapper.create()
				.where(GEN_FORM_CONF.TABLE_NAME.eq(genConfig.getTableName()))
				.orderBy(GEN_FORM_CONF.CREATE_TIME.desc()));

		String tableNames = genConfig.getTableName();
		String dsName = genConfig.getDsName();

		// 获取实现
		GenCodeService genCodeService = genCodeServiceMap.get(StyleTypeEnum.getDecs(genConfig.getStyle()));

		for (String tableName : StrUtil.split(tableNames, StrUtil.DASHED)) {
			DataSourceKey.use(dsName);
			// 查询表信息
			Map<String, String> table = generatorMapper.queryTable(tableName, dsName);
			// 查询列信息
			List<Map<String, String>> columns = generatorMapper.queryColumns(tableName, dsName);
			// 生成代码
			if (CollUtil.isNotEmpty(formConfList)) {
				return genCodeService.gen(genConfig, table, columns, null, formConfList.get(0));
			} else {
				return genCodeService.gen(genConfig, table, columns, null, null);
			}
		}

		return MapUtil.empty();
	}

	/**
	 * 生成代码
	 *
	 * @param genConfig 生成配置
	 * @return
	 */
	@Override
	public byte[] generatorCode(GenConfig genConfig) {
		// 根据tableName 查询最新的表单配置
		List<GenFormConf> formConfList = genFormConfMapper.selectListByQuery(QueryWrapper.create()
				.where(GEN_FORM_CONF.TABLE_NAME.eq(genConfig.getTableName()))
				.orderBy(GEN_FORM_CONF.CREATE_TIME.desc()));

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		ZipOutputStream zip = new ZipOutputStream(outputStream);

		String tableNames = genConfig.getTableName();
		String dsName = genConfig.getDsName();

		GenCodeService genCodeService = genCodeServiceMap.get(StyleTypeEnum.getDecs(genConfig.getStyle()));

		for (String tableName : StrUtil.split(tableNames, StrUtil.DASHED)) {
			DataSourceKey.use(dsName);
			// 查询表信息
			Map<String, String> table = generatorMapper.queryTable(tableName, dsName);
			// 查询列信息
			List<Map<String, String>> columns = generatorMapper.queryColumns(tableName, dsName);
			// 生成代码
			if (CollUtil.isNotEmpty(formConfList)) {
				genCodeService.gen(genConfig, table, columns, zip, formConfList.get(0));
			} else {
				genCodeService.gen(genConfig, table, columns, zip, null);
			}
		}
		IoUtil.close(zip);
		return outputStream.toByteArray();
	}

}
