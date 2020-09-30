package com.sf.cloud.task.task.config.db;

import cn.hutool.core.util.StrUtil;

import javax.persistence.AttributeConverter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class ListToIntegerConverter implements AttributeConverter<List<Integer>, String> {
    /**
     * Converts the value stored in the entity attribute into the
     * data representation to be stored in the database.
     *
     * @param attribute the entity attribute value to be converted
     * @return the converted data to be stored in the database
     * column
     */
    @Override
    public String convertToDatabaseColumn(List<Integer> attribute) {
        if (attribute == null || attribute.isEmpty()){
            return "";
        }
        StringBuilder sb = new StringBuilder();
        attribute.stream().limit(attribute.size()-1).forEach(s -> sb.append(s).append(","));
        sb.append(attribute.get(attribute.size()-1));
        return sb.toString();
    }

    /**
     * Converts the data stored in the database column into the
     * value to be stored in the entity attribute.
     * Note that it is the responsibility of the converter writer to
     * specify the correct <code>dbData</code> type for the corresponding
     * column for use by the JDBC driver: i.e., persistence providers are
     * not expected to do such type conversion.
     *
     * @param dbData the data from the database column to be
     *               converted
     * @return the converted value to be stored in the entity
     * attribute
     */
    @Override
    public List<Integer> convertToEntityAttribute(String dbData) {
        if (StrUtil.isEmpty(dbData)){
            return new ArrayList<>();
        }
        String[] data = dbData.split(",");
        return   Arrays.stream(data).map(String::trim)
                            .map(Integer::valueOf)
                            .collect(Collectors.toList());
    }
}
