package com.org.iopts.util;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.org.iopts.dto.EmailVO;


public class NhEmailUtil {

	private static Logger log = LoggerFactory.getLogger(NhEmailUtil.class);
		
	private String nhemailpath;
	
	private String tgt ="";
	private String tgt_zip ="";
	private EmailVO vo=null;
	private String nh_init="nhem";
	private int seq=0;
	
	public NhEmailUtil() {
		
	}
	
	public NhEmailUtil(String path,EmailVO e) {
		nhemailpath=path;
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> email basepath :"+nhemailpath);
		
		
		this.vo=e;
		this.seq=getFileNo();
		tgt=    String.format("%s_%s_BSII_%06d.txt",nh_init,getCDate(),this.seq);
		tgt_zip=String.format("%s_%s_BSII_%06d.zip",nh_init,getCDate(),this.seq);
		
		//Title의 제목을 다시 붙인다
		this.vo.setTitle_arg(this.vo.getTitle_arg() + tgt);
		
	}
	
	public boolean sendEmail() {
		if(nhemailpath == null || nhemailpath.length() < 3) {
			log.error("Send Email Error :"+nhemailpath + " is null or empty");
			return false;
			
		}else {
			//Text를 먼저 만들고 Zip 파일을 만든다.
			this.tgt=jsonfile();
			doZip();
			
			File deletefile = new File(tgt);
			if (deletefile.exists()) {
				if (deletefile.delete()) {
					log.info("임시 메일 파일삭제 성공");
				} else {
					log.info("임시 메일 파일삭제 실패");
				}
			}
			return true;
		}
	}
	

	private String jsonfile() {
		String fname = nhemailpath+"/"+tgt;
		ObjectMapper mapper = new ObjectMapper();
		try {
			mapper.writeValue(new File(fname),this.vo);
			String jsonInString = mapper.writeValueAsString(this.vo);
		} catch (JsonGenerationException e) {
			log.error(e.getLocalizedMessage());
		} catch (JsonMappingException e) {
			log.error(e.getLocalizedMessage());
		} catch (IOException e) {
			log.error(e.getLocalizedMessage());
		}
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> jsonfile :"+fname);
		return fname;
	}
	
	private void doZip() {
		try {
			FileOutputStream fos = new FileOutputStream(nhemailpath+"/"+tgt_zip);
			ZipOutputStream zipOut = new ZipOutputStream(fos);

			File fileToZip = new File(tgt);
			FileInputStream fis = new FileInputStream(fileToZip);
			ZipEntry zipEntry = new ZipEntry(fileToZip.getName());
			zipOut.putNextEntry(zipEntry);

			byte[] bytes = new byte[1024];
			int length;
			while ((length = fis.read(bytes)) >= 0) {
				zipOut.write(bytes, 0, length);
			}

			fis.close();
			zipOut.close();
			fos.close();

		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			log.error("ZipFile FileNotFoundException Error :"+e.getLocalizedMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.error("ZipFile IOException Error :"+e.getLocalizedMessage());
		}
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> doZip :"+nhemailpath+"/"+tgt_zip);
	}
	
	
	private int getFileNo() {
		int ret=1;
		
	    File dir = new File(nhemailpath);
	    ret=dir.list().length+1;
	    
		return ret;
	}
	
	private String getCDate() {
		SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
		Date time = new Date();
		String time1 = format1.format(time);

		return time1;
	}
	
}
