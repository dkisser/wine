package org.lf.utils;

import java.security.MessageDigest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class StringUtils {
	private static final Logger logger = LoggerFactory.getLogger(StringUtils.class);
	private static final SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
	private static final SimpleDateFormat df2 = new SimpleDateFormat("yyyyMMdd");// 设置日期格式
	private static final SimpleDateFormat df3 = new SimpleDateFormat("yyyy-MM-dd");// 设置日期格式
	
	public final static String toMD5(String s) {
        char hexDigits[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};       
        try {
            byte[] btInput = s.getBytes();
            // 获得MD5摘要算法的 MessageDigest 对象
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            // 使用指定的字节更新摘要
            mdInst.update(btInput);
            // 获得密文
            byte[] md = mdInst.digest();
            // 把密文转换成十六进制的字符串形式
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
	
	/**
	 * 将规定长度之外的字符替换为省略号...
	 * @param value
	 * @param length
	 */
	public final static String sub(String value,int length){
		if(value.length()<length){
			return value;
		}
		else{
			return value.substring(0, length-3) + "...";
		}
	}
	
	
	
	/**
	 * 左右填充
	 * @param str
	 * @param padChar
	 * @param length
	 */
	public final static String pad(String str, char padChar, int length){
		if (padChar > 128) {
			throw new IllegalArgumentException("填充字符必须为ASCII码！");
		}
		
		if (str.length() > length) {
			return str;
		}
		
		int padSize = (length - str.length()) / 2;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < padSize; i++) {
			sb.append(padChar);
		}
		sb.append(str);
		for (int i = 0; i < padSize; i++) {
			sb.append(padChar);
		}
		return sb.toString();
	}
	
	/**
	 * 左填充
	 * @param str
	 * @param padChar
	 * @param length
	 */
	public final static String lpad(String str, char padChar, int length){
		if (padChar > 128) {
			throw new IllegalArgumentException("填充字符必须为ASCII码！");
		}
		
		if (str.length() > length) {
			return str;
		}
		
		int padSize = length - str.length();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < padSize; i++) {
			sb.append(padChar);
		}
		sb.append(str);
		return sb.toString();
	}
	
	/**
	 * 右填充
	 * @param str
	 * @param padChar
	 * @param length
	 */
	public final static String rpad(String str, char padChar, int length){
		if (padChar > 128) {
			throw new IllegalArgumentException("填充字符必须为ASCII码！");
		}
		
		if (str.length() > length) {
			return str;
		}
		
		int padSize = length - str.length();
		StringBuilder sb = new StringBuilder();
		sb.append(str);
		for (int i = 0; i < padSize; i++) {
			sb.append(padChar);
		}
		return sb.toString();
	}
	
	
	/**
	 * UUID是由一个36位的数字组合组成,表现出来的形式例如: 550E8400-E29B-11D4-A716-446655440000 
	 */
	public final static String getUUID() {
		return UUID.randomUUID().toString(); 
	}
	
	/**
	 * UUID是由一个36位的数字组成,表现出来的形式例如: 550E8400-E29B-11D4-A716-446655440000
	 * 本函数去除其中的'-'字符，返回32位字母数字组合。
	 */
	public final static String getShortUUID() {
		String uuid = getUUID();
		
		return uuid.substring(0,8)+uuid.substring(9,13)+uuid.substring(14,18)+uuid.substring(19,23)+uuid.substring(24); 
	}

	/**
	 * 对字符串进行base64加密
	 * 
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public final static String base64Encode(String str) throws Exception {
		if(isEmpty(str)){
			return null;
		}
		return new String(Base64.encodeBase64(str.getBytes("UTF-8")), "UTF-8");
	}

	/**
	 * 对字符串进行base64解密
	 * 
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public final static String base64Decode(String str) throws Exception {
		if(isEmpty(str)){
			return null;
		}
		return new String(Base64.decodeBase64(str.getBytes("UTF-8")), "UTF-8");
	}

	/**
	 * 获得当前时间字符串  格式为：yyyy-MM-dd HH:mm:ss
	 * 
	 * @return
	 */
	public final static String getCurrTime() {
		return df1.format(new Date());
	}
	/**
	 * 将时间字符串格式化
	 * @param str
	 * @return
	 */
	public static final String strDtateFmt(String str){
		if(isEmpty(str)){
			return null;
		}
		String fmtDate=null;
		try {
			fmtDate=df3.format(df2.parse(str));
		} catch (ParseException e) {
			logger.error("解析时间字符串出错", e);
			return null;
		}
		return fmtDate;
	}

	/**
	 * 判断指定字符串是否为空,为空返回true
	 * 
	 * @param str
	 * @return 为空返回true
	 */
	public final static boolean isEmpty(String str) {
		return str == null || str.trim().length() == 0;
	}
}
