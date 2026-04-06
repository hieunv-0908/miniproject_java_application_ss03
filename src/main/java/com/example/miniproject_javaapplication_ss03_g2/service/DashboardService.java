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

    // 1. Tổng số sinh viên trong nhóm
    public int getTotalStudents() {
        return studentRepository.findAll().size();
    }

    // 2. GPA trung bình toàn nhóm (Làm tròn 2 chữ số thập phân)
    public double getAverageGPA() {
        return studentRepository.findAll().stream()
                .mapToDouble(Student::getGpa)
                .average()
                .orElse(0.0);
    }

    // 3. Tìm Thủ khoa (Người có GPA cao nhất)
    public Student getTopStudent() {
        return studentRepository.findAll().stream()
                .max(Comparator.comparingDouble(Student::getGpa))
                .orElse(null);
    }

    /**
     * 4. Tính tỷ lệ % theo trạng thái (Đang học, Bảo lưu, Tốt nghiệp)
     * Trả về Map<Trạng thái, Phần trăm>
     */
    public Map<String, Double> getStatusDistribution() {
        List<Student> all = studentRepository.findAll();
        int total = all.size();
        if (total == 0) return Map.of();

        return all.stream()
                .collect(Collectors.groupingBy(
                        Student::getStatus,
                        Collectors.collectingAndThen(
                                Collectors.counting(),
                                count -> Math.round((count * 100.0 / total) * 100.0) / 100.0 // Làm tròn 2 số
                        )
                ));
    }
}