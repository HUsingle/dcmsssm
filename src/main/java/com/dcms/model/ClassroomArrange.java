package com.dcms.model;

/**
 * Created by single on 2018/4/13.
 */
public class ClassroomArrange {
    private long id;
    private int  classroomId; //教室Id
    private int seatNumber;  //座位号
    private long applyId; //报名ID
    private int isAbsent; //是否缺考
    private Apply apply;
    private Classroom classroom;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getApplyId() {
        return applyId;
    }

    public void setApplyId(long applyId) {
        this.applyId = applyId;
    }

    public int getClassroomId() {
        return classroomId;
    }

    public void setClassroomId(int classroomId) {
        this.classroomId = classroomId;
    }

    public int getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(int seatNumber) {
        this.seatNumber = seatNumber;
    }

    public Apply getApply() {
        return apply;
    }

    public void setApply(Apply apply) {
        this.apply = apply;
    }

    public Classroom getClassroom() {
        return classroom;
    }

    public void setClassroom(Classroom classroom) {
        this.classroom = classroom;
    }

    public int getIsAbsent() {
        return isAbsent;
    }

    public void setIsAbsent(int isAbsent) {
        this.isAbsent = isAbsent;
    }
}
