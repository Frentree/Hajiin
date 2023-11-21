
package com.org.iopts.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class ExceltoJson {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@SuppressWarnings("unchecked")
	public byte[] writeExcel(ArrayList<?> list) 
	{
		//엑셀이 데이터 헤더 시작
		ObjectMapper mapper = new ObjectMapper(); 
		Map<String, Object> SupplySampleHeaderMap = new HashMap<String, Object>(); 
		String ExportSupplySampleHeader = "{\"seq_no\":\"연번\",\"doc_nm\":\"의료인\",\"clinic_nm\":\"기관명칭\",\"yoyang_cd\":\"요양기관기호/주소\",\"prod_cd\":\"제품코드\",\"prod_nm\":\"제품명\",\"packing_qty\":\"포장수장\",\"supply_qty\":\"제공수량\",\"prod_tot_qty\":\"계\",\"supply_dt\":\"제공일자\",\"file_name\":\"첨부파일명\",\"note\":\"비고\"}";
		try {
			SupplySampleHeaderMap = mapper.readValue(ExportSupplySampleHeader, new TypeReference<Map<String, String>>(){});
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		@SuppressWarnings("resource")
		XSSFWorkbook workbook = new XSSFWorkbook();
		XSSFSheet sheet = workbook.createSheet("ExcelSheet");
		XSSFRow row = null;
		XSSFRow row1 = null;
		XSSFCell cell = null;
		XSSFCell mergedCell = null;
		
		/* 엑셀의 Data 부분의 Style */
		XSSFFont bodyFont = workbook.createFont();
		bodyFont.setFontHeightInPoints((short) 10);
		bodyFont.setFontName("맑은 고딕");
		bodyFont.setItalic(false);
		bodyFont.setColor(IndexedColors.BLACK.getIndex());
		XSSFCellStyle bodyStyle = workbook.createCellStyle();
		bodyStyle.setFont(bodyFont);

		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		bodyStyle.setBorderRight(BorderStyle.THIN);
		bodyStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
		bodyStyle.setBorderTop(BorderStyle.THIN);	
		bodyStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
		bodyStyle.setAlignment(HorizontalAlignment.CENTER);
		bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		bodyStyle.setWrapText(true);

		/* 엑셀의 Header 제목부분의 Style */
		XSSFCellStyle titleStyle = workbook.createCellStyle();
		titleStyle.cloneStyleFrom(bodyStyle);
		titleStyle.setAlignment(HorizontalAlignment.LEFT);
		
		/* 엑셀의 Header 부분의 Style */
		XSSFCellStyle headerStyle = workbook.createCellStyle();
		headerStyle.cloneStyleFrom(bodyStyle);
		headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());  
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        row = sheet.createRow(0);
        int j = 0;
		Iterator<String> keys = SupplySampleHeaderMap.keySet().iterator();
        while( keys.hasNext() ){
            String key = keys.next();
        	cell = row.createCell(j);
        	String cellValue = String.valueOf(SupplySampleHeaderMap.get(key));
    		cell.setCellValue(cellValue);
    		cell.setCellStyle(headerStyle);   
    		j++;     	
        }
		
		
		for (int i = 0; i < list.size(); i++) {
			/* 엑셀의  헤더 Merge 여부 확인 - Merge가 있는 것과 없는 것이 다르다*/
			row = sheet.createRow(i+1);

			int j1 = 0;
			Map<String,Object> listMap = (Map<String, Object>) list.get(i);
			Iterator<String> keys1 = SupplySampleHeaderMap.keySet().iterator();
	        while( keys1.hasNext() ){
	            String key = keys1.next();
	        	cell = row.createCell(j1);
	        	String cellValue = String.valueOf(listMap.get(key));
	        	if (cellValue.equals("null")) cellValue = "";
		        cell.setCellValue(cellValue);
		        cell.setCellStyle(bodyStyle);
		        j1++;
	        }
		}

		int MIN_WIDTH = 1500;
		for (int x = 0; x < row.getPhysicalNumberOfCells(); x++) {
			sheet.autoSizeColumn(x);
			if (sheet.getColumnWidth(x) < MIN_WIDTH) sheet.setColumnWidth(x, MIN_WIDTH);
		}
		
		byte[] bytes = new byte[0];
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        try {
        	workbook.write(out);
            bytes = out.toByteArray();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return bytes;
	}


} //public class ExceltoJson