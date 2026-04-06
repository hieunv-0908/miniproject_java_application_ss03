package com.example.miniproject_javaapplication_ss03_g2.repository;

import com.example.miniproject_javaapplication_ss03_g2.model.Student;
import org.springframework.stereotype.Repository;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class StudentRepository {

    private List<Student> students = new ArrayList<>();

    public StudentRepository() {
        // === DỮ LIỆU CỨNG (Hardcoded) - Thay tên thật của nhóm vào ===
        students.add(new Student(1, "B24DTCN352", "Đỗ Hồng Kỳ", "CNTT", 2024, 3.85, "Đang học"));
        students.add(new Student(2, "B24DTCN354", "Đào Xuân Khánh", "CNTT", 2024, 3.72, "Đang học"));
        students.add(new Student(3, "B24DTCN301", "Nguyễn Văn An", "CNTT", 2024, 3.45, "Đang học"));
        students.add(new Student(4, "B24DTCN305", "Trần Thị Bình", "Kế toán", 2023, 3.90, "Đang học"));
        students.add(new Student(5, "B23DTCN201", "Lê Văn Cường", "CNTT", 2023, 2.85, "Bảo lưu"));
        students.add(new Student(6, "B22DTCN105", "Phạm Thị Dung", "CNTT", 2022, 3.95, "Tốt nghiệp"));
        students.add(new Student(7, "B24DTCN310", "Hoàng Văn Em", "Marketing", 2024, 3.60, "Đang học"));
    }

    public List<Student> findAll() {
        return new ArrayList<>(students);
    }

    public Student findById(int id) {
        return students.stream()
                .filter(s -> s.getId() == id)
                .findFirst()
                .orElse(null);
    }

    // Tìm kiếm theo tên, mã SV, khoa
    public List<Student> search(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return findAll();
        }
        String key = keyword.toLowerCase().trim();
        return students.stream()
                .filter(s -> s.getFullName().toLowerCase().contains(key) ||
                        s.getStudentCode().toLowerCase().contains(key) ||
                        s.getFaculty().toLowerCase().contains(key))
                .collect(Collectors.toList());
    }

    // Sắp xếp
    public List<Student> findAllSorted(String sortBy) {
        List<Student> list = findAll();

        if (sortBy == null) return list;

        switch (sortBy.toLowerCase()) {
            case "name":
                list.sort(Comparator.comparing(Student::getFullName, String.CASE_INSENSITIVE_ORDER));
                break;
            case "gpa":
                list.sort(Comparator.comparingDouble(Student::getGpa).reversed());
                break;
            case "year":
                list.sort(Comparator.comparingInt(Student::getEnrollmentYear).reversed());
                break;
        }
        return list;
    }
}
