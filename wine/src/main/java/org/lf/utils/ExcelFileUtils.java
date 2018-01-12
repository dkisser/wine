package org.lf.utils;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.lf.admin.service.OperErrCode;
import org.lf.admin.service.OperException;
import org.springframework.web.multipart.MultipartFile;

public class ExcelFileUtils {
	public static final int EXCEL_FILE_MAX_SIZE = 2 * 1024 * 1024 ;

	public static final OperErrCode 文件不存在 = new OperErrCode("10201", "文件不存在");

	/**
	 * 上限为2M
	 */
	public static final OperErrCode 文件太大 = new OperErrCode("10201", "文件太大");

	public static final OperErrCode 文件格式不正确 = new OperErrCode("10201", "文件格式不正确");

	public static final OperErrCode 无法读取Excel中的数据 = new OperErrCode("10201", "无法读取Excel中的数据");

	public static final OperErrCode 文件导出异常 = new OperErrCode("10201", "文件导出异常");

	/**
	 * 获取单元格数据内容为字符串类型的数据
	 * 
	 * @param cell
	 *            Excel单元格
	 * @return String 单元格数据内容
	 */
	public static String getCellValue(HSSFCell cell) {
		String strCell = "";
		if (cell == null) {
			return strCell;
		}
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_STRING:
			strCell = cell.getStringCellValue();// 字符串
			break;
		case Cell.CELL_TYPE_NUMERIC:
			strCell = String.valueOf(Math.round(cell.getNumericCellValue()));// 数字(四舍五入)
			if (!strCell.matches("^[1-9]\\d*|0$")) {
				strCell = "";// 必须输入正整数
			}
			break;
		case Cell.CELL_TYPE_BOOLEAN:
			strCell = String.valueOf(cell.getBooleanCellValue());// 布尔型
			break;
		case Cell.CELL_TYPE_FORMULA:
			strCell = String.valueOf(cell.getCellFormula());// 公式
			break;
		default:
			strCell = "";
			break;
		}
		if (strCell == null) {
			strCell = "";
		} else {
			strCell = strCell.trim();
		}
		return strCell;
	}

	public static InputStream importExcel(MultipartFile inFile) throws OperException {
		String fileName = inFile.getOriginalFilename();
		String suffix = fileName.substring(fileName.lastIndexOf("."));
		// 检查文件类型是否为excel文件
		if (!".xls".equals(suffix)&&!suffix.equals(".xlsx")) {
			throw new OperException(文件格式不正确);
		}
		// 检查文件大小是否过大，上限为2M
		if (inFile.getSize() > EXCEL_FILE_MAX_SIZE) {
			throw new OperException(文件太大);
		}

		InputStream in = null;
		try {
			in = inFile.getInputStream();
		} catch (IOException e) {
			throw new OperException(无法读取Excel中的数据);
		}

		return in;
	}

	/**
	 * 用于生成单元格样式
	 * 
	 * @param wb
	 *            工作簿对象
	 * @param horAlign
	 *            水平对齐
	 * @param verAlign
	 *            垂直对其
	 * @param fontFamily
	 *            字体名称
	 * @param fontSize
	 *            字号
	 * @param isBold
	 *            是否加粗
	 * @param isXs
	 *            是否为系数
	 * @return
	 */
	public static HSSFCellStyle createCellStyle(HSSFWorkbook wb, HorizontalAlignment horAlign, VerticalAlignment verAlign, String fontFamily, int fontSize,
			boolean isBold, boolean isXs) {
		// 创建单元格样式对象
		HSSFCellStyle style = wb.createCellStyle();
		if (isXs) {
			style.setDataFormat(HSSFDataFormat.getBuiltinFormat("0"));
			style.setLocked(false);
		}
		style.setWrapText(true);// 自动换行
		style.setAlignment(horAlign);// 水平居中
		style.setVerticalAlignment(verAlign);// 垂直居中
		HSSFFont font = wb.createFont();// 字体样式
		font.setFontName(fontFamily);// 设置字体名称
		font.setFontHeightInPoints((short) fontSize);// 设置字号
		font.setBold(isBold); // 设置粗体
		style.setFont(font);
		return style;
	}

	public static void exportExcel(Workbook wb, HttpServletResponse response, String fileName) throws OperException {
		OutputStream out = null;
		try {
			response.setContentType("multipart/form-data");
			response.reset(); // 非常重要
			// 纯下载方式
			response.setContentType("application/x-msdownload");
			response.setHeader("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("gb2312"), "ISO8859-1"));
			out = response.getOutputStream();
			wb.write(out);
		} catch (IOException e) {
			throw new OperException(文件导出异常);
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					throw new OperException(文件导出异常);
				}
			}
			if (wb != null) {
				try {
					wb.close();
				} catch (IOException e) {
					throw new OperException(文件导出异常);
				}
			}
		}
	}
	
	public static void exportExcel(HSSFWorkbook wb, File file) throws OperException {
		OutputStream out = null;
		try {
			out = new BufferedOutputStream(new FileOutputStream(file));
			wb.write(out);
		} catch (IOException e) {
			throw new OperException(文件导出异常);
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					throw new OperException(文件导出异常);
				}
			}
			
			if (wb != null) {
				try {
					wb.close();
				} catch (IOException e) {
					throw new OperException(文件导出异常);
				}
			}
		}
	}
	
	/**
	 * 判断此行是否为空：即无数据，也无样式
	 * @param row
	 * @return
	 */
	public static boolean isRowEmpty(Row row) {
		if(row == null)	{
			return true;
		}else{
		    for (int c = row.getFirstCellNum(); c < row.getLastCellNum(); c++) {
		        Cell cell = row.getCell(c);
		        if (cell != null && cell.getCellType() != Cell.CELL_TYPE_BLANK)
		            return false;
		    }
		}
	    return true;
	}
}
