package com.excel.test;

import static org.junit.Assert.assertThat;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hamcrest.Matcher;
import org.hamcrest.core.IsNot;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.excel.domain.MonthlySalary;
import com.excel.domain.Occupant;
import com.excel.domain.SalaryType;
import com.excel.listener.MappingValueListener;
import com.excel.mapper.MonthlySalaryMapper;
import com.excel.mapper.OccupantMapper;
import com.excel.mapper.SalaryMapper;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@WebAppConfiguration
@Log4j
public class MybatisMapperTests {

	@Autowired
	private SalaryMapper salaryMapper;

	@Autowired
	private OccupantMapper occupantMapper;
	
	@Autowired
	private MonthlySalaryMapper monthlySalaryMapper;
	
	@Autowired
	private MappingValueListener mappingValueListener;

//	@Test
	public void testExists() {
		String now = salaryMapper.getNow();
		log.info(now);
	}

//	@Test
	public void testSelectList() {
		List<MonthlySalary> list = monthlySalaryMapper.selectList();
		list.forEach(item -> log.info(item));
	}
	
//	@Test
	public void checkExists() {
		Map<String, Integer> map = mappingValueListener.getSalaryType();
		Set<String> keys = map.keySet();
		
		for(String key : keys) {
			log.info(map.get(key));
		}
	}
	
	@Test
	public void testJoin() {
		List<SalaryType> list = salaryMapper.selectExcelList();
		list.forEach(item -> log.info(item));
	}

}
