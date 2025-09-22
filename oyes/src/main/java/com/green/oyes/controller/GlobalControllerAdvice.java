package com.green.oyes.controller;

import com.green.oyes.dto.Department;
import com.green.oyes.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice
public class GlobalControllerAdvice {
	
	
    @Autowired
    private DepartmentService ds;

    @ModelAttribute("allDepartments")
    public List<Department> addDepartmentsToModel() {
        return ds.list();
    }
}
