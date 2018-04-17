package com.dcms.model;

public class ExamInfo {
    private long id;  //ID
    private Classroom classroom;
    private Apply apply;
    private int seatNo;  //座位号

    public ExamInfo() {
    }

    public ExamInfo(long id, Classroom classroom, Apply apply, int seatNo) {
        this.id = id;
        this.classroom = classroom;
        this.apply = apply;
        this.seatNo = seatNo;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Classroom getClassroom() {
        return classroom;
    }

    public void setClassroom(Classroom classroom) {
        this.classroom = classroom;
    }

    public Apply getApply() {
        return apply;
    }

    public void setApply(Apply apply) {
        this.apply = apply;
    }

    public int getSeatNo() {
        return seatNo;
    }

    public void setSeatNo(int seatNo) {
        this.seatNo = seatNo;
    }
}
