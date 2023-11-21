package com.org.iopts.util;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.GZIPInputStream;
import java.util.Base64.Encoder;

import javax.net.ssl.HttpsURLConnection;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import net.sf.json.JSONObject;

public class ReconUtil 
{
	private static final Logger logger = LoggerFactory.getLogger(ReconUtil.class);
	
	public Map<String, Object> getServerDataLee(String recon_id, String recon_password, String sURL, String requestMethod, String requestData) throws ProtocolException {
		
		logger.info(recon_id);
		logger.info(recon_password);
		logger.info(sURL);
		logger.info(requestMethod);
		logger.info(requestData);
		
		

        Map<String, Object> resultMap = new HashMap<String,Object>();
		String usercredentials = recon_id+":"+recon_password;        
		
		
		String[] array=new String[6];
		
		array[0]="-k";
		array[1]="-X";
		array[2]="GET";
		array[3]="-u";
		array[4]=usercredentials;
		array[5]=sURL;
		
		String json_string =new ICurl().opt(array).exec(null);
		
		System.out.println(json_string);


		resultMap.put("HttpsResponseCode", 200);
		resultMap.put("HttpsResponseMessage", "OK");
		resultMap.put("HttpsResponseData", json_string);
		
		
        return resultMap; 
    }
	
	
	public Map<String, Object> getServerData(String recon_id, String recon_password, String sURL, String requestMethod, String requestData) throws ProtocolException {
		
		logger.info(recon_id);
		logger.info(recon_password);
		logger.info(sURL);
		logger.info(requestMethod);
		logger.info(requestData);
		
		//for localhost testing only
		javax.net.ssl.HttpsURLConnection.setDefaultHostnameVerifier(
	    new javax.net.ssl.HostnameVerifier() {
	        public boolean verify(String hostname, javax.net.ssl.SSLSession sslSession) {
	        	return true;
	        }
	    });

        Map<String, Object> resultMap = new HashMap<String,Object>();
		String usercredentials = recon_id+":"+recon_password;        
		// Base64 인코딩 ///////////////////////////////////////////////////
		Encoder encoder = Base64.getEncoder();        
		String basicAuth = encoder.encodeToString(usercredentials.getBytes());

		URL url = null;
		HttpsURLConnection httpsCon = null;
		try {
			url = new URL(sURL);
			httpsCon = (HttpsURLConnection) url.openConnection();					
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		if (requestMethod.equals("GET")) {
			httpsCon.setRequestProperty("Content-Type", "application/x-www-form-urlencoded"); 
			httpsCon.setRequestProperty("User-Agent", "Mozilla/5.0");
			httpsCon.setRequestProperty("Accept", "application/json");
			httpsCon.setRequestProperty("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
			httpsCon.setRequestProperty("Accept-Encoding", "gzip, deflate, br"); 
			httpsCon.setRequestProperty("Authorization", "Basic " + basicAuth);
		}
		else {
			httpsCon.setRequestProperty("Content-Type", "application/json; charset=utf8");
			httpsCon.setRequestProperty("Accept", "application/json");
			httpsCon.setRequestProperty("User-Agent", "Mozilla/5.0");
			httpsCon.setRequestProperty("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
			httpsCon.setRequestProperty("Authorization", "Basic " + basicAuth);
			httpsCon.setConnectTimeout(5000);
			httpsCon.setReadTimeout(15000);
		}

		httpsCon.setUseCaches(false);
		httpsCon.setDoInput(true);
		httpsCon.setDoOutput(true);
		httpsCon.setRequestMethod(requestMethod);

		//if (requestData != null)
		if (requestMethod.equals("POST") || requestMethod.equals("PUT"))
		{
			BufferedReader reader = null;
			StringBuilder results = new StringBuilder();
	        String line;
	        
			try {
				if (requestData != null) {
					OutputStreamWriter wr = new OutputStreamWriter(httpsCon.getOutputStream());
					wr.write(requestData);
					wr.flush();
					
					
					reader = new BufferedReader(new InputStreamReader(httpsCon.getInputStream()));
					while ((line = reader.readLine()) != null) {
					    results.append(line);
					}
					
					logger.info("result :: " + results);
					
					resultMap.put("HttpsResponseDataMessage", results);
				}
				/* 
					HttpResult == 201, 정상적으로 들어갈 경우,
					HttpResult == 400, JSON 컬럼이 틀릴 경우
					HttpResult == 409, 스케줄 레이블이 중복일 경우
					HttpResult == 422, JSON 내용이 틀리 거나, start 시간이 과거 시간일 경우
				*/
				resultMap.put("HttpsResponseCode", httpsCon.getResponseCode());
				resultMap.put("HttpsResponseMessage", httpsCon.getResponseMessage());
				
				logger.info("resultMap :: " + resultMap.toString());
		        httpsCon.disconnect();
		        return resultMap;
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (requestMethod.equals("DELETE"))
		{
			BufferedReader reader = null;
			StringBuilder results = new StringBuilder();
	        String line;
	        
			try {
				
				logger.info(httpsCon.getResponseCode() + " Code");
	        	logger.info(httpsCon.getResponseMessage().toString());
	        	
	        	resultMap.put("HttpsResponseCode", httpsCon.getResponseCode());
				resultMap.put("HttpsResponseMessage", httpsCon.getResponseMessage());

				logger.info("resultMap :: " + resultMap.toString());
		        httpsCon.disconnect();
		        return resultMap;
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		BufferedReader reader = null;
		StringBuilder results = new StringBuilder();
        String line;
        
        try {
        	logger.info(httpsCon.getResponseCode() + " Code");
        	logger.info(httpsCon.getResponseMessage().toString());
        	
        	if(httpsCon.getResponseCode() == 401) {
        		resultMap.put("HttpsResponseCode", httpsCon.getResponseCode());
        		resultMap.put("HttpsResponseMessage", "개인정보 검출관리(PIMC) 서버 연결에 문제가 있습니다. 관리자에게 연락 주시기 바랍니다.");
        		
        		return resultMap;
        	}else if(httpsCon.getResponseCode() == 404) {
        		resultMap.put("HttpsResponseCode", httpsCon.getResponseCode());
        		resultMap.put("HttpsResponseMessage", "개인정보 검출관리(PIMC) 서버에 결과가 더이상 존재하지 않습니다. 검출 대상서버에 파일이 삭제/암호화 된 이후 검색이 수행 된 경우 이런 증상이 발생할 수 있습니다. 추가 문의사항은 관리자에게 연락 주시기 바랍니다.");
        		/*resultMap.put("HttpsResponseMessage", "검출 서버에 결과가 더 이상 존재하지 않습니다. 파일이 삭제/암호화 된 이후 검색이 수행 된 경우 이런 증상이 발생할 수 있습니다.");*/
        		
        		return resultMap;
        	}
        }catch (Exception e) {
			// TODO: handle exception
		}
        
        try {
        	if (httpsCon.getContentEncoding().equals("gzip")) {
        		logger.info("=================================================");
        		try {
        			InputStream httpStream = httpsCon.getInputStream();
        			InputStream gzipInputStream = new GZIPInputStream(httpStream);
        			int len;
        			byte buffer[] = new byte[1024];
        			
        			try {
        				while ((len = gzipInputStream.read(buffer)) != -1) {
        					results.append(new String(buffer, 0, len, "UTF-8"));
        				}
        			} catch (IOException e) {
        				// TODO Auto-generated catch block
        				//e.printStackTrace();
        			}
        			
        		} catch (Exception e) {
        			// TODO Auto-generated catch block
//					e.printStackTrace();
        			resultMap.put("HttpsResponseCode", 404);
        			resultMap.put("HttpsResponseMessage", "Resource not found.");
        			return resultMap;
        		}
        	}
        	else {
        		try {
        			reader = new BufferedReader(new InputStreamReader(httpsCon.getInputStream()));
        			while ((line = reader.readLine()) != null) {
        				results.append(line);
        			}
        		} catch (Exception e) {
        			// TODO Auto-generated catch block
//					e.printStackTrace();
        			resultMap.put("HttpsResponseCode", 404);
        			resultMap.put("HttpsResponseMessage", "Resource not found.");
        			return resultMap; 
        		}
        	}
        } catch (Exception e1) {
			resultMap.put("HttpsResponseCode", 404);
			/*resultMap.put("HttpsResponseMessage", "Resource not found.");*/
			resultMap.put("HttpsResponseMessage", "개인정보 검출관리(PIMC) 서버 연결에 문제가 있습니다. 관리자에게 연락 주시기 바랍니다.");
			
	        return resultMap;
		}
		
		logger.info("---------------------------------------------");
       // logger.info(results.toString());
        
		// Close Connection
        httpsCon.disconnect();
		
//		/* 조회 contents 가져오기 */
//        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
//        DocumentBuilder builder = null;
//        InputSource is;
//        Document doc = null;
//        try {
//			builder = factory.newDocumentBuilder();
//		} catch (ParserConfigurationException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//			resultMap.put("HttpsResponseCode", -1);
//			resultMap.put("HttpsResponseMessage", "ParserConfigurationException");
//			resultMap.put("HttpsResponseData", null);
//	        return resultMap; 
//		}
//        logger.info(results.toString());
//        
//        is = new InputSource(new StringReader(results.toString()));
//        try {
//			doc = builder.parse(is);
//		} catch (SAXException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//			resultMap.put("HttpsResponseCode", -1);
//			resultMap.put("HttpsResponseMessage", "SAXException");
//			resultMap.put("HttpsResponseData", null);
//	        return resultMap; 
//		} catch (IOException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//			resultMap.put("HttpsResponseCode", -1);
//			resultMap.put("HttpsResponseMessage", "IOException");
//			resultMap.put("HttpsResponseData", null);
//	        return resultMap; 
//		}
//        
//        /* 조회 contents 가져오기  끝 */

		resultMap.put("HttpsResponseCode", 200);
		resultMap.put("HttpsResponseMessage", "OK");
		resultMap.put("HttpsResponseData", results.toString());
        return resultMap; 
    }

}
