package com.org.iopts.cbh.scbh000001;

import java.io.IOException;

import org.apache.http.ParseException;
import org.jdom2.Document;
import org.jdom2.Element;

import com.google.gson.Gson;
import com.org.iopts.cbh.scbh000001.vo.GetSmsInfoVo;
import com.org.iopts.csp.comm.Config;
import com.org.iopts.csp.comm.CspUtil;
import com.org.iopts.csp.comm.vo.HeaderVo;
import com.org.iopts.csp.comm.vo.ResultVo;

// 잔여기본통화조회
public class SCBH000001 {
	// Service URL
	private	String	URL	= Config.domain + "/rest/SCBH000001/" + Config.apiKey;

	// input Parameter
	// CONSUMER_ID		서비스ID
	// RPLY_PHON_NUM	발신전화번호
	// TITLE			제목
	// PHONE			수신전화
	// URL				URL
	// START_DT_HMS		시작일시
	// END_DT_HMS		종료일시
	public static String title;
	public static String phone;
	private static String[][] paramLt	= {{"CONSUMER_ID","C00561"},{"RPLY_PHON_NUM","0264008842"},{"TITLE", title},{"PHONE",phone}};

	// XML 내부에서 Body 정보를 담아옴 - 서비스별 상의함
	private Object getBody(HeaderVo hvo, Element body) {
		GetSmsInfoVo vo = new GetSmsInfoVo();

		if(body==null) return vo;

		String[] contLt	= {"RETURN", "UUID"};

		for(int i=0; i<contLt.length; i++) {
			CspUtil.setData(vo, hvo, body, contLt[i]);
		}
		return vo;
	}

	public ResultVo getVoData(String URL, String[][] paramLt, String METHOD, int timeout) {
		ResultVo	vo = new ResultVo();

		Document doc = CspUtil.getDocument(URL, paramLt, METHOD, timeout);

		Element root	= doc.getRootElement();
		Element head	= root.getChild("HEADER");
		Element body	= root.getChild("BODY");

		if(head!=null) {
			vo.setHEADER(CspUtil.getHeader(head));
		}

		if(body!=null) {
			vo.setBODY(getBody(vo.getHEADER(), body));
		}

		return vo;
	}

	// XML 문자열 데이터
//	@Test
	public void getXmlData() {
		try {
			int timeout = 5000;
			System.out.println(CspUtil.GET(URL, paramLt, timeout).getRtnText());
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Value Object형 데이터
//	@Test
	public void getVo() {
		int timeout = 5000;
		System.out.println(getVoData(URL, paramLt, "POST", timeout));
	}

	// JSON형 데이터
//	@Test
	public void getJSONData() {
		Gson gson = new Gson();
		int timeout = 5000;
		System.out.println( gson.toJson(getVoData(URL, paramLt, "POST", timeout)).toString() );
	}
}