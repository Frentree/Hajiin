package com.org.iopts.util;


import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;

import javax.xml.parsers.ParserConfigurationException;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.BuiltinFormats;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.xssf.eventusermodel.ReadOnlySharedStringsTable;
import org.apache.poi.xssf.eventusermodel.XSSFReader;
import org.apache.poi.xssf.model.SharedStringsTable;
import org.apache.poi.xssf.model.StylesTable;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.ErrorHandler;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;

public class ExcelSheetParser {
	protected Log log = LogFactory.getLog(this.getClass());

    enum xssfDataType {
        BOOL, ERROR, FORMULA, INLINESTR, SSTINDEX, NUMBER,
    }
    
	private OPCPackage              opcPackage;
	private SharedStringsTable      sst;
//	private HashMap<String, String>	mapHeader;
//    private HashMap<String, String>	mapParam;
    private int 					numberOfColumns;
    private JSONArray 				listData = new JSONArray();
    private Sender 				    sender;
    private StylesTable stylesTable;
    private ReadOnlySharedStringsTable sharedStringsTable;
    
	public ExcelSheetParser(File file, int numberOfColumns, Sender sender) {
        try {
        	this.opcPackage      = OPCPackage.open(file);
			//this.mapHeader       = mapHeader;
//			this.mapParam        = mapParam;
			this.sender          = sender;
			this.numberOfColumns = numberOfColumns;// - Integer.parseInt(mapParam.get("addColumns"));;
		} catch (InvalidFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	
	public void excute() throws IOException, OpenXML4JException, ParserConfigurationException, SAXException {
		
        XSSFReader xssfReader = new XSSFReader(opcPackage);
		this.stylesTable 	= xssfReader.getStylesTable();
        
        sst = xssfReader.getSharedStringsTable();
        XMLReader parser = XMLReaderFactory.createXMLReader("org.apache.xerces.parsers.SAXParser");
        ContentHandler handler = new SheetHandler();
        parser.setContentHandler(handler);
        parser.setErrorHandler((ErrorHandler) handler);

        int sheetNo = 0;
        
        Iterator<InputStream> sheets = xssfReader.getSheetsData();
        
        while(sheets.hasNext()) {

        	if ( sheetNo > 0 ) break;
            
            InputStream sheetStream = sheets.next();
            InputSource sheetSource = new InputSource(sheetStream);
            
            parser.parse(sheetSource);

            sheetStream.close();
            
            sheetNo++;
        }
  
        opcPackage.close();
    }

	public class SheetHandler extends DefaultHandler {
	    private String	   		lastContents;
	    private String 	   		key                 	= null;
	    private String 	   		startElementName       	= "v";
	    private boolean    		isFirstRow          	= true;
	    private int 	   		previousColumnNumber 	= numberOfColumns;
	    private int 	   		currentColumnNumber 	= 0;
	    private int 	   		currentRowNumber    	= 1;
	    private int 	   		rowNumberOfLastCell 	= 1;
	    private int        		realColumnNumber    	= 0;
	    
	    private xssfDataType	nextDataType    		= xssfDataType.NUMBER;
        private short 			formatIndex;
        private String 			formatString;
        private final DataFormatter formatter = new DataFormatter();
	    private JSONObject data                = new JSONObject();

	    /*
	     * file > sheet > row > cell > value > 순으로 시작 : startElement
	     * value > cell > row > sheet > file 순으로 종료 : endElement
	     */
	    
	    public void startElement(String uri, String localName, String name, Attributes attributes) throws SAXException {

	        startElementName = name; // 중간에 빠진 Cell 비교를 위해 항상 저장
	        if ( name.equals("c") ) {

	        	currentColumnNumber++;
	        	String r = attributes.getValue("r");
	        	nextDataType = xssfDataType.NUMBER;
                formatIndex = -1;
                formatString = null;
                String cellType = attributes.getValue("t");
                String cellStyleStr = attributes.getValue("s");

                if ("b".equals(cellType)) nextDataType = xssfDataType.BOOL;
                else if ("e".equals(cellType)) nextDataType = xssfDataType.ERROR;
                else if ("inlineStr".equals(cellType)) nextDataType = xssfDataType.INLINESTR;
                else if ("s".equals(cellType)) nextDataType = xssfDataType.SSTINDEX;
                else if ("str".equals(cellType)) nextDataType = xssfDataType.FORMULA;
                else if (cellStyleStr != null) {
                    int styleIndex = Integer.parseInt(cellStyleStr);
    		        XSSFCellStyle style = null;
    		        try {
    		        	style = stylesTable.getStyleAt(styleIndex);
    		        }
    		        catch (Exception e) {
    		        	e.printStackTrace();
    		        }
    		        if (style != null) {
	                    formatIndex = style.getDataFormat();
	                    formatString = style.getDataFormatString();
	                    if (formatString == null)
	                        formatString = BuiltinFormats.getBuiltinFormat(formatIndex);
    		        }
                }
	        }
	        if (name.equals("v")) { // Cell 정보 읽기 시작
	        	lastContents = "";
	        }
	    }
	            
	    public void endElement(String uri, String localName, String name) throws SAXException {

	        if (name.equals("row")) { // Row Data 꺼내기 종료
	        	//마지막 비어 있는 Cell 채우기
	        	if (isFirstRow) {
	        		isFirstRow = false; 
		        	currentColumnNumber = 0;	        	
	        		return;
	        	}
	        	
	        	//if (mapHeader.size() > currentColumnNumber) { //controller에 setExcelHeader의 사이즈 > 값이 null이 아닌  엑셀의 사이즈 면 마지막 행의 컬럼과 빈값 추가
	        	if (numberOfColumns > currentColumnNumber) { //controller에 setExcelHeader의 사이즈 > 값이 null이 아닌  엑셀의 사이즈 면 마지막 행의 컬럼과 빈값 추가
//	    	        for (int i = currentColumnNumber; i < mapHeader.size(); i++) {
	    	        for (int i = currentColumnNumber; i < numberOfColumns; i++) {
			        	//key = (String)mapHeader.get(Integer.toString(i+1));
			        	//data.put(key, "");
			        	data.put(currentColumnNumber, "");
	        		}
	        	}
        		isFirstRow = false; 
	        	currentColumnNumber = 0;	        	

	        	if (isFirstRow) return;
	        	
            	listData.add(data); 
            	data.clear();
	        	return;
	        }
	        if (name.equals("c")) { // Cell 정보 읽기 종료
	        	// 데이터가 비어 있는 중간 Cell이 있는 경우 넣어주기, 중간에 비어 있는 Cell은 name-value/file 안 옴
	        	if (startElementName.equals("c")) {
	    	       // log.debug("endElement == c : startElementName == c >>" + key);
		        	//key = (String)mapHeader.get(Integer.toString(currentColumnNumber));
		        	//data.put(key, "");
		        	data.put(currentColumnNumber, "");
	        	}
	        	//currentColumnNumber++;
	        	lastContents = "";
	        	return;
	        }
	        String thisStr = null;
	        if (name.equals("v")) { // value 정보 읽기 종료        	
	        	
                switch (nextDataType) { //excel 데이터 형식 검사/ 변경
                case BOOL:
                    char first = lastContents.charAt(0);
                    thisStr = first == '0' ? "FALSE" : "TRUE";
                    break;

                case ERROR:
                    thisStr = "\"ERROR:" + lastContents.toString()  + '"';
                    break;

                case FORMULA:
                    // A formula could result in a string value,
                    // so always add double-quote characters.
                    thisStr =  lastContents.toString() ;
                    //thisStr = '"' + lastContents.toString() + '"';
                    break;

                case INLINESTR:
                    // TODO: have seen an example of this, so it's untested.
                    XSSFRichTextString rtsi = new XSSFRichTextString(lastContents.toString());
                    thisStr =  rtsi.toString() ;
                    //thisStr =  '"' + rtsi.toString() + '"';
                    break;

                case SSTINDEX:
                	int idx = Integer.parseInt(lastContents);
                	thisStr = new XSSFRichTextString(sst.getEntryAt(idx)).toString();
                    break;

                case NUMBER:
                    String n = lastContents.toString();
                    if (formatString != null)
                        thisStr = formatter.formatRawCellContents(Double.parseDouble(n), formatIndex, formatString);
                    else
                        thisStr = n;
                    break;

                default:
                    thisStr = "(TODO: Unexpected type: " + nextDataType + ")";
                    break;
                }
                
	        	// key = (String)mapHeader.get(Integer.toString(currentColumnNumber));
	        	data.put(currentColumnNumber, thisStr);
	        	return;
	        }
	    }
	        	
	    public void makeDummyData(int intervals) {
	    	for ( int i = 0; i < intervals; i++ ) {	        				
        		//key = (String)mapHeader.get(Integer.toString(currentColumnNumber));
        		//data.put(key, "");
	        	data.put(currentColumnNumber, "");
        		previousColumnNumber = currentColumnNumber;
        		currentColumnNumber++;
    		}
	    }
	    
/*	    public void makeAditionalData() {
	    	int columnNumber;
	    	int rowNumber;
	    	
	    	if (currentColumnNumber == (numberOfColumns)) {
	    		columnNumber = currentColumnNumber;
	    		rowNumber = currentRowNumber;
	    	} else {
		    	columnNumber = currentColumnNumber - 1;
		    	rowNumber = currentRowNumber - 1;
	    	}
	    		
	    	key = (String)mapHeader.get(Integer.toString(columnNumber + 1));
        	data.put(key, mapParam.get(key));
        	
        	key = (String)mapHeader.get(Integer.toString(columnNumber + 2));
        	data.put(key, data.get("prescriptYm") + String.format("%06d", rowNumber) );
        	
        	log.debug("data = " + data.toString());
	    }
*/	    
	    public int extractRowNumber(String original) {
	        char[] chars = original.toCharArray();
	        for ( int i = 0; i < chars.length; i++ ) {
	            try {
	                return Integer.valueOf(original.substring(i, original.length())) - 1;
	            } catch (NumberFormatException ex) {
	            }
	        }
	        return 0;
	    }
	    
	    private int extractColumnNumber(String name) {
	        int column = -1;
	        int firstDigit = -1;
	        for (int c = 0; c < name.length(); ++c) {
	            if (Character.isDigit(name.charAt(c))) {
	                firstDigit = c;
	                break;
	            }
	        }
	           
	        String r = name.substring(0, firstDigit);
	        
	        for (int i = 0; i < r.length(); ++i) {
	            int c = r.charAt(i);
	            column = (column + 1) * 26 + c - 'A';
	        }
	        return column + 1;
	    }
	        
	    public void characters(char[] ch, int start, int length) throws SAXException {
	        lastContents += new String(ch, start, length);
	    }
	    
	    public void startDocument () {
	    	//log.debug("Start document");
	    }
	
	    public void endDocument () {
	    	//log.debug("End document");
	        if ( sender != null )
	        	sender.onTerminated(listData);
	    }
	}
	
	public interface Sender {
		void onTerminated(JSONArray listData);
	}
}