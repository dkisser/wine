package org.lf.utils;

import org.apache.poi.ss.util.CellRangeAddress;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月18日 下午3:40:05 
 * @version 1.0 
 * @parameter
 */
public class CellRangeAddressWrapper implements Comparable<CellRangeAddressWrapper> {    
    
	public CellRangeAddress range;    
   
	public CellRangeAddressWrapper(CellRangeAddress theRange) {    
	     this.range = theRange;    
	}    
	   
	public int compareTo(CellRangeAddressWrapper craw) {    
	   if (range.getFirstColumn() < craw.range.getFirstColumn()    
	               && range.getFirstRow() < craw.range.getFirstRow()) {    
	         return -1;    
	   } else if (range.getFirstColumn() == craw.range.getFirstColumn()    
	               && range.getFirstRow() == craw.range.getFirstRow()) {    
	         return 0;    
	   } else {    
	         return 1;    
	   }    
	}
}