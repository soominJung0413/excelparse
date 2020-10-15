package com.excel.mapper;

import java.util.List;

import com.excel.domain.SalaryType;

public interface SalaryMapper {

	public String getNow();

	public List<SalaryType> selectList();
	
	public List<SalaryType> selectExcelList();

}
