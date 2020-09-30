package com.sf.cloud.task.task.config;

import cn.hutool.core.annotation.AnnotationUtil;
import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.sf.cloud.task.task.annotation.IdToEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Component
public class TaskMethodArgumentResolver implements HandlerMethodArgumentResolver, ApplicationContextAware {

    private final String ID_END = "Id";

    private ApplicationContext applicationContext;

    @Override
    public boolean supportsParameter(MethodParameter methodParameter) {
        return methodParameter.hasParameterAnnotation(IdToEntity.class);
    }

    @Override
    public Object resolveArgument(MethodParameter methodParameter
            , ModelAndViewContainer modelAndViewContainer
            , NativeWebRequest nativeWebRequest
            , WebDataBinderFactory webDataBinderFactory) throws Exception {

        // 获取请求参数json
        String parametersJsonStr = parseParametersToJsonStr(nativeWebRequest);

        // 具体参数对象类型
        Type actualTypeArguments;

        Parameter parameter = methodParameter.getParameter();
        // 是否为list
        if (List.class.isAssignableFrom(parameter.getType())) {

            List<Object> argList = new ArrayList<>();

            // 获取list泛型的类型
            ParameterizedType parameterizedType = (ParameterizedType) (parameter.getParameterizedType());
            // list只有一个泛型，获取第一个泛型
            actualTypeArguments = parameterizedType.getActualTypeArguments()[0];


            JSONArray requestParamJsonArr = JSONUtil.parseArray(parametersJsonStr);
            requestParamJsonArr.forEach(requestJsonObject -> {
                JSONObject requestJson = (JSONObject) requestJsonObject;

                Object actualArg = getObject(actualTypeArguments, requestJson);
                argList.add(actualArg);
            });
            return argList;
        }

        // 不是list，是实体类本身
        JSONObject requestJsonObject = JSONUtil.parseObj(parametersJsonStr);
        return getObject(parameter.getType(), requestJsonObject);
    }

    /**
      * @Description 从request参数 获取请求实体
      * @Return
      * @Author tuzhaoliang
      * @Date 2020/9/21 8:15
      **/
    private Object getObject(Type actualTypeArguments, JSONObject requestJson) {
        Object actualArg = JSONUtil.toBean(requestJson, actualTypeArguments, true);

        List<String> endIdList = requestJson.keySet().stream().filter(key -> {
            // 如果参数中有platformId,则取出platform
            return StrUtil.endWith(key, ID_END);
        }).collect(Collectors.toList());
        setIdFiled(actualArg, requestJson, endIdList);
        return actualArg;
    }

    /**
     * @return
     * @Description 从request中获取参数，同时支持所有请求方式
     * @Return
     * @Author tuzhaoliang
     * @Date 2020/9/11 17:21
     */
    private String parseParametersToJsonStr(NativeWebRequest nativeWebRequest) throws com.fasterxml.jackson.core.JsonProcessingException {
        HttpServletRequestWrapper request = new HttpServletRequestWrapper(nativeWebRequest.getNativeRequest(HttpServletRequest.class));
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader;
        InputStream inputStream;
        try {
            inputStream = request.getInputStream();
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            }
        } catch (IOException ignored) {

        }
        return stringBuilder.toString();
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    private Object setIdFiled(Object argument, JSONObject requestJson, List<String> endIdList) {
        endIdList.forEach(endId -> {

            String fieldName = StrUtil.sub(endId, 0, endId.length() - ID_END.length());

            Method setMethod = ReflectUtil.getMethodByName(argument.getClass(), "set" + StrUtil.upperFirst(fieldName));
            if (setMethod == null) {
                return;
            }
            // 如果是platformId，那么这里endId就是platform， 找到对应platformRepository
            Object repository = applicationContext.getBean(fieldName + "Repository");
            // 找到findById方法
            Method findById = ReflectUtil.getMethodByName(repository.getClass(), "findById");
            if (findById == null) {
                return;
            }
            // 从数据库根据id查出对象
            Long id = Convert.convert(Long.class, requestJson.get(endId));
            if (id == null) {
                return;
            }

            Optional optional = ReflectUtil.invoke(repository, findById, id);
            // 将对象设置进
            optional.ifPresent(result -> ReflectUtil.invoke(argument, setMethod, result));
        });
        return argument;
    }
}
