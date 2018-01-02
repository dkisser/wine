package org.lf.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/** * @author  wenchen 
 * @date 创建时间：2017年8月29日 下午3:33:22 
 * @version 1.0 
 * @parameter */
public class AdminProperties {

	private static Properties p;
	
	static {
		p = new Properties();
		InputStream in = AdminProperties.class.getClassLoader().getResourceAsStream("admin.properties");
		try {
			p.load(in);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (in !=null) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public static String getValue(String value){
		String result = p.getProperty(value);
		if (StringUtils.isEmpty(result)) {
			return null;
		} else {
			return result.trim();
		}
	}
	
	public static final String SERVER_URL = AdminProperties.getValue("server_url");
	
}
