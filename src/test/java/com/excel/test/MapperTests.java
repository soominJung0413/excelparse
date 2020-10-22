package com.excel.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.excel.domain.Dept;
import com.excel.mapper.DeptMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:C:\\Users\\admin\\Documents\\GitHub\\excelparse\\src\\main\\webapp\\WEB-INF\\spring\\root-context.xml","file:C:\\Users\\admin\\Documents\\GitHub\\excelparse\\src\\main\\webapp\\WEB-INF\\spring\\appServlet\\servlet-context.xml"})
@WebAppConfiguration
@Log4j
public class MapperTests {
	
	@Autowired
	private DeptMapper deptMapper;
	
	@Test
	public void testDeptMapper() {
		List<Dept> list = deptMapper.selectList();
		list.forEach(item -> System.out.println(item));
	}
}
