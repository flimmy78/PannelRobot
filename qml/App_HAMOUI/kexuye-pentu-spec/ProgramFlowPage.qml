import QtQuick 1.1
import "../teach"
import "KeXuYePentuRecord.js" as KXYRecord
import "../teach/ProgramFlowPage.js" as BasePData
import "Teach.js" as LocalTeach
import "../teach/Teach.js" as BaseTeach
import "../../utils/stringhelper.js" as ICString
import "../ShareData.js" as ShareData
import "../configs/Keymap.js" as Keymap


ProgramFlowPage {

    id:base
    actionMenuFrameSource: "ProgramActionMenuFrame.qml"

    function getRecordContent(which){
        if(which == 0)
            return JSON.parse(KXYRecord.keXuyePentuRecord.getRecordContent(panelRobotController.currentRecordName()));
        else
            return JSON.parse(panelRobotController.programs(which));
    }

    function pentuActionHead(actionObject){
        var ret = [];
        console.log("bbbbb", actionObject.deepAxis);
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, actionObject.deepAxis, 0, actionObject.startSpeed2));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SYNC_START));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, actionObject.rpeateAxis, actionObject.startPos0, actionObject.startSpeed0));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, actionObject.dirAxis, actionObject.startPos1, actionObject.startSpeed1));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, 3, actionObject.startPos.pos.m3, actionObject.startSpeed3));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, 4, actionObject.startPos.pos.m4, actionObject.startSpeed4));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, 5, actionObject.startPos.pos.m5, actionObject.startSpeed5));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SYNC_END));

        ret.push(LocalTeach.generateClearCounterAction(actionObject.dirCounterID));
        ret.push(LocalTeach.generateClearCounterAction(actionObject.repeateCounterID));
        ret.push(LocalTeach.generateClearCounterAction(actionObject.rotateCounterID));

        ret.push(LocalTeach.generateFlagAction(actionObject.flag0, qsTr("Fixture Rotation")));
        return ret;
    }
    function pentuActionEnd(actionObject){
        var ret = [];
        ret.push(LocalTeach.generateCounterJumpAction(actionObject.flag0, actionObject.rotateCounterID, 0, 1));
        return ret;
    }

    function pentuActionToProgram(actionObject){
        var ret = [];
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, actionObject.deepAxis, 0, actionObject.startSpeed2));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SYNC_START));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, actionObject.rpeateAxis, actionObject.startPos0, actionObject.startSpeed0));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, actionObject.dirAxis, actionObject.startPos1, actionObject.startSpeed1));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SYNC_END));
        ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, actionObject.deepAxis, actionObject.zlength, actionObject.startSpeed2));

        ret.push(LocalTeach.generateFlagAction(actionObject.flag1, qsTr("Dir Move")));
        if(actionObject.fixture1Switch == 4){
            ret.push(LocalTeach.generateOutputAction(4, 0, 1, 0, actionObject.fixtureDelay0));
            ret.push(LocalTeach.generateOutputAction(5, 0, 1, 0, actionObject.fixtureDelay1));
            ret.push(LocalTeach.generateOutputAction(6, 0, 1, 0, actionObject.fixtureDelay2));
        }
        else if(actionObject.fixture1Switch == 3){
            ret.push(LocalTeach.generateOutputAction(4, 0, 0, 0, 0, actionObject.fixtureDelay0));
            ret.push(LocalTeach.generateOutputAction(5, 0, 0, 0, 0, actionObject.fixtureDelay1));
            ret.push(LocalTeach.generateOutputAction(6, 0, 0, 0, 0, actionObject.fixtureDelay2));
        }
        if(actionObject.fixture2Switch == 4){
            ret.push(LocalTeach.generateOutputAction(7, 0, 1, 0, actionObject.fixture2Delay0));
            ret.push(LocalTeach.generateOutputAction(8, 0, 1, 0, actionObject.fixture2Delay1));
            ret.push(LocalTeach.generateOutputAction(9, 0, 1, 0, actionObject.fixture2Delay2));
        }
        else if(actionObject.fixture2Switch == 3){
            ret.push(LocalTeach.generateOutputAction(7, 0, 0, 0, 0, actionObject.fixture2Delay0));
            ret.push(LocalTeach.generateOutputAction(8, 0, 0, 0, 0, actionObject.fixture2Delay1));
            ret.push(LocalTeach.generateOutputAction(9, 0, 0, 0, 0, actionObject.fixture2Delay2));
        }
        ret.push(LocalTeach.generateFlagAction(actionObject.flag2, qsTr("Repeate")));

        if(actionObject.fixture1Switch == 1 || actionObject.fixture1Switch == 2){
            ret.push(LocalTeach.generateOutputAction(4, 0, 1, 0, actionObject.fixtureDelay0));
            ret.push(LocalTeach.generateOutputAction(5, 0, 1, 0, actionObject.fixtureDelay1));
            ret.push(LocalTeach.generateOutputAction(6, 0, 1, 0, actionObject.fixtureDelay2));
        }
        if(actionObject.fixture2Switch == 1 || actionObject.fixture2Switch == 2){
            ret.push(LocalTeach.generateOutputAction(7, 0, 1, 0, actionObject.fixture2Delay0));
            ret.push(LocalTeach.generateOutputAction(8, 0, 1, 0, actionObject.fixture2Delay1));
            ret.push(LocalTeach.generateOutputAction(9, 0, 1, 0, actionObject.fixture2Delay2));
        }

//            ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, actionObject.rpeateAxis,
//                     actionObject.point1_m0, actionObject.repeatSpeed));
        var pos = {};
        var tmp = {};
        pos["m" + 0] = actionObject.point1.pos.m0 - actionObject.startPos.pos.m0;
        pos["m" + 1] = actionObject.point1.pos.m1 - actionObject.startPos.pos.m1;
        pos["m" + 2] = actionObject.point1.pos.m2 - actionObject.startPos.pos.m2;
        if(actionObject.mode == 0 || actionObject.mode == 4){
            tmp["m" + 0] = pos["m" + 0] / 2;
            tmp["m" + 1] = pos["m" + 1] / 2;
            tmp["m" + 2] = pos["m" + 2] / 2;
            var tmp1 = {};
            tmp1["m" + 0] = -tmp["m" + 0];
            tmp1["m" + 1] = -tmp["m" + 1];
            tmp1["m" + 2] = -tmp["m" + 2];
            if(actionObject.plane == 0){
                if(actionObject.dirAxis == 0)
                    pos["m" + 0] = 0;
                else pos["m" + 1] = 0;
                if(actionObject.mode == 4)
                    tmp["m" + 2] = tmp1["m" + 2] = actionObject.startPos2 - actionObject.zlength;
            }
            else if(actionObject.plane == 1){
                if(actionObject.dirAxis == 0)
                    pos["m" + 0] = 0;
                else pos["m" + 2] = 0;
                if(actionObject.mode == 4)
                    tmp["m" + 1] = tmp1["m" + 1] = actionObject.startPos2 - actionObject.zlength;
            }
            else if(actionObject.plane == 2){
                if(actionObject.dirAxis == 1)
                    pos["m" + 1] = 0;
                else pos["m" + 2] = 0;
                if(actionObject.mode == 4)
                    tmp["m" + 0] = tmp1["m" + 0] = actionObject.startPos2 - actionObject.zlength;
            }
            var pos1 = {};
            pos1["m" + 0] = -pos["m" + 0];
            pos1["m" + 1] = -pos["m" + 1];
            pos1["m" + 2] = -pos["m" + 2];
            if(actionObject.mode == 0)
                ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION,
                         [{"pointName":"", "pos":pos}], actionObject.repeatSpeed, 0.0));
            else if(actionObject.mode == 4)
                ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION,
                         [{"pointName":"", "pos":pos}], actionObject.repeatSpeed, 0.0));
            if(actionObject.fixture1Switch == 0 || actionObject.fixture1Switch == 2){
                ret.push(LocalTeach.generateOutputAction(4, 0, 0, 0, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 0, 0, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 0, 0, 0, actionObject.fixtureDelay2));
            }
            if(actionObject.fixture2Switch == 0 || actionObject.fixture2Switch == 2){
                ret.push(LocalTeach.generateOutputAction(7, 0, 0, 0, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 0, 0, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 0, 0, 0, actionObject.fixture2Delay2));
            }

            if(actionObject.dirAxis == 0)
                ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":actionObject.dirLength,"m1":"0.000","m2":"0.000"}}], actionObject.dirSpeed, 0.0));
            else if(actionObject.dirAxis == 1)
                ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":"0.000","m1":actionObject.dirLength,"m2":"0.000"}}], actionObject.dirSpeed, 0.0));
            else if(actionObject.dirAxis == 2)
                ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":"0.000","m1":"0.000","m2":actionObject.dirLength}}], actionObject.dirSpeed, 0.0));
            if(actionObject.fixture1Switch == 0 || actionObject.fixture1Switch == 2){
                ret.push(LocalTeach.generateOutputAction(4, 0, 1, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 1, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 1, 0, actionObject.fixtureDelay2));
            }
            if(actionObject.fixture2Switch == 0 || actionObject.fixture2Switch == 2){
                ret.push(LocalTeach.generateOutputAction(7, 0, 1, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 1, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 1, 0, actionObject.fixture2Delay2));
            }
            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION,
                     [{"pointName":"", "pos":pos1}], actionObject.repeatSpeed, 0.0));
            if(actionObject.fixture1Switch == 1 || actionObject.fixture1Switch == 2){
                ret.push(LocalTeach.generateOutputAction(4, 0, 0, 0, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 0, 0, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 0, 0, 0, actionObject.fixtureDelay2));
            }
            if(actionObject.fixture2Switch == 1 || actionObject.fixture2Switch == 2){
                ret.push(LocalTeach.generateOutputAction(7, 0, 0, 0, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 0, 0, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 0, 0, 0, actionObject.fixture2Delay2));
            }
            if(actionObject.dirAxis == 0)
                ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":actionObject.dirLength,"m1":"0.000","m2":"0.000"}}], actionObject.dirSpeed, 0.0));
            else if(actionObject.dirAxis == 1)
                ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":"0.000","m1":actionObject.dirLength,"m2":"0.000"}}], actionObject.dirSpeed, 0.0));
            else if(actionObject.dirAxis == 2)
                ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":"0.000","m1":"0.000","m2":actionObject.dirLength}}], actionObject.dirSpeed, 0.0));
        }

        else if(actionObject.mode == 1){
            tmp["m" + 0] = -pos["m" + 0];
            tmp["m" + 1] = -pos["m" + 1];
            tmp["m" + 2] = -pos["m" + 2];
            if(actionObject.plane == 0){
                if(actionObject.dirAxis == 0){
                    pos["m" + 0] = 0;
                    tmp["m" + 0] = actionObject.dirLength;
                }
                else {
                    pos["m" + 1] = 0;
                    tmp["m" + 1] = actionObject.dirLength;
                }
            }
            else if(actionObject.plane == 1){
                if(actionObject.dirAxis == 0){
                    pos["m" + 0] = 0;
                    tmp["m" + 0] = actionObject.dirLength;
                }
                else {
                    pos["m" + 2] = 0;
                    tmp["m" + 2] = actionObject.dirLength;
                }
            }
            else if(actionObject.plane == 2){
                if(actionObject.dirAxis == 1){
                    pos["m" + 1] = 0;
                    tmp["m" + 1] = actionObject.dirLength;
                }
                else {
                    pos["m" + 2] = 0;
                    tmp["m" + 2] = actionObject.dirLength;
                }
            }
            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION,
                     [{"pointName":"", "pos":pos}], actionObject.repeatSpeed, 0.0));
            if(actionObject.fixture1Switch == 0 || actionObject.fixture1Switch == 2){
                ret.push(LocalTeach.generateOutputAction(4, 0, 0, 0, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 0, 0, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 0, 0, 0, actionObject.fixtureDelay2));
                ret.push(LocalTeach.generateOutputAction(4, 0, 1, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 1, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 1, 0, actionObject.fixtureDelay2));
            }
            if(actionObject.fixture2Switch == 0 || actionObject.fixture2Switch == 2){
                ret.push(LocalTeach.generateOutputAction(7, 0, 0, 0, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 0, 0, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 0, 0, 0, actionObject.fixture2Delay2));
                ret.push(LocalTeach.generateOutputAction(7, 0, 1, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 1, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 1, 0, actionObject.fixture2Delay2));
            }

            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION,
                     [{"pointName":"", "pos":tmp}], actionObject.repeatSpeed, 0.0));
            if(actionObject.fixture1Switch == 1 || actionObject.fixture1Switch == 2){
                ret.push(LocalTeach.generateOutputAction(4, 0, 0, 0, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 0, 0, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 0, 0, 0, actionObject.fixtureDelay2));
            }
            if(actionObject.fixture2Switch == 1 || actionObject.fixture2Switch == 2){
                ret.push(LocalTeach.generateOutputAction(7, 0, 0, 0, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 0, 0, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 0, 0, 0, actionObject.fixture2Delay2));
            }
        }

        else if(actionObject.mode == 2){
            tmp["m" + 0] = -pos["m" + 0];
            tmp["m" + 1] = -pos["m" + 1];
            tmp["m" + 2] = -pos["m" + 2];
            if(actionObject.plane == 0){
                if(actionObject.dirAxis == 0){
                    tmp["m" + 0] = pos["m" + 0];
                    tmp["m" + 1] = -pos["m" + 1];
                }
                else {
                    tmp["m" + 0] = -pos["m" + 0];
                    tmp["m" + 1] = pos["m" + 1];
                }
            }
            else if(actionObject.plane == 1){
                if(actionObject.dirAxis == 0){
                    tmp["m" + 0] = pos["m" + 0];
                    tmp["m" + 2] = -pos["m" + 2];
                }
                else {
                    tmp["m" + 0] = -pos["m" + 0];
                    tmp["m" + 2] = pos["m" + 2];
                }
            }
            else if(actionObject.plane == 2){
                if(actionObject.dirAxis == 1){
                    tmp["m" + 1] = pos["m" + 1];
                    tmp["m" + 2] = -pos["m" + 2];
                }
                else {
                    tmp["m" + 1] = -pos["m" + 1];
                    tmp["m" + 2] = pos["m" + 2];
                }
            }
            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION,
                     [{"pointName":"", "pos":pos}], actionObject.repeatSpeed, 0.0));
            if(actionObject.fixture1Switch == 0 || actionObject.fixture1Switch == 2){
                ret.push(LocalTeach.generateOutputAction(4, 0, 0, 0, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 0, 0, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 0, 0, 0, actionObject.fixtureDelay2));
                ret.push(LocalTeach.generateOutputAction(4, 0, 1, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 1, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 1, 0, actionObject.fixtureDelay2));
            }
            if(actionObject.fixture2Switch == 0 || actionObject.fixture2Switch == 2){
                ret.push(LocalTeach.generateOutputAction(7, 0, 0, 0, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 0, 0, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 0, 0, 0, actionObject.fixture2Delay2));
                ret.push(LocalTeach.generateOutputAction(7, 0, 1, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 1, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 1, 0, actionObject.fixture2Delay2));
            }

            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION,
                     [{"pointName":"", "pos":tmp}], actionObject.repeatSpeed, 0.0));
            if(actionObject.fixture1Switch == 1 || actionObject.fixture1Switch == 2){
                ret.push(LocalTeach.generateOutputAction(4, 0, 0, 0, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 0, 0, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 0, 0, 0, actionObject.fixtureDelay2));
            }
            if(actionObject.fixture2Switch == 1 || actionObject.fixture2Switch == 2){
                ret.push(LocalTeach.generateOutputAction(7, 0, 0, 0, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 0, 0, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 0, 0, 0, actionObject.fixture2Delay2));
            }
        }

        else if(actionObject.mode == 3){
            if(actionObject.plane == 0){
                if(actionObject.dirAxis == 0)
                    pos["m" + 0] = 0;
                else pos["m" + 1] = 0;
            }
            else if(actionObject.plane == 1){
                if(actionObject.dirAxis == 0)
                    pos["m" + 0] = 0;
                else pos["m" + 2] = 0;
            }
            else if(actionObject.plane == 2){
                if(actionObject.dirAxis == 1)
                    pos["m" + 1] = 0;
                else pos["m" + 2] = 0;
            }
            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION,
                     [{"pointName":"", "pos":pos}], actionObject.repeatSpeed, 0.0));

            if(actionObject.fixture1Switch == 0 || actionObject.fixture1Switch == 2){
                ret.push(LocalTeach.generateOutputAction(4, 0, 0, 0, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 0, 0, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 0, 0, 0, actionObject.fixtureDelay2));
                ret.push(LocalTeach.generateOutputAction(4, 0, 1, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 1, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 1, 0, actionObject.fixtureDelay2));
            }
            if(actionObject.fixture2Switch == 0 || actionObject.fixture2Switch == 2){
                ret.push(LocalTeach.generateOutputAction(7, 0, 0, 0, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 0, 0, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 0, 0, 0, actionObject.fixture2Delay2));
                ret.push(LocalTeach.generateOutputAction(7, 0, 1, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 1, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 1, 0, actionObject.fixture2Delay2));
            }

    //            ret.push(LocalTeach.generateAxisServoAction(LocalTeach.actions.F_CMD_SINGLE, actionObject.rpeateAxis,
    //                     actionObject.startPos0, actionObject.repeatSpeed));
            tmp["m" + 0] = -pos["m" + 0];
            tmp["m" + 1] = -pos["m" + 1];
            tmp["m" + 2] = -pos["m" + 2];
            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION,
                     [{"pointName":"", "pos":tmp}], actionObject.repeatSpeed, 0.0));

            if(actionObject.fixture1Switch == 1 || actionObject.fixture1Switch == 2){
                ret.push(LocalTeach.generateOutputAction(4, 0, 0, 0, 0, actionObject.fixtureDelay0));
                ret.push(LocalTeach.generateOutputAction(5, 0, 0, 0, 0, actionObject.fixtureDelay1));
                ret.push(LocalTeach.generateOutputAction(6, 0, 0, 0, 0, actionObject.fixtureDelay2));
            }
            if(actionObject.fixture2Switch == 1 || actionObject.fixture2Switch == 2){
                ret.push(LocalTeach.generateOutputAction(7, 0, 0, 0, 0, actionObject.fixture2Delay0));
                ret.push(LocalTeach.generateOutputAction(8, 0, 0, 0, 0, actionObject.fixture2Delay1));
                ret.push(LocalTeach.generateOutputAction(9, 0, 0, 0, 0, actionObject.fixture2Delay2));
            }
            ret.push(LocalTeach.generateCounterAction(actionObject.repeateCounterID));
            ret.push(LocalTeach.generateCounterJumpAction(actionObject.flag2, actionObject.repeateCounterID, 0, 1));

            if(actionObject.dirAxis == 0)
                ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":actionObject.dirLength,"m1":"0.000","m2":"0.000"}}], actionObject.dirSpeed, 0.0));
            else if(actionObject.dirAxis == 1)
                ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":"0.000","m1":actionObject.dirLength,"m2":"0.000"}}], actionObject.dirSpeed, 0.0));
            else if(actionObject.dirAxis == 2)
                ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":"0.000","m1":"0.000","m2":actionObject.dirLength}}], actionObject.dirSpeed, 0.0));
        }

//            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_LINEXY_MOVE_POINT + actionObject.plane,
//                     [{"pointName":"", "pos":actionObject.point1.pos}],actionObject.repeatSpeed, 0.0));
//            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_LINEXY_MOVE_POINT + actionObject.plane,
//                     [{"pointName":"", "pos":actionObject.startPos.pos}],actionObject.repeatSpeed, 0.0));
//        else if(actionObject.mode == 1){
//            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_ARCXY_MOVE_POINT + actionObject.plane,
//                  [{"pointName":"", "pos":actionObject.point1.pos},{"pointName":"", "pos":actionObject.point2.pos}],
//                  actionObject.repeatSpeed, 0.0));
//            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_ARCXY_MOVE_POINT + actionObject.plane,
//                  [{"pointName":"", "pos":actionObject.point1.pos},{"pointName":"", "pos":actionObject.startPos.pos}],
//                  actionObject.repeatSpeed, 0.0));
//        }

//        if(actionObject.dirAxis == 0)
//            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":actionObject.dirLength,"m1":"0.000","m2":"0.000"}}], actionObject.dirSpeed, 0.0));
//        else if(actionObject.dirAxis == 1)
//            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":"0.000","m1":actionObject.dirLength,"m2":"0.000"}}], actionObject.dirSpeed, 0.0));
//        else if(actionObject.dirAxis == 2)
//            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION, [{"pointName":"", "pos":{"m0":"0.000","m1":"0.000","m2":actionObject.dirLength}}], actionObject.dirSpeed, 0.0));
//        if(actionObject.mode == 0){
//            var tmp = {};
//            tmp["m" + 0] = -pos["m" + 0];
//            tmp["m" + 1] = -pos["m" + 1];
//            tmp["m" + 2] = -pos["m" + 2];
//            ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_COORDINATE_DEVIATION,
//                     [{"pointName":"", "pos":tmp}], actionObject.repeatSpeed, 0.0));
//        }

        ret.push(LocalTeach.generateCounterAction(actionObject.dirCounterID));
        ret.push(LocalTeach.generateCounterJumpAction(actionObject.flag1, actionObject.dirCounterID, 0, 1));


        ret.push(LocalTeach.generatePathAction(LocalTeach.actions.F_CMD_JOINT_RELATIVE, [{"pointName":"", "pos":{"m0":"0.000","m1":"0.000","m2":"0.000","m3":"0.000","m4":actionObject.rotate,"m5":"0.000"}}], actionObject.rotateSpeed, 0.0));
        ret.push(LocalTeach.generateCounterAction(actionObject.rotateCounterID));
//        ret.push(LocalTeach.generateCounterJumpAction(actionObject.flag0, actionObject.rotateCounterID, 0, 1));



        return ret;
    }

    function modelToProgram(which){
        var model = BasePData.programs[which];
        var ret = [];
        for(var i = 0; i < model.count; ++i){
            if(model.get(i).mI_ActionObject.action == LocalTeach.actions.F_CMD_PENTU){
                if(i == 0){
                    var rs = pentuActionHead(model.get(0).mI_ActionObject);
                    for(var j = 0, len = rs.length; j < len; ++j){
                        ret.push(rs[j]);
                    }
                }
                var ps = pentuActionToProgram(model.get(i).mI_ActionObject);
                for(j = 0, len = ps.length; j < len; ++j){
                    ret.push(ps[j]);
                }
                if(i == (model.count - 2)){
                    rs = pentuActionEnd(model.get(0).mI_ActionObject);
                    for(j = 0, len = rs.length; j < len; ++j){
                        ret.push(rs[j]);
                    }
                }
            }else
                ret.push(model.get(i).mI_ActionObject);
        }
        return JSON.stringify(ret);
    }

    function afterSaveProgram(which){
        var p = modelToProgramHelper(which);
        KXYRecord.keXuyePentuRecord.updateRecord(panelRobotController.currentRecordName(), JSON.stringify(p));
    }

    function actionObjectToText(actionObject){
        var originText;
        if(actionObject.action == LocalTeach.actions.F_CMD_PENTU){
            originText = LocalTeach.pentuActionToStringHandler(actionObject);
        }
        else
            originText = BaseTeach.actionToStringNoCusomName(actionObject);
        if(actionObject.customName){
            var styledCN = ICString.icStrformat('<font size="4" color="#0000FF">{0}</font>', actionObject.customName);
            originText = styledCN + " " + originText;
        }
        return "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + originText.replace(/\n                            /g, "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    }

    Rectangle{
        id:mask
        color: "#D0D0D0"
        height: 28
        width: 315
        x:2

        function onKnobChanged(knobStatus){
            mask.width = knobStatus == Keymap.KNOB_AUTO ? 315 : 550;
        }

        Component.onCompleted: {
            ShareData.GlobalStatusCenter.registeKnobChangedEvent(mask);
        }

        MouseArea{
            anchors.fill: parent
        }
    }

    KexuYeActionEdit{
        id:kexuyeActionEdit
        visible: false
        width: menuFrame().width - 20
        height: menuFrame().height - 50
    }
    KexuYeAxisSpeed{
        id:kexuyeDetailEdit
        visible: false
        width: menuFrame().width - 20
        height: 80
    }

    Component.onCompleted: {
        registerEditableAction(LocalTeach.actions.F_CMD_PENTU,
                               [{"editor":kexuyeActionEdit, "itemName":"kexuyeaction"},
                                {"editor":kexuyeDetailEdit, "itemName":"kexuyedetail"}
                               ],
                               [{"item":"kexuyeaction"}, {"item":"kexuyedetail"},{"item":"customName"}]);
    }

    onActionLineDeleted: {
        BaseTeach.counterManager.delCounter(actionObject.repeateCounterID);
        panelRobotController.delCounterDef(actionObject.repeateCounterID);
        BaseTeach.counterManager.delCounter(actionObject.dirCounterID);
        panelRobotController.delCounterDef(actionObject.dirCounterID);
        BaseTeach.counterManager.delCounter(actionObject.rotateCounterID);
        panelRobotController.delCounterDef(actionObject.rotateCounterID);
    }
}