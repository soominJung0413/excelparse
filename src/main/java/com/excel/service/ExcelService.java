package com.excel.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.excel.vo.Fruit;

@Service
public class ExcelService {
	public ArrayList<Fruit> makeFruitList(String[] names, long[] prices, int[] quantities){
        ArrayList<Fruit> list = new ArrayList<Fruit>();
        for(int i=0; i< names.length; i++) {
            Fruit fruit = new Fruit(names[i], prices[i], quantities[i]);
            list.add(fruit);
        }
        return list;
    }
	
	/**
	 * 여기가 중요함, 엑셀 객체 생성 SXSSFWorkbook
	 * @param list 엑셀에 맵핑할 VO
	 * @return SXSSFWorkbook 엑셀 객체
	 */
	public SXSSFWorkbook makeSimpleExcelWorkBook(List<Fruit> list) {
		//엑셀 객체 생성
		SXSSFWorkbook workbook  =new SXSSFWorkbook();
		
		// 시트 생성
		SXSSFSheet sheet = workbook.createSheet("과일표");
		
		// 시트 열 너비
		sheet.setColumnWidth(0, 1500);
		sheet.setColumnWidth(0, 3000);
		sheet.setColumnWidth(0, 3000);
		sheet.setColumnWidth(0, 1500);
		
		// 첫번째 행 생성
		Row headerRow = sheet.createRow(0);
		//첫번째 열의 첫 셀 생성
		Cell headCell = headerRow.createCell(0);
		headCell.setCellValue("번호");
		//첫번째 열의 두번쨰 셀 생성
		headCell = headerRow.createCell(1);
		headCell.setCellValue("과일이름");
		//첫번째 열의 세번째 셀 생성
		headCell = headerRow.createCell(2);
		headCell.setCellValue("가격");
		//첫번째 열의 네번째 셀 생성
		headCell = headerRow.createCell(3);
		headCell.setCellValue("수량");
		
		// 과일 표의 내용 및 셀 생성
		Row bodyRow = null;
		Cell bodyCell = null;
		for (int i=0; i<list.size(); i++) {
			Fruit fruit = list.get(i);
			
			//행 생성
			bodyRow = sheet.createRow(i+1); //1부터 시작하므로
			//데이터 번호 표시
			bodyCell = bodyRow.createCell(0);
			bodyCell.setCellValue(i+1);
			//데이터 이름 표시
			bodyCell = bodyRow.createCell(1);
			bodyCell.setCellValue(fruit.getName());
			//데이터 가격 표시
			bodyCell = bodyRow.createCell(2);
			bodyCell.setCellValue(fruit.getPrice());
			//데이터 수량 표시
			bodyCell = bodyRow.createCell(3);
			bodyCell.setCellValue(fruit.getQuantity());
		}
		return workbook;
	}
	
	/**
	 * 업로드한 엑셀 파일을 클래스 리스트로 만든다.
	 * @param file 멀티파트 파일 객체
	 * @return 클래스 리스트
	 */
	public List<Fruit> uploadExcelFile(MultipartFile file){
		List<Fruit> list = new ArrayList<Fruit>();
		try {
			//OPCPackage 로 업로드한 파일을 읽어들임
			OPCPackage opcPackage = OPCPackage.open(file.getInputStream());
			XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
			
			// 첫번째 시트 불러오기
			XSSFSheet sheet = workbook.getSheetAt(0);
			
			for(int i=1; i<sheet.getLastRowNum() + 1; i++) {
				Fruit fruit = new Fruit();
				//첫번째 줄
				XSSFRow row = sheet.getRow(i);
				
				if(null == row) {
					continue;
				}
				
				// 해당 행의 두번쨰 열
				XSSFCell cell = row.getCell(1);
				if(null != cell && cell.getCellType() == CellType.STRING) {
					fruit.setName(cell.getStringCellValue());
				}
				//해당 행의 세번째 열
				cell = row.getCell(2);
				if(null != cell ) {
					fruit.setPrice((long)cell.getNumericCellValue());
				}
				//해당 행의 네번째 열
				cell = row.getCell(2);
				if(null != cell) {
					fruit.setQuantity((int)cell.getNumericCellValue());
				}
				list.add(fruit);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 생성한 엑셀 워크북을 컨트롤러 에서 받게 해줌
	 * @param list
	 * @return
	 */
	public SXSSFWorkbook excelFileDownloadProcess(List<Fruit> list) {
		return this.makeSimpleExcelWorkBook(list);
	}
}
