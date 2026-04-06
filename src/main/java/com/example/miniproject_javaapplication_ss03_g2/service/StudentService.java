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
     * UC-01 & UC-03: Xử lý lấy danh sách, lọc và sắp xếp tuần tự
     */
    public List<Student> getProcessedStudents(String search, String faculty, String sortBy) {
        // Lấy dữ liệu gốc từ phần của bạn Kì
        List<Student> students = new ArrayList<>(studentRepository.findAll());

        // 1. Lọc theo tên (Search)
        if (search != null && !search.trim().isEmpty()) {
            students = students.stream()
                    .filter(s -> s.getFullName().toLowerCase().contains(search.toLowerCase().trim()))
                    .collect(Collectors.toList());
        }

        // 2. Lọc theo khoa (Faculty)
        if (faculty != null && !faculty.trim().isEmpty()) {
            students = students.stream()
                    .filter(s -> s.getFaculty().equalsIgnoreCase(faculty.trim()))
                    .collect(Collectors.toList());
        }

        // 3. Sắp xếp (Sort)
        if (sortBy != null) {
            switch (sortBy.toLowerCase()) {
                case "name":
                    students.sort(Comparator.comparing(Student::getFullName, String.CASE_INSENSITIVE_ORDER));
                    break;
                case "gpa":
                    // Sắp xếp GPA giảm dần (Thủ khoa lên đầu)
                    students.sort(Comparator.comparingDouble(Student::getGpa).reversed());
                    break;
            }
        }

        return students;
    }

    public Student getStudentById(int id) {
        return studentRepository.findAll().stream()
                .filter(s -> s.getId() == id)
                .findFirst()
                .orElse(null);
    }


    public int countResults(List<Student> list) {
        return list.size();
    }
}