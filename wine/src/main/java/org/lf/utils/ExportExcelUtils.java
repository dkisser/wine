package org.lf.utils;

import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.lf.admin.db.dao.VOrderMapper;
import org.lf.admin.db.pojo.VOrder;
import org.lf.admin.service.OperErrCode;
import org.lf.admin.service.OperException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/** 
 * @author  wenchen 
 * @date 创建时间：2018年1月11日 下午1:07:20 
 * @version 1.0 
 * @parameter
 */
@Service
public class ExportExcelUtils {
	
	@Autowired
	private VOrderMapper vOrderDao;
	
	private static final OperErrCode 生成Excel出错 = new OperErrCode("002003002", "生成Excel出错");
	
	/**
	 * 
	 * @param mode 导出xls还是xlsx
	 * @param array 要到处的信息
	 * @param cdr	出单人
	 * @throws IOException
	 * @throws OperException 
	 */
	public static Workbook createExcel (int mode,List<VOrder> list,String cdr) throws IOException, OperException{
		if (list.size()==0){
			throw new OperException(生成Excel出错);
		}
		Workbook workBook = null;
        if (Mode.VERSION_H == mode){
            workBook = new HSSFWorkbook();
        }else if (Mode.VERSION_L == mode){
            workBook = new XSSFWorkbook();
        }else {
            workBook = new HSSFWorkbook();	
        }
		//若是oList大于100的情况
		if (list.size()>100){
			int num = list.size()%100==0?list.size()/100:list.size()/100+1;
			int rest= list.size();
			for (int i=0;i<num;i++){
				//创建工作簿
				Sheet sheet = workBook.createSheet();
				sheet.setDefaultColumnWidth(10);
				sheet.setDefaultRowHeightInPoints(24);
				sheet.setColumnHidden(4, true);
				sheet.setColumnHidden(7, true);
				//设置列宽
				setSheetWidth(sheet);
				//设置行高
				setSheetHeight(sheet);
				//创建第一个行对象
				createFirstRow(sheet, workBook);
				//设置第二行
				List<VOrder> oList = null;
				if (rest-i*100>=0){
					oList = new ArrayList<VOrder>(list.subList(i*100, i*100+100));
					rest-=100;
				} else {
					oList = new ArrayList<VOrder>(list.subList(i*100, i*100+rest));
				}
				createSecondRow(sheet, workBook,oList.get(0));
				//设置第三行
				createThridRow(sheet, workBook,oList,cdr);
				//设置中间打印条形码的部分
				createTable(sheet, workBook,oList);
				//设置最后部分
				createFinalRow(sheet, workBook);
			}
		} else {
			//若是oList.size()小于100的情况
			//创建工作簿
			Sheet sheet = workBook.createSheet();
			sheet.setDefaultColumnWidth(10);
			sheet.setDefaultRowHeightInPoints(24);
			sheet.setColumnHidden(4, true);
			sheet.setColumnHidden(7, true);
			//设置列宽
			setSheetWidth(sheet);
			//设置行高
			setSheetHeight(sheet);
			//创建第一个行对象
			createFirstRow(sheet, workBook);
			//设置第二行
			createSecondRow(sheet, workBook,list.get(0));
			//设置第三行
			createThridRow(sheet, workBook,list,cdr);
			//设置中间打印条形码的部分
			createTable(sheet, workBook,list);
			//设置最后部分
			createFinalRow(sheet, workBook);
		}
        
       return workBook;
	}
	
	/**
	 * 获得服务器上的excel表格来，填充数据，然后生成新的excel
	 * @param mode
	 * @param list
	 * @param cdr
	 * @return
	 * @throws IOException
	 * @throws OperException
	 */
	public static Workbook exportExcel (HttpSession session,int mode,List<VOrder> list,String cdr) throws IOException, OperException{
		if (list.size()==0){
			throw new OperException(生成Excel出错);
		}
		String fileName = "湖北白云边酒业产品溯源单 .xlsx";
		//获得文件的InputStream
		InputStream in = ExportExcelUtils.class.getResourceAsStream("/"+fileName);
		//从服务器上获得Excel,并读入Workbook中
		Workbook workBook = null;
        if (Mode.VERSION_H == mode){
            workBook = new HSSFWorkbook(in);
        }else if (Mode.VERSION_L == mode){
            workBook = new XSSFWorkbook(in);
        }else {
            workBook = new HSSFWorkbook(in);	
        }
		//若是oList大于100的情况
		if (list.size()>100){
			int num = list.size()%100==0?list.size()/100:list.size()/100+1;
			int rest= list.size();
			Sheet origin = workBook.getSheetAt(0);
			for (int i=0;i<num;i++){
				//创建工作簿
				Sheet sheet = null;
				if (i==0){
					sheet = origin;
				} else {
					sheet = workBook.createSheet();
					CopySheetUtils.copySheets(sheet, origin,true);
					insertPic(sheet, workBook, 2, 0);
				} 
				
				//填充第二行
				List<VOrder> oList = null;
				if (rest-i*100>=0){
					oList = new ArrayList<VOrder>(list.subList(i*100, i*100+100));
					rest-=100;
				} else {
					oList = new ArrayList<VOrder>(list.subList(i*100, i*100+rest));
				}
				setSecondRow(sheet, workBook,oList.get(0));
				//填充第三行
				setThridRow(sheet, workBook,oList,cdr);
				//填充中间打印条形码的部分
				setTable(sheet, workBook,oList);
			}
		} else {
			//若是oList.size()小于100的情况
			//获得工作簿
			Sheet sheet = workBook.getSheetAt(0);
			//填充第二行
			setSecondRow(sheet, workBook,list.get(0));
			//填充第三行
			setThridRow(sheet, workBook,list,cdr);
			//填充中间打印条形码的部分
			setTable(sheet, workBook,list);
		}
        
       return workBook;
	} 
	
	
	//设置列宽
	private static void setSheetWidth (Sheet sheet){
		sheet.setColumnWidth(0, 4*256);//设置第1列的宽
		sheet.setColumnWidth(1, 7*256);//设置第2列的宽
		sheet.setColumnWidth(2, 10*256);//设置第3列的宽
		sheet.setColumnWidth(3, 5*256);//设置第4列的宽
		sheet.setColumnHidden(4, false);
		sheet.setColumnWidth(4, 8*256);//设置第5列的宽
		sheet.setColumnWidth(5, 8*256);//设置第6列的宽
		sheet.setColumnWidth(6, 6*256);//设置第7列的宽
		sheet.setColumnHidden(7, false);
		sheet.setColumnWidth(7, 9*256);//设置第8列的宽
		sheet.setColumnWidth(8, 9*256);//设置第9列的宽
		sheet.setColumnWidth(9, 6*256);//设置第10列的宽
		sheet.setColumnWidth(10, 16*256);//设置第11列的宽
		sheet.setColumnWidth(11, 3*256);//设置第12列的宽
		sheet.setColumnWidth(12, 3*256);//设置第13列的宽
		sheet.setColumnWidth(13, 9*256);//设置第14列的宽
		sheet.setColumnWidth(14, 14*256);//设置第15列的宽
		
	}
	
	//设置行高宽
	private static void setSheetHeight (Sheet sheet){
		Row row5 = sheet.createRow(4);//设置第5行的高度
		Row row8 = sheet.createRow(7);//设置第8行的高度
		Row row29 = sheet.createRow(28);//设置第29行的高度
		Row row32 = sheet.createRow(31);//设置第32行的高度
		Row row34 = sheet.createRow(33);//设置第34行的高度
		Row row35 = sheet.createRow(34);//设置第35行的高度
		row5.setZeroHeight(true);//设置行高为0
		row8.setZeroHeight(true);//设置行高为0
		row29.setHeightInPoints(20);
		row32.setHeightInPoints(20);
		row34.setHeightInPoints(20);
		row35.setHeightInPoints(24);
	}
	
    /**
    *
    * @param originalImage 原始图片
    * @param times 放大/缩小参数
    * @return
    */
   public static BufferedImage  zoomInImage(BufferedImage  originalImage, int times){
       int width = originalImage.getWidth()/100*times;
       int height = originalImage.getHeight()/100*times;
       BufferedImage newImage = new BufferedImage(80,70,originalImage.getType());
       Graphics g = newImage.getGraphics();
       g.drawImage(originalImage, 0,0,80,70,null);//?不能等比例放大缩小
       g.dispose();
       return newImage;
   }
   
    public static ByteArrayOutputStream getImageInputStream() throws IOException {
        InputStream inputStream = ExportExcelUtils.class.getClassLoader().getResourceAsStream("pic/baiyunbian.jpg");
        ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();
        BufferedImage bufferImg = ImageIO.read(inputStream);
        BufferedImage outImg = zoomInImage(bufferImg, 30);
        ImageIO.write(outImg, "jpg", byteArrayOut);
        return byteArrayOut;
    }
    
    private static void insertPic (Sheet sheet, Workbook workBook,int col1,int row1) throws IOException{
    	int pictureIdx = workBook.addPicture(getImageInputStream().toByteArray(), Workbook.PICTURE_TYPE_JPEG);
        CreationHelper helper = workBook.getCreationHelper();
        Drawing drawing = sheet.createDrawingPatriarch();
        ClientAnchor anchor = helper.createClientAnchor();
        anchor.setCol1(col1);
        anchor.setRow1(row1);
        Picture picture = drawing.createPicture(anchor, pictureIdx);
        picture.resize();
    }
    
    private static void insertPicDes (Sheet sheet, Workbook workBook,int col1,int row1) throws IOException{
    	int pictureIdx = workBook.addPicture(getImageInputStream().toByteArray(), Workbook.PICTURE_TYPE_JPEG);
    	CreationHelper helper = workBook.getCreationHelper();
    	Drawing drawing = sheet.createDrawingPatriarch();
    	ClientAnchor anchor = helper.createClientAnchor();
    	anchor.setDx1(col1);
    	anchor.setDy1(row1);
    	Picture picture = drawing.createPicture(anchor, pictureIdx);
    	picture.resize();
    }
    
    //创建第一行
    private static void createFirstRow(Sheet sheet, Workbook workBook) throws IOException {
    	  //合并单元格
        sheet.addMergedRegion(new CellRangeAddress(0,1,0,4));
        sheet.addMergedRegion(new CellRangeAddress(0,1,5,14));
        
        Row row1 = sheet.createRow(0);
        Row row2 = sheet.createRow(1);
        row1.setHeightInPoints(28);
        row2.setHeightInPoints(28);
        //图片
        insertPic(sheet, workBook, 3, 0);
        
        for (int i=0;i<15;i++){
        	Cell cel = row1.createCell(i);
        	cel.setCellStyle(getFirstRowStyle(workBook));
        }
      
        //设置第一行，标题
        Cell cell1 = row1.getCell(5);
        cell1.setCellValue("湖北白云边酒业产品溯源单(物流码)");
    }
    
    //首行样式
    private static CellStyle getFirstRowStyle(Workbook workBook){
        CellStyle cellStyleFirst = workBook.createCellStyle();
        Font font = workBook.createFont();
        font.setBold(false);
        font.setFontName("宋体");
        font.setFontHeightInPoints((short) 20);
        cellStyleFirst.setFont(font);
        cellStyleFirst.setAlignment(HorizontalAlignment.LEFT);
        cellStyleFirst.setVerticalAlignment(VerticalAlignment.CENTER);
        DataFormat format = workBook.createDataFormat();
        cellStyleFirst.setDataFormat(format.getFormat("m/d/yy h:mm"));
        return cellStyleFirst;
    }
    
    //填充第二行的数据
    private static void setSecondRow(Sheet sheet,Workbook workBook,VOrder obj){
        Row row3 = sheet.getRow(3);
        for(int i=0;i<15;i++){
        	Cell cel = row3.getCell(i);
        	if (i==0){
        		cel.setCellValue(obj.getShz());
        	}
        	if (i==4){
        		cel.setCellValue(obj.getKhdh());
        	}
        	if (i==8){
        		cel.setCellValue(obj.getShdz());
        	}
        }
      
        
    }
    
    //创建第二行
    private static void createSecondRow(Sheet sheet,Workbook workBook,VOrder obj){
    	  
        //合并单元格
        sheet.addMergedRegion(new CellRangeAddress(2,2,0,3));
        sheet.addMergedRegion(new CellRangeAddress(2,2,4,7));
        sheet.addMergedRegion(new CellRangeAddress(2,2,8,14));
        sheet.addMergedRegion(new CellRangeAddress(3,3,0,3));
        sheet.addMergedRegion(new CellRangeAddress(3,3,4,7));
        sheet.addMergedRegion(new CellRangeAddress(3,3,8,14));
        
        Row row2 = sheet.createRow(2);
        row2.setHeightInPoints(20); 
        Row row3 = sheet.createRow(3);
        row3.setHeightInPoints(24); 
        CellStyle style = getCenter11Font(workBook);
        for(int i=0;i<15;i++){
        	Cell cel = row2.createCell(i);
        	if (i==0){
        		cel.setCellValue("收货客户");
        		cel.setCellStyle(getLeftBorder(style));
        	} else if (i==3){
        		cel.setCellStyle(getRightBorder(style));
        	}else if (i==4){
        		cel.setCellValue("客户电话");
        		cel.setCellStyle(getCenterBorder(style));
        	} else if (i==7){
        		cel.setCellStyle(getRightBorder(style));
        	}else if (i==8){
        		cel.setCellValue("客户地址");
        		cel.setCellStyle(getCenterBorder(style));
        	} else if (i==14){
        		cel.setCellStyle(getRightBorder(style));
        	}else {
        		cel.setCellStyle(getCenterBorder(style));
        	}
        }
        
        for(int i=0;i<15;i++){
        	Cell cel = row3.createCell(i);
        	if (i==0){
        		cel.setCellValue(obj.getShz());
        		cel.setCellStyle(getLeftBorder(style));
        	} else if (i==3){
        		cel.setCellStyle(getRightBorder(style));
        	}else if (i==4){
        		cel.setCellValue(obj.getKhdh());
        		cel.setCellStyle(getCenterBorder(style));
        	} else if (i==7){
        		cel.setCellStyle(getRightBorder(style));
        	}else if (i==8){
        		cel.setCellValue(obj.getShdz());
        		cel.setCellStyle(getCenterBorder(style));
        	} else if (i==14){
        		cel.setCellStyle(getRightBorder(style));
        	}else {
        		cel.setCellStyle(getCenterBorder(style));
        	}
        }
      
        
    }
    
    //填充第三行
    private static void setThridRow(Sheet sheet, Workbook workBook,List<VOrder> list,String cdr) throws OperException{
        Row row4 = sheet.getRow(6);
        VOrder obj = list.get(0);
        for(int i=0;i<15;i++){
        	Cell cel = row4.getCell(i);
        	if (i==0){
        		cel.setCellValue(obj.getYwy());
        	} else if (i==4){
        		cel.setCellValue(obj.getShy());
        	} else if (i==6){
        		cel.setCellValue(obj.getXsdh());
        	} else if (i==10){
        		try {
					cel.setCellValue(DateUtils.date2Str(new Date()));
				} catch (ParseException e) {
					e.printStackTrace();
					throw new OperException(生成Excel出错);
				}
        	} else if (i==11){
        		cel.setCellValue(list.size());
        	} else if (i==13){
        		cel.setCellValue(cdr);
        	}
        }
    }
    //创建第三行
    private static void createThridRow(Sheet sheet, Workbook workBook,List<VOrder> list,String cdr) throws OperException{
    	//单元格合并
    	sheet.addMergedRegion(new CellRangeAddress(5,5,0,3));
    	sheet.addMergedRegion(new CellRangeAddress(5,5,4,5));
    	sheet.addMergedRegion(new CellRangeAddress(5,5,6,9));
    	sheet.addMergedRegion(new CellRangeAddress(5,5,11,12));
    	sheet.addMergedRegion(new CellRangeAddress(5,5,13,14));
    	sheet.addMergedRegion(new CellRangeAddress(6,6,0,3));
    	sheet.addMergedRegion(new CellRangeAddress(6,6,4,5));
    	sheet.addMergedRegion(new CellRangeAddress(6,6,6,9));
    	sheet.addMergedRegion(new CellRangeAddress(6,6,11,12));
    	sheet.addMergedRegion(new CellRangeAddress(6,6,13,14));
    	
    	Row row3 = sheet.createRow(5);
    	row3.setHeightInPoints(20);
    	Row row4 = sheet.createRow(6);
    	row4.setHeightInPoints(24);
    	CellStyle cellStyle = getCenter11Font(workBook);
    	VOrder obj = list.get(0);
    	for(int i=0;i<15;i++){
    		Cell cel = row3.createCell(i);
    		if (i==0){
    			cel.setCellValue("此单负责业务员");
    			cel.setCellStyle(getLeftBorder(cellStyle));
    		} else if (i==3){
    			cel.setCellStyle(getRightBorder(cellStyle));
    		}else if (i==4){
    			cel.setCellValue("送货人");
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		} else if (i==5){
    			cel.setCellStyle(getRightBorder(cellStyle));
    		} else if (i==6){
    			cel.setCellValue("销售单号");
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		} else if (i==9){
    			cel.setCellStyle(getRightBorder(cellStyle));
    		}else if (i==10){
    			cel.setCellValue("出单日期");
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		} else if (i==11){
    			cel.setCellValue("件数");
    			cel.setCellStyle(getRightBorder(cellStyle));
    		}else if (i==12){
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		} else if (i==13){
    			cel.setCellValue("出单人");
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		} else if (i==14){
    			cel.setCellStyle(getRightBorder(cellStyle));
    		} else {
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		}
    	}
    	
    	for(int i=0;i<15;i++){
    		Cell cel = row4.createCell(i);
    		if (i==0){
    			cel.setCellValue(obj.getYwy());
    			cel.setCellStyle(getLeftBorder(cellStyle));
    		} else if (i==3){
    			cel.setCellStyle(getRightBorder(cellStyle));
    		}else if (i==4){
    			cel.setCellValue(obj.getShy());
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		} else if (i==5){
    			cel.setCellStyle(getRightBorder(cellStyle));
    		} else if (i==6){
    			cel.setCellValue(obj.getXsdh());
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		} else if (i==9){
    			cel.setCellStyle(getRightBorder(cellStyle));
    		}else if (i==10){
    			try {
    				cel.setCellValue(DateUtils.date2Str(new Date()));
    			} catch (ParseException e) {
    				e.printStackTrace();
    				throw new OperException(生成Excel出错);
    			}
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		} else if (i==11){
    			cel.setCellValue(list.size());
    			cel.setCellStyle(getRightBorder(cellStyle));
    		}else if (i==12){
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		} else if (i==13){
    			cel.setCellValue(cdr);
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		} else if (i==14){
    			cel.setCellStyle(getRightBorder(cellStyle));
    		} else {
    			cel.setCellStyle(getCenterBorder(cellStyle));
    		}
    	}
    }
    
    //填充中间打印条形码的部分
  	private static void setTable (Sheet sheet,Workbook workBook,List<VOrder> list){
  		int rowNum = list.size()%5==0?list.size()/5:list.size()/5+1;
  		for (int i=0;i<rowNum;i++){
  			Row row = sheet.getRow(i+8);
  			if (list.size()-5*i>5){
  				//打印5*i-5*i+5的值
  				Cell cel1 = row.getCell(1);
  				cel1.setCellValue(list.get(i*5).getTxm());
  				Cell cel2 = row.getCell(4);
  				cel2.setCellValue(list.get(i*5+1).getTxm());
  				Cell cel3 = row.getCell(7);
  				cel3.setCellValue(list.get(i*5+2).getTxm());
  				Cell cel4 = row.getCell(10);
  				cel4.setCellValue(list.get(i*5+3).getTxm());
  				Cell cel5 = row.getCell(13);
  				cel5.setCellValue(list.get(i*5+4).getTxm());
  			} else {
  				//打印5*i到list。size（）的值
  				int num = list.size()-5*i;
  				if (num>0){
  					Cell cel1 = row.getCell(1);
  	  				cel1.setCellValue(list.get(i*5).getTxm());
  				}
  				if (num>1){
  					Cell cel2 = row.getCell(4);
  	  				cel2.setCellValue(list.get(i*5+1).getTxm());
  				}
  				if (num>2){
  					Cell cel3 = row.getCell(7);
  	  				cel3.setCellValue(list.get(i*5+2).getTxm());
  				}
  				if (num>3){
  					Cell cel4 = row.getCell(10);
  	  				cel4.setCellValue(list.get(i*5+3).getTxm());
  				}
  				if (num>4){
  					Cell cel5 = row.getCell(13);
  	  				cel5.setCellValue(list.get(i*5+4).getTxm());
  				}
  			}
  		}
  	}
  	//中间打印条形码的部分
  	private static void createTable (Sheet sheet,Workbook workBook,List<VOrder> list){
  		CellStyle allStyle = getAllBorder(getCenter11Font(workBook));
  		CellStyle rightStyle = getRightBorder(getCenter11Font(workBook));
  		for (int i=8;i<28;i++){
  			Row row = sheet.createRow(i);
  			row.setHeightInPoints(24);
  			for (int j=0;j<15;j++){
  				Cell cel = row.createCell(j);
  				if (j==0){
  					cel.setCellValue(i-7);
  					cel.setCellStyle(allStyle);
  				} else {
  					cel.setCellStyle(rightStyle);
  				}
  			}
  			sheet.addMergedRegion(new CellRangeAddress(i,i,1,3));
  			sheet.addMergedRegion(new CellRangeAddress(i,i,4,6));
  			sheet.addMergedRegion(new CellRangeAddress(i,i,7,9));
  			sheet.addMergedRegion(new CellRangeAddress(i,i,10,12));
  			sheet.addMergedRegion(new CellRangeAddress(i,i,13,14));
  		}
  		int rowNum = list.size()%5==0?list.size()/5:list.size()/5+1;
  		for (int i=0;i<rowNum;i++){
  			Row row = sheet.getRow(i+8);
  			if (list.size()-5*i>5){
  				//打印5*i-5*i+5的值
  				Cell cel1 = row.getCell(1);
  				cel1.setCellValue(list.get(i*5).getTxm());
  				Cell cel2 = row.getCell(4);
  				cel2.setCellValue(list.get(i*5+1).getTxm());
  				Cell cel3 = row.getCell(7);
  				cel3.setCellValue(list.get(i*5+2).getTxm());
  				Cell cel4 = row.getCell(10);
  				cel4.setCellValue(list.get(i*5+3).getTxm());
  				Cell cel5 = row.getCell(13);
  				cel5.setCellValue(list.get(i*5+4).getTxm());
  			} else {
  				//打印5*i到list。size（）的值
  				int num = list.size()-5*i;
  				if (num>0){
  					Cell cel1 = row.getCell(1);
  					cel1.setCellValue(list.get(i*5).getTxm());
  				}
  				if (num>1){
  					Cell cel2 = row.getCell(4);
  					cel2.setCellValue(list.get(i*5+1).getTxm());
  				}
  				if (num>2){
  					Cell cel3 = row.getCell(7);
  					cel3.setCellValue(list.get(i*5+2).getTxm());
  				}
  				if (num>3){
  					Cell cel4 = row.getCell(10);
  					cel4.setCellValue(list.get(i*5+3).getTxm());
  				}
  				if (num>4){
  					Cell cel5 = row.getCell(13);
  					cel5.setCellValue(list.get(i*5+4).getTxm());
  				}
  			}
  		}
  	}
    
    //创建最后面的说明
    private static void createFinalRow(Sheet sheet, Workbook workBook){
    	//单元格合并
    	sheet.addMergedRegion(new CellRangeAddress(28,28,0,14));
        sheet.addMergedRegion(new CellRangeAddress(29,29,0,14));
        sheet.addMergedRegion(new CellRangeAddress(30,30,0,14));
        sheet.addMergedRegion(new CellRangeAddress(31,31,0,14));
        sheet.addMergedRegion(new CellRangeAddress(32,32,0,10));
        sheet.addMergedRegion(new CellRangeAddress(33,33,0,3));
        sheet.addMergedRegion(new CellRangeAddress(33,33,10,14));
        
        Row row29 = sheet.createRow(28);
        row29.setHeightInPoints((short)20);
        CellStyle cellStyle29 = getLeft11Font(workBook);
        Cell row29_cel = row29.createCell(0);
        row29_cel.setCellValue("白云边产品物流码说明");
        row29_cel.setCellStyle(cellStyle29);
        
        Row row30 = sheet.createRow(29);
        row30.setHeightInPoints((short)24);
        CellStyle cellStyle30 = getLeft9Font(workBook);
        Cell row30_cel = row30.createCell(0);
        row30_cel.setCellValue("1、每一件白云边酒类产品的外箱侧都有一组18位数字组成的条形码标识,该标识即为该件商品的身份证明和市场流向记录.详情备案在我公司的数据库里.");
        row30_cel.setCellStyle(cellStyle30);
        
        Row row31 = sheet.createRow(30);
        row31.setHeightInPoints((short)24);
        Cell row31_cel = row31.createCell(0);
        row31_cel.setCellValue("2、根据国家对食品药品管理的有关规定,为了方便终端客户建立朔源台账,特随货同行此单,并由当地经销商报备当地食品药品监督管理局以便考察.");
        row31_cel.setCellStyle(cellStyle30);
        
        Row row32 = sheet.createRow(31);
        row32.setHeightInPoints((short)24);
        Cell row32_cel = row32.createCell(0);
        row32_cel.setCellValue("3、多数大流通类产品都反对窜区销售,我们也一样.敬请支持当地业务员的工作,请在此单底部签上您的名字,谢谢!");
        row32_cel.setCellStyle(cellStyle30);
        
        Row row33 = sheet.createRow(32);
        row33.setHeightInPoints((short)24);
        Cell row33_cel = row33.createCell(0);
        row33_cel.setCellValue("(此单白联:当地经销商;红联:开单客户)");
        row33_cel.setCellStyle(cellStyle30);
        
        Row row34 = sheet.createRow(33);
        row34.setHeightInPoints((short)20);
        Cell row34_cel0 = row34.createCell(0);
        row34_cel0.setCellValue("收货客户签名：");
        row34_cel0.setCellStyle(cellStyle30);
        Cell row34_cel1 = row34.createCell(10);
        row34_cel1.setCellValue("湖北白云边酒业股份有限公司");
        row34_cel1.setCellStyle(getCenter10Font(workBook));
        
    }
    
    
    /**
     * 设置字体的样式为 宋体 11号 水平居中 垂直居中
     * @param workbook
     * @return
     */
    private static CellStyle getCenter11Font(Workbook workbook){
        CellStyle cellStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(false);
        font.setFontName("宋体");
        font.setFontHeightInPoints((short)11);
        cellStyle.setFont(font);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        return cellStyle;
    }
    
    /**
     * 设置字体的样式为 宋体 10号 水平居中 垂直居中
     * @param workbook
     * @return
     */
    private static CellStyle getCenter10Font(Workbook workbook){
        CellStyle cellStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(false);
        font.setFontName("宋体");
        font.setFontHeightInPoints((short)10);
        cellStyle.setFont(font);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        return cellStyle;
    }
    
    /**
     * 设置字体的样式为 宋体 10号 左对齐 垂直居中
     * @param workbook
     * @return
     */
    private static CellStyle getLeft10Font(Workbook workbook){
        CellStyle cellStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(false);
        font.setFontName("宋体");
        font.setFontHeightInPoints((short)10);
        cellStyle.setFont(font);
        cellStyle.setAlignment(HorizontalAlignment.LEFT);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        return cellStyle;
    }
    
    /**
     * 设置字体的样式为 宋体 9号 左对齐 垂直居中
     * @param workbook
     * @return
     */
    private static CellStyle getLeft9Font(Workbook workbook){
    	CellStyle cellStyle = workbook.createCellStyle();
    	Font font = workbook.createFont();
    	font.setBold(false);
    	font.setFontName("宋体");
    	font.setFontHeightInPoints((short)9);
    	cellStyle.setFont(font);
    	cellStyle.setAlignment(HorizontalAlignment.LEFT);
    	cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
    	return cellStyle;
    }
    
    /**
     * 设置字体的样式为 宋体 11号 左对齐 垂直居中
     * @param workbook
     * @return
     */
    //获得最后面的说明样式
    private static CellStyle getLeft11Font(Workbook workbook){
        CellStyle cellStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(false);
        font.setFontName("宋体");
        font.setFontHeightInPoints((short)11);
        cellStyle.setFont(font);
        cellStyle.setAlignment(HorizontalAlignment.LEFT);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        return cellStyle;
    }
    
    /**
     * 设置上下左边加边框
     * @param workbook
     * @return
     */
    private static CellStyle getLeftBorder(CellStyle cellStyle){
        cellStyle.setBorderTop(BorderStyle.THIN);
        cellStyle.setBorderBottom(BorderStyle.THIN);
        cellStyle.setBorderLeft(BorderStyle.THIN);
        return cellStyle;
    }
    
    /**
     * 设置所有边边加边框
     * @param workbook
     * @return
     */
    private static CellStyle getAllBorder(CellStyle cellStyle){
        cellStyle.setBorderTop(BorderStyle.THIN);
        cellStyle.setBorderRight(BorderStyle.THIN);
        cellStyle.setBorderBottom(BorderStyle.THIN);
        cellStyle.setBorderLeft(BorderStyle.THIN);
        return cellStyle;
    }
    
    /**
     * 设置上下加边框
     * @param workbook
     * @return
     */
    private static CellStyle getCenterBorder(CellStyle cellStyle){
        cellStyle.setBorderTop(BorderStyle.THIN);
        cellStyle.setBorderBottom(BorderStyle.THIN);
        return cellStyle;
    }
    
    /**
     * 设置上下右边加边框
     * @param workbook
     * @return
     */
    private static CellStyle getRightBorder(CellStyle cellStyle){
    	cellStyle.setBorderTop(BorderStyle.THIN);
    	cellStyle.setBorderRight(BorderStyle.THIN);
    	cellStyle.setBorderBottom(BorderStyle.THIN);
    	return cellStyle;
    }
    
}
