package com.excel.listener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;

import lombok.Getter;

@Component
public class MappingValueListener {
	
	@Getter
	public static Map<String, Integer> salaryType;
	@Getter
	public static Map<String, Integer> occupant;
	
	@Autowired
	private WebApplicationContext applicationContext;

	@EventListener
	public void HandleMapping(ContextRefreshedEvent contextRefreshedEvent) {
		salaryType = new HashMap<>();
		occupant = new HashMap<>();
		ServletContext servletContext = applicationContext.getServletContext();
		String contextPath = servletContext.getContextPath();
		servletContext.setAttribute("ctx", contextPath);
	}

}
