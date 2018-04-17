package com.dcms.service.imp;

import com.dcms.dao.ApplyMapper;
import com.dcms.dao.ClassroomArrangeMapper;
import com.dcms.model.Apply;
import com.dcms.model.ClassroomArrange;
import com.dcms.service.ClassroomArrangeService;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * Created by single on 2018/4/14.
 */
@Service
public class ClassroomArrangeServiceImpl implements ClassroomArrangeService {
    @Autowired
    private ApplyMapper applyMapper;
    @Autowired
    private ClassroomArrangeMapper classroomArrangeMapper;

    public List<ClassroomArrange> findClassroomArrange(Integer competitionId, String groupName, Integer classroomId) {
        return classroomArrangeMapper.findClassroomArrange(competitionId, groupName, classroomId);
    }

    public String deleteClassroomArrange(String id) {
        return Tool.result(classroomArrangeMapper.deleteClassroomArrange(Tool.getLong(id)));
    }

    public String updateClassroomArrange(Long id, Integer seatNumber, Integer classroomId, Integer competitionId) {
        int isExistPeople = classroomArrangeMapper.IsExistPeople(competitionId, classroomId, seatNumber);
        if (isExistPeople > 0) {
            return Tool.result("该座位号已经被安排");
        }
        ClassroomArrange classroomArrange = new ClassroomArrange();
        classroomArrange.setId(id);
        classroomArrange.setSeatNumber(seatNumber);
        classroomArrange.setClassroomId(classroomId);
        String result = classroomArrangeMapper.updateClassroomArrange(classroomArrange) + "";
        return Tool.result(result);
    }

    @Transactional
    public String arrangeExamRoom(Integer competitionId, String competitionGroup, String examRoom, String peopleNum) {
        //获取报名该竞赛该组别的人数
        int applyCount = applyMapper.findApplyNumByGroup(competitionId, competitionGroup);
        Integer[] examRoomNum = Tool.getInteger(peopleNum); //考场人数
        Integer[] examRoomId = Tool.getInteger(examRoom);  //考场Id
        int arrangeExamRoomNum = 0;
        if (applyCount == 0) {
            return Tool.result("报名该组的总人数为0,无法进行安排！");
        }
        for (int i = 0; i < examRoomNum.length; i++) {
            arrangeExamRoomNum += examRoomNum[i];
            if (applyCount < arrangeExamRoomNum && i < examRoomNum.length - 1) {
                return Tool.result("考场选择过多！");
            }
        }
        if (applyCount > arrangeExamRoomNum) {
            return Tool.result("安排考场的总人数少于报名该组的总人数！");
        }
        int IsArrangeClassRoom = classroomArrangeMapper.findAlreadyClassroomArrangeNumByGroupName(competitionId, competitionGroup);
        if (IsArrangeClassRoom > 0) {
            return Tool.result("该竞赛的该组别已经安排了考场，不能重复安排！");
        }
        for (int i = 0; i < examRoomId.length; i++) {
            if (classroomArrangeMapper.findAlreadyClassroomArrangeNumByClassroomId(competitionId, examRoomId[i]) > 0) {
                return Tool.result("该竞赛的该考场已经安排了考场，不能重复安排！");
            }
        }
        //获取该竞赛该组别的报名信息
        List<Apply> applyList = applyMapper.findApplyIdByGroupAndCid(competitionId, competitionGroup);
        List<ClassroomArrange> classroomArrangeList = new ArrayList<ClassroomArrange>();
        ClassroomArrange classroomArrange = null;
        List<List<Long>> applyIdList = new ArrayList<List<Long>>();//不同班级的报名id列表
        List<Long> oneOfApplyIdList = null; //其中一个班级的所有报名id
        String studentClass = null;        //学生班级
        Long applyId;                     //报名id
        for (int i = 0; i < 200; i++) {//假设有200个不同的班级
            if (applyList.size() == 0)// 如果报名信息为空则结束循环
                break;
            studentClass = applyList.get(0).getStudent().getStudentClass();//获取第一个班级名称
            oneOfApplyIdList = new ArrayList<Long>();                    //其中之一个同班级的applyId
            applyId = applyList.get(0).getId();                       //获取第一个报名id
            oneOfApplyIdList.add(applyId);
            //System.out.println(applyList.size()+"ashfkjsadklfj");
            for (int l = applyList.size() - 1; l > 0; l--) {  //从报名信息中找出与studentClass相同的所有报名id
                if (applyList.get(l).getStudent().getStudentClass().equals(studentClass)) {
                    oneOfApplyIdList.add(applyList.get(l).getId());
                    applyList.remove(l); //移除相同报名信息
                }
            }
            applyIdList.add(oneOfApplyIdList);
            applyList.remove(0);
        }
        List<Long> allApplyId = new LinkedList<Long>();//打乱后所有的applyId
        //int maxApplyId=applyIdList.get(0).size();//获取数量最多班级号
        // int temp;
        for (int t = 0; t < applyIdList.size() - 1; t++) { //从大到小排序，冒泡法
            for (int u = 0; u < applyIdList.size() - t - 1; u++) {
                if (applyIdList.get(u).size() < applyIdList.get(u + 1).size()) {
                    Collections.swap(applyIdList, u, u + 1);
                }
            }
        }
        int insertIndex = -1;
        int sum = applyIdList.get(0).size();//开始间隔数
        int alreadyInsertNum = sum;
        allApplyId.addAll(applyIdList.get(0));
        applyIdList.remove(0);
        if (applyIdList.size() > 0) {
            Long[] restApplyId = new Long[applyCount - sum];
            int restSum = 0;
            for (int a = 0; a < applyIdList.size(); a++) {
                for (int b = 0; b < applyIdList.get(a).size(); b++) {
                    restApplyId[restSum] = applyIdList.get(a).get(b);//将剩余的数放到数组中
                    restSum++;
                }
            }
            if (sum - 1 == 0) {
                //for (int a = 0; a < restApplyId.length; a++) {
                allApplyId.addAll(Arrays.asList(restApplyId));
                //}
            } else {
                for (int a = 0; a < restApplyId.length; a++) {
                    allApplyId.add(insertIndex + 2, restApplyId[a]);
                    insertIndex = insertIndex + 2;
                    if (a == alreadyInsertNum - 1) {
                        insertIndex = -1;
                        sum = 2 * sum;
                        alreadyInsertNum += sum;
                    }
                }
            }

        }
        int temp = 0;
        int k;
        // System.out.println(allApplyId.size()+"  sfsdfsdfss");
        here:
        for (int j = 0; j < examRoomId.length; j++) {
            for (k = 0; k < examRoomNum[j]; k++) {
                classroomArrange = new ClassroomArrange();
                classroomArrange.setClassroomId(examRoomId[j]);
                classroomArrange.setSeatNumber(k + 1);
                classroomArrange.setApplyId(allApplyId.get(k + temp));
                classroomArrangeList.add(classroomArrange);
                if (k + temp == applyCount - 1) {
                    break here;
                }
            }
            temp += examRoomId[k];
        }
        // System.out.println(classroomArrangeList.size()+"  sfsdfsdfdfsfsdfsdfss");
        String result = classroomArrangeMapper.insertClassroomArrange(classroomArrangeList) + "";
        //System.out.println(result+"  sfsdfsdfddfss");
        return Tool.result(result);
        // return Tool.result("错误");
    }
}

