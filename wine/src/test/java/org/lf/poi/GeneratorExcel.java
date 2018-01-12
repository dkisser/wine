package org.lf.poi;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
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

public class GeneratorExcel {
	
    public static void main(String...args) throws IOException, InvalidFormatException {
        GeneratorExcel generatorExcel = new GeneratorExcel();
        generatorExcel.createExcel(0, null);
    }

    public  ByteArrayOutputStream getImageInputStream() throws IOException {
        InputStream inputStream = this.getClass().getResourceAsStream("/baiyunbian.jpg");
        ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();
        BufferedImage bufferImg = ImageIO.read(inputStream);
        BufferedImage outImg = zoomInImage(bufferImg, 30);
        ImageIO.write(outImg, "jpg", byteArrayOut);
        return byteArrayOut;
    }


    public  void createExcel(int mode, Map<String, Object> objMap) throws IOException, InvalidFormatException {
        Workbook workBook = null;
        if (Mode.VERSION_H == mode){
            workBook = new HSSFWorkbook();
        }else if (Mode.VERSION_L == mode){
            workBook = new XSSFWorkbook();
        }else {
            workBook = new HSSFWorkbook();
        }

        //创建工作簿
        Sheet sheet = workBook.createSheet();
        sheet.setDefaultColumnWidth(10);
        sheet.setDefaultRowHeight((short) 20);
        //合并单元格
        mergedRegion(sheet);

        //创建第一个行对象
        createFirstRow(sheet, workBook);

        //设置第二行
        createSecondRow(sheet, workBook);
        createThridRow(sheet, workBook, objMap);
        createFourRow(sheet,workBook, 4, null);
        createFourRow(sheet,workBook, 5, objMap);

        FileOutputStream os = new FileOutputStream("e:\\test.xls");
        workBook.write(os);
        os.close();
    }
    //合并单元格
    private void mergedRegion(Sheet sheet){
        CellRangeAddress cellRangeAddress = new CellRangeAddress(1,1,2,8);
        CellRangeAddress cellRangeAddressOther = new CellRangeAddress(2,2,0,2);//合并单元格
        CellRangeAddress cellRangeAddressOther1 = new CellRangeAddress(2,2,3,5);//合并单元格
        CellRangeAddress cellRangeAddressOther2 = new CellRangeAddress(2,2,6,8);//合并单元格
        CellRangeAddress cellRangeAddressOther3 = new CellRangeAddress(3,3,0,2);//合并单元格
        CellRangeAddress cellRangeAddressOther4 = new CellRangeAddress(3,3,3,5);//合并单元格
        CellRangeAddress cellRangeAddressOther5 = new CellRangeAddress(3,3,6,8);//合并单元格
        CellRangeAddress cellRangeAddressOther6 = new CellRangeAddress(4,4,0,2);//合并单元格
        CellRangeAddress cellRangeAddressOther7 = new CellRangeAddress(4,4,4,5);//合并单元格
        CellRangeAddress cellRangeAddressOther8 = new CellRangeAddress(5,5,0,2);//合并单元格
        CellRangeAddress cellRangeAddressOther9 = new CellRangeAddress(5,5,4,5);//合并单元格
        sheet.addMergedRegion(cellRangeAddress);
        sheet.addMergedRegion(cellRangeAddressOther);
        sheet.addMergedRegion(cellRangeAddressOther1);
        sheet.addMergedRegion(cellRangeAddressOther2);
        sheet.addMergedRegion(cellRangeAddressOther3);
        sheet.addMergedRegion(cellRangeAddressOther4);
        sheet.addMergedRegion(cellRangeAddressOther5);
        sheet.addMergedRegion(cellRangeAddressOther6);
        sheet.addMergedRegion(cellRangeAddressOther7);
        sheet.addMergedRegion(cellRangeAddressOther8);
        sheet.addMergedRegion(cellRangeAddressOther9);
    }
    //创建第一行
    private void createFirstRow(Sheet sheet, Workbook workBook) throws IOException {
        Row row1 = sheet.createRow(1);
        row1.setHeightInPoints(60);

        //图片
        int pictureIdx = workBook.addPicture(getImageInputStream().toByteArray(), Workbook.PICTURE_TYPE_JPEG);
        CreationHelper helper = workBook.getCreationHelper();
        Drawing drawing = sheet.createDrawingPatriarch();
        ClientAnchor anchor = helper.createClientAnchor();
        anchor.setCol1(1);
        anchor.setRow1(1);
        anchor.setDx1(3);
        anchor.setDy1(20);
        Picture picture = drawing.createPicture(anchor, pictureIdx);
        picture.resize();
        //设置第一行，标题
        Cell cell1 = row1.createCell(2);
        cell1.setCellValue("湖北白云边酒业产品溯源单(物流码)");
        cell1.setCellStyle(getFirstRowStyle(workBook));
    }

    //创建第二行
    private void createSecondRow(Sheet sheet,Workbook workBook){
        Row row2 = sheet.createRow(2);
        row2.setHeightInPoints((short)25);

        Cell row2_cel0 = row2.createCell(0);
        row2_cel0.setCellStyle(getSecondRowStyle(workBook));
        row2_cel0.setCellValue("收货客户");//属性:customerName

        Cell row2_cel1 = row2.createCell(3);
        row2_cel1.setCellValue("客户电话");//属性:customerTel
        row2_cel1.setCellStyle(getSecondRowStyle(workBook));

        Cell row2_cel2 = row2.createCell(6);
        row2_cel2.setCellValue("客户地址");//属性:customerAddress
        row2_cel2.setCellStyle(getSecondRowStyle(workBook));
    }

    //创建第三行
    private void createThridRow(Sheet sheet, Workbook workBook, Map<String, Object> objectMap){
        Row row3 = sheet.createRow(3);
        row3.setHeightInPoints((short)25);
        CellStyle cellStyle = getThridRowStyle(workBook);
        Cell row3_cel0 = row3.createCell(0);
        row3_cel0.setCellStyle(cellStyle);
        row3_cel0.setCellValue("习大大");//属性:customerName

        Cell row3_cel1 = row3.createCell(3);
        row3_cel1.setCellValue("18888888888");//属性:customerTel
        row3_cel1.setCellStyle(cellStyle);

        Cell row3_cel2 = row3.createCell(6);
        row3_cel2.setCellValue("湖北省黄石市");//属性:customerAddress
        row3_cel2.setCellStyle(cellStyle);
    }

    //创建第四行
    private void createFourRow(Sheet sheet, Workbook workBook,int row, Map<String, Object> objectMap){
        Row row3 = sheet.createRow(row);
        row3.setHeightInPoints((short)25);
        CellStyle cellStyle = null;
        if(row == 4){
            cellStyle = getSecondRowStyle(workBook);
            Cell row3_cel0 = row3.createCell(0);
            row3_cel0.setCellStyle(cellStyle);
            row3_cel0.setCellValue("此单负责业务员");//属性:customerName

            Cell row3_cel1 = row3.createCell(3);
            row3_cel1.setCellValue("送货人");//属性:customerTel
            row3_cel1.setCellStyle(cellStyle);

            Cell row3_cel2 = row3.createCell(4);
            row3_cel2.setCellValue("销售单号");//属性:customerAddress
            row3_cel2.setCellStyle(cellStyle);

            Cell row3_cel6 = row3.createCell(6);
            row3_cel6.setCellValue("出单日期");//属性:customerAddress
            row3_cel6.setCellStyle(cellStyle);

            Cell row3_cel7 = row3.createCell(7);
            row3_cel7.setCellValue("件数");//属性:customerAddress
            row3_cel7.setCellStyle(cellStyle);

            Cell row3_cel8 = row3.createCell(8);
            row3_cel8.setCellValue("出单人");//属性:customerAddress
            row3_cel8.setCellStyle(cellStyle);
        }else {
            cellStyle = getThridRowStyle(workBook);
            Cell row3_cel0 = row3.createCell(0);
            row3_cel0.setCellStyle(cellStyle);
            row3_cel0.setCellValue("tom");//属性:customerName

            Cell row3_cel1 = row3.createCell(3);
            row3_cel1.setCellValue("mike");//属性:customerTel
            row3_cel1.setCellStyle(cellStyle);

            Cell row3_cel2 = row3.createCell(4);
            row3_cel2.setCellValue("xxxxx-asssdfbb");//属性:customerAddress
            row3_cel2.setCellStyle(cellStyle);

            Cell row3_cel6 = row3.createCell(6);
            row3_cel6.setCellValue("afdsjfa");//属性:customerAddress
            row3_cel6.setCellStyle(cellStyle);

            Cell row3_cel7 = row3.createCell(7);
            row3_cel7.setCellValue("10");//属性:customerAddress
            row3_cel7.setCellStyle(cellStyle);

            Cell row3_cel8 = row3.createCell(8);
            row3_cel8.setCellValue("啊偶尔");//属性:customerAddress
            row3_cel8.setCellStyle(cellStyle);
        }
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
        g.drawImage(originalImage, 0,0,80,70,null);
        g.dispose();
        URLClassLoader classLoader = new URLClassLoader(new URL[]{});
        return newImage;
    }


    //首行样式
    private CellStyle getFirstRowStyle(Workbook workBook){
        CellStyle cellStyleFirst = workBook.createCellStyle();
        Font font = workBook.createFont();
        font.setBold(true);
        font.setFontName("黑体");
        font.setFontHeightInPoints((short) 22);
        cellStyleFirst.setFont(font);
        cellStyleFirst.setAlignment(HorizontalAlignment.LEFT);
        cellStyleFirst.setVerticalAlignment(VerticalAlignment.CENTER);
        DataFormat format = workBook.createDataFormat();
        cellStyleFirst.setDataFormat(format.getFormat("m/d/yy h:mm"));
        return cellStyleFirst;
    }

    //获得第二行样式
    private CellStyle getSecondRowStyle(Workbook workbook){
        CellStyle cellStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short)10);
        cellStyle.setFont(font);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        return cellStyle;
    }

    //获得第三行样式
    private CellStyle getThridRowStyle(Workbook workbook){
        CellStyle cellStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(false);
        font.setFontHeightInPoints((short)10);
        cellStyle.setFont(font);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        return cellStyle;
    }

}
