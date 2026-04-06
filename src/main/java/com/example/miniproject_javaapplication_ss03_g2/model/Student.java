package com.example.miniproject_javaapplication_ss03_g2.model;

public class Student {
    private int id;
    private String fullName;
    private String studentCode;
    private String faculty;
    private int enrollmentYear;
    private double gpa;
    private String status;

    // Constructor rỗng (bắt buộc cho Spring/JSP)
    public Student() {
    }

    // Constructor đầy đủ
    public Student(int id, String fullName, String studentCode, String faculty,
                   int enrollmentYear, double gpa, String status) {
        this.id = id;
        this.fullName = fullName;
        this.studentCode = studentCode;
        this.faculty = faculty;
        this.enrollmentYear = enrollmentYear;
        this.gpa = gpa;
        this.status = status;
    }

    // Getter & Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }


    public String getStudentCode() {
        return studentCode;
    }

    public void setStudentCode(String studentCode) {
        this.studentCode = studentCode;
    }


    public String getFaculty() {
        return faculty;
    }

    public void setFaculty(String faculty) {
        this.faculty = faculty;
    }


    public int getEnrollmentYear() {
        return enrollmentYear;
    }

    public void setEnrollmentYear(int enrollmentYear) {
        this.enrollmentYear = enrollmentYear;
    }


    public double getGpa() {
        return gpa;
    }

    public void setGpa(double gpa) {
        this.gpa = gpa;
    }


    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
