.pragma library
Qt.include("../../configs/AxisDefine.js")
Qt.include("../../configs/IODefines.js")

var counterManager;

function init(cManager){
    counterManager = cManager;
}

function ActionDefineItem(name, decimal){
    this.item = name;
    this.decimal = decimal;
}

var extentPENQIANGAction = {
    "action":1000,
    "properties":[new ActionDefineItem("axis", 0),
        new ActionDefineItem("pos1", 3),
        new ActionDefineItem("pos2", 3),
        new ActionDefineItem("speed", 1),
        new ActionDefineItem("num", 0),
        new ActionDefineItem("delay",2)],
    "canTestRun":true,
    "canActionUsePoint": false,
    "editableItems":{"editor":Qt.createComponent("PENQIANEditor.qml"), "itemDef":{"item":"PENQIANEditor"}},
    "toStringHandler":function(actionObject){
        return qsTr("PENQIANG") + "-" + axisInfos[actionObject.axis].name + ":" +
                qsTr("Pos1:") + actionObject.pos1 + " " +
                qsTr("Pos2:") + actionObject.pos2 + " " +
                qsTr("Speed:") + actionObject.speed + " " +
                qsTr("Num:") + actionObject.num + " " +
                qsTr("Delay:") + actionObject.delay;
    },

};

var extentAnalogControlAction = {
    "action":250,
    "properties":[new ActionDefineItem("chanel", 0),
        new ActionDefineItem("analog", 1),
        new ActionDefineItem("delay", 1)
    ],
    "canTestRun":true,
    "canActionUsePoint": false,
    "editableItems":{"editor":Qt.createComponent("AnalogControlEditor.qml"), "itemDef":{"item":"AnalogControlEditor"}},
    "toStringHandler":function(actionObject){
        return qsTr("Analog Control") + "-" + actionObject.chanel + ":" +
                qsTr("Analog:") + actionObject.analog + " " +
                qsTr("Delay:") + actionObject.delay;
    }
};

var extentDeltaJumpAction = {
    "action":700,
    "properties":[
        new ActionDefineItem("xpos1", 3),
        new ActionDefineItem("ypos1", 3),
        new ActionDefineItem("zpos1", 3),
        new ActionDefineItem("upos1", 3),
        new ActionDefineItem("vpos1", 3),
        new ActionDefineItem("wpos1", 3),
        new ActionDefineItem("xpos2", 3),
        new ActionDefineItem("ypos2", 3),
        new ActionDefineItem("zpos2", 3),
        new ActionDefineItem("upos2", 3),
        new ActionDefineItem("vpos2", 3),
        new ActionDefineItem("wpos2", 3),
        new ActionDefineItem("lh", 3),
        new ActionDefineItem("mh", 3),
        new ActionDefineItem("rh", 3),
        new ActionDefineItem("speed", 1),
        new ActionDefineItem("delay", 1)
    ],
    "canTestRun":true,
    "canActionUsePoint": false,
    "editableItems":{"editor":Qt.createComponent("DeltaJumpEditor.qml"), "itemDef":{"item":"DeltaJumpEditor"}},
    "toStringHandler":function(actionObject){
        return qsTr("Delta Jumpl") + ":" + qsTr("start pos:")+
                axisInfos[0].name + ":" +actionObject.xpos1 + "," +
                axisInfos[1].name + ":" +actionObject.ypos1 + "," +
                axisInfos[2].name + ":" +actionObject.zpos1 + "," +
                axisInfos[3].name + ":" +actionObject.upos1 + "," +
                axisInfos[4].name + ":" +actionObject.vpos1 + "," +
                axisInfos[5].name + ":" +actionObject.wpos1 + "\n                            " +
                qsTr("LH:")+actionObject.lh+","+
                qsTr("MH:")+actionObject.mh+","+
                qsTr("RH:")+actionObject.rh+"\n                            "+
                qsTr("end pos:")+
                axisInfos[0].name + ":" +actionObject.xpos2 + "," +
                axisInfos[1].name + ":" +actionObject.ypos2 + "," +
                axisInfos[2].name + ":" +actionObject.zpos2 + "," +
                axisInfos[3].name + ":" +actionObject.upos2 + "," +
                axisInfos[4].name + ":" +actionObject.vpos2 + "," +
                axisInfos[5].name + ":" +actionObject.wpos2 + "\n                            " +
                qsTr("speed:") + actionObject.speed + " " +
                qsTr("Delay:") + actionObject.delay;
    }
};

var extentSafeRangeAction = {
    "action":550,
    "properties":[
        new ActionDefineItem("para1", 0),
        new ActionDefineItem("pos1", 0),
        new ActionDefineItem("pos2", 0),
        new ActionDefineItem("lpos1", 0),
        new ActionDefineItem("lpos2", 0),
        new ActionDefineItem("aid", 0)
    ],
    "canTestRun":false,
    "canActionUsePoint": false,
    "editableItems":{"editor":Qt.createComponent("SafeRangeEditor.qml"), "itemDef":{"item":"SafeRangeEditor"}},
    "toStringHandler":function(actionObject){
        var id1 = actionObject.para1&0xf;
        var id2 = (actionObject.para1>>4)&0xf;
        var allow = (actionObject.para1>>8)&1;
        var type = (actionObject.para1>>9)&1;
        var coor = (actionObject.para1>>10)&1;
        var whenChangeType = actionObject.para1 >> 11;
        return qsTr("Safe Control") + ":" + qsTr("if") + " " + axisInfos[id1].name + (allow ? qsTr("out pos fange:") : qsTr("in pos fange:") ) +
                "("+actionObject.pos1+"," +actionObject.pos2+")"+"\n                            " +
                axisInfos[id2].name+ " " + (whenChangeType ? qsTr("When Changed") :
                qsTr("out pos fange:") +"("+actionObject.lpos1+"," +actionObject.lpos2+")" ) +"\n                            " +
                qsTr("will alarm:") + actionObject.aid;
    },
    "actionObjectChangedHelper":function(editor, actionObject){
    }
};

var extentSingleStackAction = {
    "action":301,
    "properties":[new ActionDefineItem("startPos", 3),
        new ActionDefineItem("space", 3),
        new ActionDefineItem("count", 0),
        new ActionDefineItem("speed", 1),
        new ActionDefineItem("configs", 0)
    ],
    "canTestRun":true,
    "canActionUsePoint": true,
    "pointsReplace":function(generatedAction){
        var pts = generatedAction.points;
        if(pts.length == 0) return;
        generatedAction.startPos = pts[0].pos["m" + (generatedAction.configs & 0x1F)];
    },

    "hasCounter":true,
    "getCountersID":function(actionObject){
        return [actionObject.configs >> 17];
    },

    "editableItems":{"editor":Qt.createComponent("SingleStackAction.qml"), "itemDef":{"item":"SingleStackAction"}},
    "toStringHandler":function(actionObject){
        var configs = actionObject.configs;
        var axisID = configs & 0x1F;
        var dir = (configs >> 5) & 1;
        var bindingCounter = (configs >> 16) & 1;
        var counterID = (configs >>17);
        var points = (actionObject.points == undefined ? [] : actionObject.points);
        var startPos = actionObject.startPos;
        var isAddr = (configs >> 8) & 0xFF;
        if(points.length !== 0){
            startPos = points[0].pointName + "(" + points[0].pos["m" + axisID] + ")";
        }

        return qsTr("Single Stack") + "-" +  axisInfos[axisID].name + ":" + (dir == 0 ? qsTr("RP") : qsTr("PP")) + " " +
                qsTr("Start Pos:") + startPos + " " +
                qsTr("space:") + (isAddr ? qsTr("Addr:") : "") + actionObject.space + " " + qsTr("count:") + actionObject.count + "\n                            " +
                (bindingCounter ? counterManager.counterToString(counterID, true) :  qsTr("Counter:Self")) + " " +
                qsTr("speed:") + actionObject.speed;
    }
};

var extentSwitchCoordAction = {
        "action":800,
        "properties":[new ActionDefineItem("coordID", 0)],
        "canTestRun":false,
        "canActionUsePoint": false,
        "editableItems":{"editor":Qt.createComponent("SwitchCoordEditor.qml"), "itemDef":{"item":"SwitchCoordEditor"}},
        "toStringHandler":function(actionObject){
            return qsTr("Switch Coord") + ":" + qsTr("CoordID") + actionObject.coordID;
        }
    };

var speedAction = {
        "action":16,
        "properties":[new ActionDefineItem("startSpeed", 1),
                    new ActionDefineItem("endSpeed", 1)],
        "canTestRun":false,
        "canActionUsePoint": false,
        "editableItems":{"editor":Qt.createComponent("../SpeedActionEditor.qml"), "itemDef":{"item":"SpeedActionEditor"}},
        "toStringHandler":function(actionObject){
            return qsTr("Path Speed:") + " " + qsTr("Start Speed:") + actionObject.startSpeed + " " + qsTr("End Speed:") + actionObject.endSpeed;
        }
    };

var extentSingleMemposAction = {
        "action":24,
        "properties":[new ActionDefineItem("id", 0),
        new ActionDefineItem("tpos", 3),
        new ActionDefineItem("speed", 1),
        new ActionDefineItem("delay", 2),
        new ActionDefineItem("stopEn", 0),
        new ActionDefineItem("point", 0),
        new ActionDefineItem("pStatus", 0),
        new ActionDefineItem("immStop", 0),
        new ActionDefineItem("devPos", 0),
        new ActionDefineItem("devLen", 3),
        new ActionDefineItem("decSpeed", 1),
        new ActionDefineItem("memAddr", 0),],
        "canTestRun":false,
        "canActionUsePoint": false,
        "editableItems":{"editor":Qt.createComponent("AxisMemposEditor.qml"), "itemDef":{"item":"AxisMemposEditor"}},
        "toStringHandler":function(actionObject){
            var ret =  axisInfos[actionObject.id].name + ":";
            ret +=  (actionObject.tpos == ""?0:actionObject.tpos);
            ret +=  " " + qsTr("Speed:") + actionObject.speed + " " +
                    qsTr("Delay:") + actionObject.delay;
            ret += "\n                            ";
            ret += " " + qsTr("Early dec dev len:") + actionObject.devLen;
            ret += " " + qsTr("dev pos:") + actionObject.devPos;
            ret += " " + qsTr("Early dec Spd:") + actionObject.decSpeed;
            ret += " " + qsTr("mem addr:") + actionObject.memAddr;
            if(actionObject.stopEn){
                ret += "\n                            ";
                ret += " " + qsTr("When ") + ioItemName(xDefines[actionObject.point]) + " " + (actionObject.pStatus == 1? qsTr("is Off"):qsTr("is On"));
                ret += " " + (actionObject.immStop == 0 ? qsTr("slow stop") : qsTr("fast stop"));
            }
            return ret;
        }
    };


var extentActions = [extentPENQIANGAction,
                     extentAnalogControlAction,
                     extentDeltaJumpAction,
                     extentSafeRangeAction,
                     extentSingleStackAction,
                     extentSwitchCoordAction,
                     speedAction,
                     extentSingleMemposAction];
