package com.sf.cloud.task.task.utils;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class RequestUtil {

    public static String getJsonFromRequest(HttpServletRequest request) {
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
}
