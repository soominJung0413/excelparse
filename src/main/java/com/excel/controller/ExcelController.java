package com.excel.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.excel.service.ExcelService;
import com.excel.vo.Fruit;

@Controller
public class ExcelController {
	
	@Autowired
	private ExcelService excelService;
	
	@RequestMapping(value = "/downloadExcelFile", method = RequestMethod.POST)
    public String downloadExcelFile(Model model) {
        //엑셀 객체
//        SXSSFWorkbook workbook = excelService.excelFileDownloadProcess(new ArrayList<>());
//        
//        System.out.println(workbook);
        
        model.addAttribute("locale", Locale.KOREA);
//        model.addAttribute("workbook", workbook);//엑셀파일 저장
        model.addAttribute("workbookName", "과일표");//엑셀제목 저장
        
        return "excelDownloadView";
    }
	
	@RequestMapping(value = "/uploadExcelFile", method = RequestMethod.POST)
	public String uploadExcelFile(MultipartHttpServletRequest request, Model model) {
		System.out.println("동작");
		MultipartFile file = null;
		Iterator<String> iterator = request.getFileNames();
		if(iterator.hasNext()) {
			file = request.getFile(iterator.next());
		}
		//파일 이름을 가지고 업로드 진행
//		excelService.uploadExcelFile(file);
		
//		List<SalaryType> list = salaryMapper.selectExcelList();
		
//		model.addAttribute("list", list);
		return "home";
	}

}
