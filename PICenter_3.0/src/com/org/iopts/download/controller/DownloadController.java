package com.org.iopts.download.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.org.iopts.download.service.DownloadService;
import com.org.iopts.service.Pi_TargetService;

@Controller
@RequestMapping(value = "/download")
@Configuration
@PropertySource("classpath:/property/config.properties")
@PropertySource("classpath:/property/filepath.properties")
public class DownloadController {

	private static Logger logger = LoggerFactory.getLogger(DownloadController.class);

	@Value("${recon.api.version}")
	private String api_ver;

	@Value("${notice.file.path}")
	private String file_path;
	
	@Value("${download.file.path}")
	private String download_path;
	
	@Value("${download.netFile.path}")
	private String Excel_path;
	
	@Inject
	private DownloadService service;

	@RequestMapping(value = "/upload", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Map<String, Object> upload(@RequestParam("uploadFile") MultipartFile file, HttpServletRequest request)
			throws IllegalStateException, IOException {
		
		Map<String, Object> map = new HashMap<String, Object>();
		String fileName = file.getOriginalFilename();
		
		if (!file.getOriginalFilename().isEmpty()) {
			try {
				String ext = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
				int index = service.selectDownloadIndex(map, request);
				String real_file_name = ((index +1)+"."+ext);
				file.transferTo(new File(file_path, real_file_name));
				
				map.put("file_name", fileName);
				map.put("real_file_name", real_file_name);
				
				int result = service.insertDownload(map, request);
				
				map.put("resultCode", 0);
				map.put("resultMassage", "파일 업로드 성공");
				map.put("fileName", fileName);
				map.put("fileNumber", result);
				
				
			} catch (Exception e) {
				map.put("resultCode", -1);
				map.put("resultMassage", "파일 업로드 실패");
			}
			
		} 

		return map;
	}

	/*
	 * 
	 */
	@RequestMapping(value = "/file", method = { RequestMethod.POST })
	public @ResponseBody byte[] file(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response, @RequestParam String filename, @RequestParam String realfilename) throws Exception {
		String header = request.getHeader("User-Agent");
		boolean ie = (header.indexOf("MSIE") > -1) || (header.indexOf("Trident") > -1);
		String fileName = "";
		/*if (ie) {
			realfilename = URLEncoder.encode(realfilename, "UTF-8").replaceAll("\\+", "%20");
		}*/
		
		logger.info("filename >> " + filename +  ", realFilename >> " + realfilename);
		logger.info("path >> " + file_path +  ", realFilename >> " + realfilename);

		File file = new File(file_path, realfilename);

		byte[] bytes = FileCopyUtils.copyToByteArray(file);

		String fn = new String(filename.getBytes(), "utf-8");
		String name = "";
		if (header.contains("Edge")){
		    name = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		    response.setHeader("Content-Disposition", "attachment;filename=\"" + name + "\"");
		} else if (header.contains("MSIE") || header.contains("Trident")) { // IE 11버전부터 Trident로 변경되었기때문에 추가해준다.
		    name = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		    response.setHeader("Content-Disposition", "attachment;filename=\"" + name + "\"");
		} else if (header.contains("Chrome")) {
		    name = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
		} else if (header.contains("Opera")) {
		    name = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
		} else if (header.contains("Firefox")) {
		    name = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
		}

		
		//response.setHeader("Content-Disposition", "attachment;filename=\"" + fn + "\"");
		response.setContentLength(bytes.length);

		return bytes;
	}
	

	
	@RequestMapping(value = "/downloadUpload", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Map<String, Object> downloadUpload(@RequestParam("uploadFile") MultipartFile file, HttpServletRequest request)
			throws IllegalStateException, IOException {
		
		Map<String, Object> map = new HashMap<String, Object>();
		String fileName = file.getOriginalFilename();
		
		if (!file.getOriginalFilename().isEmpty()) {
			try {
				String ext = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
				int index = service.selectFileDownloadIndex(map, request);
				String real_file_name = ((index +1)+"."+ext);
				file.transferTo(new File(download_path, real_file_name));
				
				map.put("file_name", fileName);
				map.put("real_file_name", real_file_name);
				
				int result = service.insertFileDownload(map, request);
				
				map.put("resultCode", 0);
				map.put("resultMassage", "파일 업로드 성공");
				map.put("fileName", fileName);
				map.put("fileNumber", result);
				
				
			} catch (Exception e) {
				map.put("resultCode", -1);
				map.put("resultMassage", "파일 업로드 실패");
			}
			
		} 
		
		return map;
	}
	

	@RequestMapping(value = "/downloadfile", method = { RequestMethod.POST })
	public @ResponseBody byte[] downloadfile(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response, @RequestParam String filename, @RequestParam String realfilename) throws Exception {
		String header = request.getHeader("User-Agent");
		boolean ie = (header.indexOf("MSIE") > -1) || (header.indexOf("Trident") > -1);
		String fileName = "";
		/*if (ie) {
			realfilename = URLEncoder.encode(realfilename, "UTF-8").replaceAll("\\+", "%20");
		}*/
		
		logger.info("filename >> " + filename +  ", realFilename >> " + realfilename);
		logger.info("path >> " + download_path +  ", realFilename >> " + realfilename);

		File file = new File(download_path, realfilename);

		byte[] bytes = FileCopyUtils.copyToByteArray(file);

		String fn = new String(filename.getBytes(), "utf-8");
		String name = "";
		if (header.contains("Edge")){
		    name = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		    response.setHeader("Content-Disposition", "attachment;filename=\"" + name + "\"");
		} else if (header.contains("MSIE") || header.contains("Trident")) { // IE 11버전부터 Trident로 변경되었기때문에 추가해준다.
		    name = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		    response.setHeader("Content-Disposition", "attachment;filename=\"" + name + "\"");
		} else if (header.contains("Chrome")) {
		    name = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
		} else if (header.contains("Opera")) {
		    name = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
		} else if (header.contains("Firefox")) {
		    name = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
		}

		
		//response.setHeader("Content-Disposition", "attachment;filename=\"" + fn + "\"");
		response.setContentLength(bytes.length);

		return bytes;
	}
	
	@RequestMapping(value = "/downloadExcel", method = { RequestMethod.POST })
	public @ResponseBody byte[] downloadExcel(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response, @RequestParam String filename, @RequestParam String realfilename) throws Exception {
		String header = request.getHeader("User-Agent");
		boolean ie = (header.indexOf("MSIE") > -1) || (header.indexOf("Trident") > -1);
		String fileName = "";
		
		File file = new File(Excel_path, realfilename);
		
		byte[] bytes = FileCopyUtils.copyToByteArray(file);
		
		String fn = new String(filename.getBytes(), "utf-8");
		String name = "";
		if (header.contains("Edge")){
			name = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
			response.setHeader("Content-Disposition", "attachment;filename=\"" + name + "\"");
		} else if (header.contains("MSIE") || header.contains("Trident")) { // IE 11버전부터 Trident로 변경되었기때문에 추가해준다.
			name = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
			response.setHeader("Content-Disposition", "attachment;filename=\"" + name + "\"");
		} else if (header.contains("Chrome")) {
			name = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
		} else if (header.contains("Opera")) {
			name = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
		} else if (header.contains("Firefox")) {
			name = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
		}
		
		response.setContentLength(bytes.length);
		
		return bytes;
	}

}