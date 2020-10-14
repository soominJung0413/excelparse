package com.excel.util;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.web.servlet.view.AbstractView;

// 커스텀 뷰 객체를 만들떄 사용
public class ExcelDownloadView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Locale locale = (Locale)model.get("locale");
		String workbookName = (String)model.get("workbookName");
		
		Date date = new Date();
		SimpleDateFormat dayFormat = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat hourFormat = new SimpleDateFormat("hhmmss");
		
		String day = dayFormat.format(date);
		String hour = hourFormat.format(date);
		String fileName = workbookName + "_" + day + "_" + hour + ".xlsx";
		
		// 브라우저에 따른 파일 이름 인코딩
		
		String browser = request.getHeader("User-Agent");
		if(browser.indexOf("MSIE") > -1) {// 익스플로러 라면
			fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\", "%20");
		} else if (browser.indexOf("Trident") > -1) {// 엣지라면
			fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\", "%20");
		} else if (browser.indexOf("Firefox") > -1) {// 파이어 폭스라면
			fileName = "\""+ new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.indexOf("Opera") > -1) {// 파이어 폭스라면
			fileName = "\""+ new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.indexOf("Chrome") > -1) {// 크롬브라우저라면
			//스트링 버퍼는 스레드 세이프
			StringBuffer sb = new StringBuffer();
			for(int i=0; i< fileName.length(); i++) {
				char c = fileName.charAt(i);
				if(c > '~') {
					sb.append(URLEncoder.encode(""+c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			fileName = sb.toString();
		} else if (browser.indexOf("Safari") > -1) {
			fileName = "\""+new String(fileName.getBytes("UTF-8"),"8859_1")+"\"";
		} else {
			fileName = "\""+new String(fileName.getBytes("UTF-8"),"8859_1")+"\"";
		}
		
		//응답정보 수정작업
		response.setContentType("application/download;charset=utf-8");
		response.setHeader("Content-Disposition", "attachment; fileName=\""+fileName+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream os = null;
		SXSSFWorkbook workbook = null;
		try {
		workbook = (SXSSFWorkbook)model.get("workbook");
		os = response.getOutputStream();
		
		// 응답의 OutputStream 으로 SXSSWorkbook 을 출력
		workbook.write(os);
		}catch(Exception e) {
			e.getStackTrace();
		} finally {// 자원반납
			if(workbook != null) {
				try {
				workbook.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			if(os != null) {
				try {
					os.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

}
