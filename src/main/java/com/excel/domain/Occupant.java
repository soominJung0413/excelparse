package com.excel.domain;

import lombok.Data;

@Data
public class Occupant {

	private int oNo;
	private String oType;
	
	private MonthlySalary monthlySalary;
}
