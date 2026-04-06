package com.example.miniproject_javaapplication_ss03_g2.service;

import com.example.miniproject_javaapplication_ss03_g2.model.Student;
import com.example.miniproject_javaapplication_ss03_g2.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DashboardService {

    @Autowired
    private StudentRepository studentRepository;

    public int getTotalStudents() {
        return studentRepository.findAll().size();
    }

    // Tính điểm trung bình của cả nhóm
    public double getAverageGPA() {
        List<Student> students = studentRepository.findAll();
        if (students.isEmpty()) return 0.0;
        return students.stream()
                .mapToDouble(Student::getGpa)
                .average()
                .orElse(0.0);
    }

    // Tìm thủ khoa (người có GPA cao nhất)
    public Student getTopStudent() {
        return studentRepository.findAll().stream()
                .max(Comparator.comparing(Student::getGpa))
                .orElse(null);
    }

    // Tính tỷ lệ % theo trạng thái (Đang học, Bảo lưu, Tốt nghiệp)
    public Map<String, Double> getStatusPercentages() {
        List<Student> students = studentRepository.findAll();
        int total = students.size();
        if (total == 0) return Map.of();

        return students.stream()
                .collect(Collectors.groupingBy(
                        Student::getStatus,
                        Collectors.collectingAndThen(
                                Collectors.counting(),
                                count -> (count * 100.0) / total
                        )
                ));
    }
}