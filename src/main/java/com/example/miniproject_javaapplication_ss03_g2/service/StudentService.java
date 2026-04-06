package com.example.miniproject_javaapplication_ss03_g2.service;

import com.example.miniproject_javaapplication_ss03_g2.model.Student;
import com.example.miniproject_javaapplication_ss03_g2.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;

    /**
     * Xử lý logic lấy danh sách, lọc và sắp xếp sinh viên
     * Phục vụ cho các URL: /students, /students?sortBy=..., /students?search=..., /students?faculty=...
     */
    public List<Student> processStudentList(String search, String faculty, String sortBy) {
        // Lấy dữ liệu gốc từ Repository
        List<Student> students = new ArrayList<>(studentRepository.findAll());

        // 1. Logic Tìm kiếm theo tên (UC-03)
        // URL mẫu: /students?search=Nguyen
        if (search != null && !search.trim().isEmpty()) {
            students = students.stream()
                    .filter(s -> s.getFullName().toLowerCase().contains(search.toLowerCase().trim()))
                    .collect(Collectors.toList());
        }

        // 2. Logic Lọc theo khoa (UC-03)
        // URL mẫu: /students?faculty=CNTT
        if (faculty != null && !faculty.trim().isEmpty()) {
            students = students.stream()
                    .filter(s -> s.getFaculty().equalsIgnoreCase(faculty.trim()))
                    .collect(Collectors.toList());
        }

        // 3. Logic Sắp xếp (UC-01)
        if (sortBy != null) {
            switch (sortBy.toLowerCase()) {
                case "name":
                    // Sắp xếp tên từ A-Z
                    students.sort(Comparator.comparing(Student::getFullName, String.CASE_INSENSITIVE_ORDER));
                    break;
                case "gpa":
                    // Sắp xếp GPA từ cao xuống thấp (giảm dần)
                    students.sort(Comparator.comparingDouble(Student::getGpa).reversed());
                    break;
                default:
                    // Mặc định hoặc không truyền sortBy thì giữ nguyên thứ tự Repository
                    break;
            }
        }

        return students;
    }

    public Student getStudentById(int id) {
        return studentRepository.findById(id);
    }
}