package org.lf.utils.servlet;

import java.io.InputStream;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.lf.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class BrowserInterceptor implements HandlerInterceptor {
	private static final Logger logger = LoggerFactory
			.getLogger(BrowserInterceptor.class);
	/**
	 * 浏览器名称
	 */
	private static String browserName;
	/**
	 * 浏览器版本号
	 */
	private static Double browserVersion;

	static {
		InputStream inputStream = BrowserInterceptor.class.getClassLoader()
				.getResourceAsStream("swh.properties");
		Properties p = new Properties();
		try {
			p.load(inputStream);
			browserName = p.getProperty("browserName").toLowerCase().trim();
			String versionStr = p.getProperty("browserVersion").toLowerCase()
					.trim();
			browserVersion = Double.parseDouble(versionStr);
			if (StringUtils.isEmpty(browserName)) {
				throw new IllegalArgumentException("浏览器名称为空");
			}
			if (StringUtils.isEmpty(versionStr)) {
				throw new IllegalArgumentException("浏览器版本号为空");
			}
		} catch (Exception e1) {
			logger.error("读取浏览器配置文件出错", e1);
			throw new IllegalArgumentException(e1);
		}
	}

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// HttpSession session = request.getSession();//zspoupload
		String browserInfo = request.getHeader("USER-AGENT").toLowerCase();
		//pageoffice专用 
		if(browserInfo.contains("zspoupload")){
			return true;
		}
		if (browserInfo == null || !browserInfo.contains(browserName)
				|| getBrowserVersion(browserInfo) < browserVersion ) {
			// 未使用指定浏览器 跳转到错误提示页面
			response.sendRedirect(request.getContextPath()
					+ "/errorBrowserUI.do");
			return false;
		}
		return true;
	}

	/**
	 * 根据USER-AGENT字符串解析获得浏览器版本号
	 * 
	 * @param a
	 * @return
	 */
	private Double getBrowserVersion(String a) {
		return Double.parseDouble(a.substring(a.indexOf(browserName)
				+ browserName.length() + 1, a.indexOf(browserName)
				+ browserName.length() + 3));
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

}
