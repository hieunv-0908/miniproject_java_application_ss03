package com.example.miniproject_javaapplication_ss03_g2.service;

import com.example.miniproject_javaapplication_ss03_g2.model.Student;
import com.example.miniproject_javaapplication_ss03_g2.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;

    // Lấy tất cả sinh viên
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    // Tìm kiếm theo tên
    public List<Student> searchByName(String keyword) {
        return studentRepository.search(keyword);
    }

    // Lọc theo khoa
    public List<Student> filterByFaculty(String faculty) {
        if (faculty == null || faculty.trim().isEmpty()) {
            return getAllStudents();
        }
        return getAllStudents().stream()
                .filter(s -> s.getFaculty().equalsIgnoreCase(faculty.trim()))
                .collect(Collectors.toList());
    }

    // Sắp xếp theo tên
    public List<Student> sortByName(List<Student> students) {
        List<Student> sorted = new ArrayList<>(students);
        sorted.sort(Comparator.comparing(Student::getFullName, String.CASE_INSENSITIVE_ORDER));
        return sorted;
    }

    // Sắp xếp theo GPA (cao xuống thấp)
    public List<Student> sortByGpaDesc(List<Student> students) {
        List<Student> sorted = new ArrayList<>(students);
        sorted.sort(Comparator.comparingDouble(Student::getGpa).reversed());
        return sorted;
    }

    // Lấy sinh viên theo ID
    public Student getById(int id) {
        return studentRepository.findById(id);
    }

    // ===== Các phương thức cho Dashboard =====
    // Lấy tổng số sinh viên
    public int getTotalStudents() {
        return studentRepository.findAll().size();
    }

    // Tính điểm trung bình GPA
    public double getAverageGpa() {
        List<Student> students = studentRepository.findAll();
        if (students.isEmpty()) return 0.0;
        return students.stream()
                .mapToDouble(Student::getGpa)
                .average()
                .orElse(0.0);
    }

    // Lấy sinh viên có GPA cao nhất (thủ khoa)
    public Student getTopStudent() {
        return studentRepository.findAll().stream()
                .max(Comparator.comparing(Student::getGpa))
                .orElse(null);
    }

    // Thống kê tỷ lệ % theo trạng thái
    public Map<String, Double> getStatusStatistics() {
        List<Student> students = studentRepository.findAll();
        int total = students.size();
        if (total == 0) return Collections.emptyMap();

        return students.stream()
                .collect(Collectors.groupingBy(
                        Student::getStatus,
                        Collectors.collectingAndThen(
                                Collectors.counting(),
                                count -> (count * 100.0) / total
                        )
                ));
    }

    /**
     * Xử lý logic lấy danh sách, lọc và sắp xếp sinh viên (phương thức tổng hợp)
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
}