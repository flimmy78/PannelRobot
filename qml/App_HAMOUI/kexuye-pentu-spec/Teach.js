.pragma library

Qt.include("../teach/Teach.js")
Qt.include("../configs/AxisDefine.js")
actions.F_CMD_PENTU = 70000;

var pentuModes = {

}
pentuModes.LineU2DRepeat = 0;
pentuModes.LineZ2DRepeat = 1;
pentuModes.LineSaw2DRepeat = 2;
pentuModes.LineDir2DRepeat = 3;

pentuModes.ArcU3DRepeat = 4;
pentuModes.ArcZ3DRepeat = 5;
pentuModes.ArcSaw3DRepeat = 6;
pentuModes.ArcDir3DRepeat = 7;
pentuModes.DIYAction = 8;
pentuModes.LineCycle = 9;

var generatePENTUAction = function(mode, plane, startPos, startPosSpeed0, startPosSpeed1,
                                   startPosSpeed2, startPosSpeed3, startPosSpeed4, startPosSpeed5,
                                   repeatSpeed, repeateCount, zlength, dirAxis, dirLength, dirSpeed,
                                   dirCount, point1, point2, rotate, rotateSpeed, rotateCount,
                                   fixtureDelay0, fixtureDelay1, fixtureDelay2, rcID, dirCID, rotateCID,
                                   fixture2Delay0, fixture2Delay1, fixture2Delay2, fixture1Switch, fixture2Switch,
                                   slope, gunFollowEn,aaaa,bbbb,editaction,
                                   useStack,useDeviation,turns,stackSpeed,xdeviation,ydeviation,
                                   zdeviation,xspace,yspace,zspace,xcount,ycount,
                                   zcount,xdirection,ydirection,zdirection,stack1,isGunBack,
                                   gun1use0,gun1use1,gun1use2,gun2use0,gun2use1,gun2use2,forward,
                                   isRotateCycle,turnOver){
//    var f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag0 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag1 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag2 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag3 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag4 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag5 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag6 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag7 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag8 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag9 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag10 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag11 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag12 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag13 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag14 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag15 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag16 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag17 = f.flagID;
//    f = flagsDefine.createFlag(0, "");
//    flagsDefine.pushFlag(0, f);
//    var flag18 = f.flagID;
//    if(mode == 0){

    var rpeateAxis = 0;
    var startPos0 = startPos.pos.m0;
    var startPos1 = startPos.pos.m1;
    var startSpeed0 = startPosSpeed0;
    var startSpeed1 = startPosSpeed1;
    var point1_m0 = point1.pos.m0;
    var point1_m1 = point1.pos.m1;
    var deepAxis = 1;
    var startPos2 = startPos.pos.m2;
    var startSpeed2 = startPosSpeed2;
//    switch(plane){
//        case 0:
//            if(dirAxis == 0){
//                var rpeateAxis = 1;
//                var startPos0 = startPos.pos.m1;
//                var startPos1 = startPos.pos.m0;
//                var startSpeed0 = startPosSpeed1;
//                var startSpeed1 = startPosSpeed0;
//                var point1_m0 = point1.pos.m1;
//                var point1_m1 = point1.pos.m0;
//            }
//            else if(dirAxis == 1){
//                rpeateAxis = 0;
//                startPos0 = startPos.pos.m0;
//                startPos1 = startPos.pos.m1;
//                startSpeed0 = startPosSpeed0;
//                startSpeed1 = startPosSpeed1;
//                point1_m0 = point1.pos.m0;
//                point1_m1 = point1.pos.m1;
//            }
//            var deepAxis = 2;
//            var startPos2 = startPos.pos.m2;
//            var startSpeed2 = startPosSpeed2;
//            break;
//        case 1:
//            if(dirAxis == 0){
//                rpeateAxis = 2;
//                startPos0 = startPos.pos.m2;
//                startPos1 = startPos.pos.m0;
//                startSpeed0 = startPosSpeed2;
//                startSpeed1 = startPosSpeed0;
//                point1_m0 = point1.pos.m2;
//                point1_m1 = point1.pos.m0;
//            }
//            else {
//                rpeateAxis = 0;
//                startPos0 = startPos.pos.m0;
//                startPos1 = startPos.pos.m2;
//                startSpeed0 = startPosSpeed0;
//                startSpeed1 = startPosSpeed2;
//                point1_m0 = point1.pos.m0;
//                point1_m1 = point1.pos.m2;
//            }
//            deepAxis = 1;
//            startPos2 = startPos.pos.m1;
//            startSpeed2 = startPosSpeed1;
//            break;
//        case 2:
//            if(dirAxis == 1){
//                rpeateAxis = 2;
//                startPos0 = startPos.pos.m2;
//                startPos1 = startPos.pos.m1;
//                startSpeed0 = startPosSpeed2;
//                startSpeed1 = startPosSpeed1;
//                point1_m0 = point1.pos.m2;
//                point1_m1 = point1.pos.m1;
//            }
//            else {
//                rpeateAxis = 1;
//                startPos0 = startPos.pos.m1;
//                startPos1 = startPos.pos.m2;
//                startSpeed0 = startPosSpeed1;
//                startSpeed1 = startPosSpeed2;
//                point1_m0 = point1.pos.m1;
//                point1_m1 = point1.pos.m2;
//            }
//            deepAxis = 0;
//            startPos2 = startPos.pos.m0;
//            startSpeed2 = startPosSpeed0;
//            break;
//    }

//    }
//    if(mode == 1){
//        switch(plane){
//            case 0:
//                if(dirAxis == 0){
//                    rpeateAxis = 1;
//                    startPos0 = startPos.pos.m1;
//                    startPos1 = startPos.pos.m0;
//                    startSpeed0 = startPosSpeed1;
//                    startSpeed1 = startPosSpeed0;
//                    point1_m0 = point1.pos.m1;
//                    point1_m1 = point1.pos.m0;
//                }
//                else if(dirAxis == 1){
//                    rpeateAxis = 0;
//                    startPos0 = startPos.pos.m0;
//                    startPos1 = startPos.pos.m1;
//                    startSpeed0 = startPosSpeed0;
//                    startSpeed1 = startPosSpeed1;
//                    point1_m0 = point1.pos.m0;
//                    point1_m1 = point1.pos.m1;
//                }
//                deepAxis = 2;
//                startPos2 = startPos.pos.m2;
//                startSpeed2 = startPosSpeed2;
//                break;
//            case 1:
//                if(dirAxis == 0){
//                    rpeateAxis = 1;
//                    startPos0 = startPos.pos.m1;
//                    startPos1 = startPos.pos.m0;
//                    startSpeed0 = startPosSpeed1;
//                    startSpeed2 = startPosSpeed0;
//                }
//                else {
//                    rpeateAxis = 0;
//                    startPos0 = startPos.pos.m0;
//                    startPos1 = startPos.pos.m1;
//                    startSpeed0 = startPosSpeed0;
//                    startSpeed1 = startPosSpeed1;
//                }
//                deepAxis = 2;
//                startPos2 = startPos.pos.m2;
//                startSpeed2 = startPosSpeed2;
//                break;
//            case 2:
//                if(dirAxis == 1){
//                    rpeateAxis = 2;
//                    startPos1 = startPos.pos.m1;
//                    startPos2 = startPos.pos.m0;
//                    startSpeed1 = startPosSpeed1;
//                    startSpeed2 = startPosSpeed0;
//                }
//                else {
//                    rpeateAxis = 1;
//                    startPos1 = startPos.pos.m0;
//                    startPos2 = startPos.pos.m1;
//                    startSpeed1 = startPosSpeed0;
//                    startSpeed2 = startPosSpeed1;
//                }
//                deepAxis = 0;
//                startPos0 = startPos.pos.m2;
//                startSpeed0 = startPosSpeed2;
//                break;
//        }
//    }
    return {
        "action":actions.F_CMD_PENTU,
        "mode":mode,
        "plane":plane,
        "rpeateAxis":rpeateAxis,
        "deepAxis":deepAxis,
        "startPos":startPos,
        "startPos0":startPos0,
        "startPos1":startPos1,
        "startPos2":startPos2,
        "repeateSpeed":repeatSpeed,
        "repeateCount":repeateCount,
        "zlength":zlength,
        "repeateCounterID":rcID,
        "dirAxis":dirAxis,
        "dirLength":dirLength,
        "dirSpeed":dirSpeed,
        "dirCount":dirCount,
        "dirCounterID":dirCID,
        "point1":point1,
        "point2":point2,
        "point1_m0":point1_m0,
        "point1_m1":point1_m1,
        "rotate":rotate,
        "rotateSpeed":rotateSpeed,
        "rotateCount":rotateCount,
        "rotateCounterID":rotateCID,
//        "flag0":flag0,
//        "flag1":flag1,
//        "flag2":flag2,
//        "flag3":flag3,
//        "flag4":flag4,
//        "flag5":flag5,
//        "flag6":flag6,
//        "flag7":flag7,
//        "flag8":flag8,
//        "flag9":flag9,
//        "flag10":flag10,
//        "flag11":flag11,
//        "flag12":flag12,
//        "flag13":flag13,
//        "flag14":flag14,
//        "flag15":flag15,
//        "flag16":flag16,
//        "flag17":flag17,
//        "flag18":flag18,
        "flag0":0,
        "flag1":0,
        "flag2":0,
        "flag3":0,
        "flag4":0,
        "flag5":0,
        "flag6":0,
        "flag7":0,
        "flag8":0,
        "flag9":0,
        "flag10":0,
        "flag11":0,
        "flag12":0,
        "flag13":0,
        "flag14":0,
        "flag15":0,
        "flag16":0,
        "flag17":0,
        "flag18":0,
        "flag19":0,
        "flag20":0,
        "flag21":0,
        "flag22":0,
        "flag23":0,
        "flag24":0,
        "flag25":0,
        "startPosSpeed0":startPosSpeed0,
        "startPosSpeed1":startPosSpeed1,
        "startPosSpeed2":startPosSpeed2,
        "startPosSpeed3":startPosSpeed3,
        "startPosSpeed4":startPosSpeed4,
        "startPosSpeed5":startPosSpeed5,
//        "fixtureDelay0":fixtureDelay0,
//        "fixtureDelay1":fixtureDelay1,
//        "fixtureDelay2":fixtureDelay2,

        "startSpeed0":startSpeed0,
        "startSpeed1":startSpeed1,
        "startSpeed2":startSpeed2,
        "startSpeed3":startPosSpeed3,
        "startSpeed4":startPosSpeed4,
        "startSpeed5":startPosSpeed5,
        "fixtureDelay0":fixtureDelay0,
        "fixtureDelay1":fixtureDelay1,
        "fixtureDelay2":fixtureDelay2,
        "fixture2Delay0":fixtureDelay0,
        "fixture2Delay1":fixtureDelay1,
        "fixture2Delay2":fixtureDelay2,
        "fixture1Switch":fixture1Switch,
        "fixture2Switch":fixture2Switch,
        "turnOver":turnOver,
        "slope":slope,
        "gunFollowEn":gunFollowEn,
        "aaaa":aaaa,
        "bbbb":bbbb,
        "editaction":editaction,
        "isGunBack":isGunBack,
        "forward":forward,
        "isRotateCycle":isRotateCycle,

//        stack:
        "useStack":useStack,
        "useDeviation":useDeviation,
        "turns":turns,
        "stackSpeed":stackSpeed,
        "xdeviation":xdeviation,
        "ydeviation":ydeviation,
        "zdeviation":zdeviation,
        "xspace":xspace,
        "yspace":yspace,
        "zspace":zspace,
        "xcount":xcount,
        "ycount":ycount,
        "zcount":zcount,
        "xdirection":xdirection,
        "ydirection":ydirection,
        "zdirection":zdirection,
        "stack1":stack1,
        "gun1use0":gun1use0,
        "gun1use1":gun1use1,
        "gun1use2":gun1use2,
        "gun2use0":gun2use0,
        "gun2use1":gun2use1,
        "gun2use2":gun2use2,
    };
}

var pentuActionToStringHandler = function(actionObject){
    var mode = actionObject.mode;
    var ret = "";
    if(mode == pentuModes.LineU2DRepeat)
        ret += qsTr("LineU2DRepeat");
    else if(mode == pentuModes.LineZ2DRepeat)
        ret += qsTr("LineZ2DRepeat");
    else if(mode == pentuModes.LineSaw2DRepeat)
        ret += qsTr("LineSaw2DRepeat");
    else if(mode == pentuModes.LineDir2DRepeat)
        ret += qsTr("LineDir2DRepeat");
    else if(mode == pentuModes.ArcU3DRepeat)
        ret += qsTr("ArcU3DRepeat");
    else if(mode == pentuModes.ArcZ3DRepeat)
        ret += qsTr("ArcZ3DRepeat");
    else if(mode == pentuModes.ArcSaw3DRepeat)
        ret += qsTr("ArcSaw3DRepeat");
    else if(mode == pentuModes.ArcDir3DRepeat)
        ret += qsTr("ArcDir3DRepeat");
    else if(mode == pentuModes.DIYAction)
        ret += qsTr("DIYAction");
    else if(mode == pentuModes.LineCycle)
        ret += qsTr("LineCycle");
//    ret += " ";
//    if(mode !== pentuModes.DIYAction){
//        if(actionObject.plane == 0)
//            ret += "XY " + qsTr("Plane");
//        else if(actionObject.plane == 1)
//            ret += "XZ " + qsTr("Plane");
//        else if(actionObject.plane == 2)
//            ret += "YZ " + qsTr("Plane");
//    }
    ret += " :: ";
    ret += qsTr("Start Pos:") + pointToString(actionObject.startPos) + "\n                            ";

    ret += qsTr("Next Pos:") + pointToString(actionObject.point1) + " ";
//    if(mode == pentuModes.Arc3DRepeat)
//        ret += qsTr("End Pos:") + pointToString(actionObject.point2) + " ";
    ret += qsTr("Repeate Speed:") + actionObject.repeateSpeed;
//    ret += qsTr("Repeate Speed:") + actionObject.repeateSpeed + " " +
//            qsTr("Repeate ") + actionObject.repeateCount + qsTr("Times") + "\n                            " +
//            axisInfos[actionObject.dirAxis].name + qsTr("Dir Length:") + actionObject.dirLength + " " +
//            qsTr("Dir Speed:") + actionObject.dirSpeed + " " +
//            qsTr("Dir") + actionObject.dirCount + qsTr("Times");
    return ret;
}