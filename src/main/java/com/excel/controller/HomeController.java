package com.excel.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.excel.domain.SalaryType;
import com.excel.mapper.SalaryMapper;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	private SalaryMapper salaryMapper;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		List<SalaryType> list = salaryMapper.selectExcelList();

		model.addAttribute("list", list);
		return "home";
	}

}
