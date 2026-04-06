package com.example.miniproject_javaapplication_ss03_g2.controller;

package com.example.miniproject_javaapplication_ss03_g2.controller;

import com.example.miniproject_javaapplication_ss03_g2.model.Student;
import com.example.miniproject_javaapplication_ss03_g2.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;

@Controller
public class DashboardController {

    @Autowired
    private StudentService studentService;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {

        int totalStudents = studentService.getTotalStudents();
        double avgGpa = studentService.getAverageGpa();
        Student topStudent = studentService.getTopStudent();
        Map<String, Double> statusStats = studentService.getStatusStatistics();

        model.addAttribute("totalStudents", totalStudents);
        model.addAttribute("avgGpa", avgGpa);
        model.addAttribute("topStudent", topStudent);
        model.addAttribute("statusStats", statusStats);

        return "dashboard";
    }
}
