package com.example.miniproject_javaapplication_ss03_g2.controller;

import com.example.miniproject_javaapplication_ss03_g2.model.Student;
import com.example.miniproject_javaapplication_ss03_g2.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/students")
public class StudentController {

    @Autowired
    private StudentService studentService;

    // UC-01 + UC-03: List + Sort + Search + Filter
    @GetMapping
    public String getAllStudents(
            @RequestParam(required = false) String sortBy,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String faculty,
            Model model) {

        List<Student> students = studentService.getAllStudents();

        // Search theo tên
        if (search != null && !search.isEmpty()) {
            students = studentService.searchByName(search);
            model.addAttribute("message", "Tìm thấy " + students.size() + " sinh viên phù hợp");
        }

        // Filter theo khoa
        if (faculty != null && !faculty.isEmpty()) {
            students = studentService.filterByFaculty(faculty);
            model.addAttribute("message", "Tìm thấy " + students.size() + " sinh viên phù hợp");
        }

        // Sort
        if ("name".equals(sortBy)) {
            students = studentService.sortByName(students);
        } else if ("gpa".equals(sortBy)) {
            students = studentService.sortByGpaDesc(students);
        }

        model.addAttribute("students", students);
        return "student-list";
    }

    // UC-02: Xem chi tiết
    @GetMapping("/detail")
    public String getStudentDetail(@RequestParam("id") int id, Model model) {
        Student student = studentService.getById(id);
        model.addAttribute("student", student);
        return "student-detail";
    }
}