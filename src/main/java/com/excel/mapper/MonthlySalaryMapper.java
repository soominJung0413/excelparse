package com.excel.mapper;

import java.util.List;

import com.excel.domain.MonthlySalary;

public interface MonthlySalaryMapper {
	
	public List<MonthlySalary> selectList();

	public int insert(MonthlySalary monthlySalary);
}
