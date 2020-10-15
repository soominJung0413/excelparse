package com.excel.listener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import com.excel.domain.SalaryType;
import com.excel.mapper.OccupantMapper;
import com.excel.mapper.SalaryMapper;

import lombok.Getter;

@Component
public class MappingValueListener {
	
	@Getter
	public static Map<String, Integer> salaryType;
	@Getter
	public static Map<String, Integer> occupant;

	@Autowired
	private SalaryMapper salaryMapper;

	@Autowired
	private OccupantMapper occupantMapper;

	@EventListener
	public void HandleMapping(ContextRefreshedEvent contextRefreshedEvent) {
		salaryType = new HashMap<>();
		occupant = new HashMap<>();
		
		List<SalaryType> salList = salaryMapper.selectList();
		List<com.excel.domain.Occupant> occList = occupantMapper.selectList();
		
		salList.forEach(item -> salaryType.put(item.getsType(), item.getsNo()));
		occList.forEach(item -> occupant.put(item.getOType(), item.getONo()));
	}

}
