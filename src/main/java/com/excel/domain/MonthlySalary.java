package com.excel.domain;

import java.lang.reflect.Field;
import java.util.List;

import lombok.Data;

@Data
public class MonthlySalary {
	private int msNo;
	private int jan;
	private int feb;
	private int mar;
	private int apr;
	private int may;
	private int jun;
	private int jul;
	private int aug;
	private int sep;
	private int oct;
	private int nov;
	private int dec;
	
	
	public static MonthlySalary addFields(List<Integer> list) {
		MonthlySalary monthlySalary = new MonthlySalary();
		Field[] fields = monthlySalary.getClass().getDeclaredFields();
		int index = -1;
		try {
		for(Field field : fields) {
			if( index > -1) {
				field.set(monthlySalary, list.get(index));
			}
			index ++;
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return monthlySalary;
	}
}
