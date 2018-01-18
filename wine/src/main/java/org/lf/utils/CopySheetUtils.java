package org.lf.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月18日 下午3:34:16 
 * @version 1.0 
 * @parameter
 */
public class CopySheetUtils {
	
	public static void copySheets(Sheet newSheet, Sheet sheet) {  
        copySheets(newSheet, sheet, true);  
    }  
  
    public static void copySheets(Sheet newSheet, Sheet sheet,  
            boolean copyStyle) {  
        int maxColumnNum = 0;  
        Map<Integer, CellStyle> styleMap = (copyStyle) ? new HashMap<Integer, CellStyle>()  
                : null;  
        for (int i = sheet.getFirstRowNum(); i <= sheet.getLastRowNum(); i++) {  
            Row srcRow = sheet.getRow(i);  
            Row destRow = newSheet.createRow(i);  
            //TODO: 这里需要修改(合并有重复的列时会出问题)
            if (i==1){
            	destRow.setHeight(srcRow.getHeight());
            	continue;
            }
            if (srcRow != null) {  
                CopySheetUtils.copyRow(sheet, newSheet, srcRow, destRow,  
                        styleMap);  
                if (srcRow.getLastCellNum() > maxColumnNum) {  
                    maxColumnNum = srcRow.getLastCellNum();  
                }  
            }  
        }  
        for (int i = 0; i <= maxColumnNum; i++) {    //设置列宽  
            newSheet.setColumnWidth(i, sheet.getColumnWidth(i));  
        }  
    }  
  
    /** 
     * 复制并合并单元格 
     * @param newSheet 
     * @param sheet 
     * @param copyStyle 
     */  
    public static void copyRow(Sheet srcSheet, Sheet destSheet,  
            Row srcRow, Row destRow,  
            Map<Integer, CellStyle> styleMap) {  
        Set<CellRangeAddressWrapper> mergedRegions = new TreeSet<CellRangeAddressWrapper>();  
        destRow.setHeight(srcRow.getHeight());  
        int deltaRows = destRow.getRowNum() - srcRow.getRowNum(); //如果copy到另一个sheet的起始行数不同  
        for (int j = srcRow.getFirstCellNum(); j <= srcRow.getLastCellNum(); j++) {  
        	if (srcRow.getZeroHeight()){
        		destRow.setZeroHeight(true);
        		break;
        	}
            Cell oldCell = srcRow.getCell(j); // old cell  
            Cell newCell = destRow.getCell(j); // new cell  
            if (oldCell != null) {  
                if (newCell == null) {  
                    newCell = destRow.createCell(j);  
                }  
                copyCell(oldCell, newCell, styleMap);  
                CellRangeAddress mergedRegion = getMergedRegion(srcSheet,  
                        srcRow.getRowNum(), (short) oldCell.getColumnIndex());  
                if (mergedRegion != null) {  
                    CellRangeAddress newMergedRegion = new CellRangeAddress(  
                            mergedRegion.getFirstRow() + deltaRows,  
                            mergedRegion.getLastRow() + deltaRows, mergedRegion  
                                    .getFirstColumn(), mergedRegion  
                                    .getLastColumn());  
                    CellRangeAddressWrapper wrapper = new CellRangeAddressWrapper(  
                            newMergedRegion);  
                    if (isNewMergedRegion(wrapper, mergedRegions)) {  
                        mergedRegions.add(wrapper);  
                        destSheet.addMergedRegion(wrapper.range);  
                    }  
                }  
            }  
        }  
    }  
  
    /** 
     * 把原来的Sheet中cell（列）的样式和数据类型复制到新的sheet的cell（列）中 
     *  
     * @param oldCell 
     * @param newCell 
     * @param styleMap 
     */  
    public static void copyCell(Cell oldCell, Cell newCell,  
            Map<Integer, CellStyle> styleMap) {  
        if (styleMap != null) {  
            if (oldCell.getSheet().getWorkbook() == newCell.getSheet()  
                    .getWorkbook()) {  
                newCell.setCellStyle(oldCell.getCellStyle());  
            } else {  
                int stHashCode = oldCell.getCellStyle().hashCode();  
                CellStyle newCellStyle = styleMap.get(stHashCode);  
                if (newCellStyle == null) {  
                    newCellStyle = newCell.getSheet().getWorkbook()  
                            .createCellStyle();  
                    newCellStyle.cloneStyleFrom(oldCell.getCellStyle());  
                    styleMap.put(stHashCode, newCellStyle);  
                }  
                newCell.setCellStyle(newCellStyle);  
            }  
        }  
        switch (oldCell.getCellType()) {  
        case Cell.CELL_TYPE_STRING:  
            newCell.setCellValue(oldCell.getStringCellValue());  
            break;  
        case Cell.CELL_TYPE_NUMERIC:  
            newCell.setCellValue(oldCell.getNumericCellValue());  
            break;  
        case Cell.CELL_TYPE_BLANK:  
            newCell.setCellType(HSSFCell.CELL_TYPE_BLANK);  
            break;  
        case Cell.CELL_TYPE_BOOLEAN:  
            newCell.setCellValue(oldCell.getBooleanCellValue());  
            break;  
        case Cell.CELL_TYPE_ERROR:  
            newCell.setCellErrorValue(oldCell.getErrorCellValue());  
            break;  
        case Cell.CELL_TYPE_FORMULA:  
            newCell.setCellFormula(oldCell.getCellFormula());  
            break;  
        default:  
            break;  
        }  
  
    } 
    // 获取merge对象  
    public static CellRangeAddress getMergedRegion(Sheet sheet, int rowNum,  
            short cellNum) {  
        for (int i = 0; i < sheet.getNumMergedRegions(); i++) {  
            CellRangeAddress merged = sheet.getMergedRegion(i);  
            if (merged.isInRange(rowNum, cellNum)) {  
                return merged;  
            }  
        }  
        return null;  
    }  
  
    private static boolean isNewMergedRegion(  
            CellRangeAddressWrapper newMergedRegion,  
            Set<CellRangeAddressWrapper> mergedRegions) {  
        boolean bool = mergedRegions.contains(newMergedRegion);  
        return !bool;  
    }  
}
