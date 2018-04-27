package com.dcms.model;

/**
 * Created by single on 2018/4/26.
 * 竞赛统计类
 */

public class CompetitionStat {
    private int competitionId;//竞赛id
    private int applyNumber; //报名人数
    private String groupName; //组别
    private double average; //平均分
    private int maxGrape;//最高分
    private int minGrape;//最低分

    public int getCompetitionId() {
        return competitionId;
    }

    public void setCompetitionId(int competitionId) {
        this.competitionId = competitionId;
    }

    public int getApplyNumber() {
        return applyNumber;
    }

    public void setApplyNumber(int applyNumber) {
        this.applyNumber = applyNumber;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public double getAverage() {
        return average;
    }

    public void setAverage(double average) {
        this.average = average;
    }

    public int getMaxGrape() {
        return maxGrape;
    }

    public void setMaxGrape(int maxGrape) {
        this.maxGrape = maxGrape;
    }

    public int getMinGrape() {
        return minGrape;
    }

    public void setMinGrape(int minGrape) {
        this.minGrape = minGrape;
    }
}
