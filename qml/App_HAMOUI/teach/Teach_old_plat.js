.pragma library

Qt.include("../../utils/HashTable.js")
Qt.include("../../utils/stringhelper.js")

var actHelper = 0;
var actions = {

};
actions.ACT_GS8 = actHelper++;
actions.ACT_GS1 = actHelper++;
actions.ACT_GS2 = actHelper++;
actions.ACT_GS3 = actHelper++;
actions.ACT_GS4 = actHelper++;
actions.ACT_GS5 = actHelper++;
actions.ACT_GS6 = actHelper++;
actions.ACT_GS7 = actHelper++;

actions.ACT_PS2_1 = actHelper++;
actions.ACT_PS2_2 = actHelper++;
actions.ACT_PS1_2 = actHelper++;
actions.ACT_PS1_1 = actHelper++;

actions.ACT_PS8_2 = actHelper++;
actions.ACT_PS8_1 = actHelper++;
actions.ACT_PS5_1 = actHelper++;
actions.ACT_PS5_2 = actHelper++;

actions.ACT_PS4_2 = actHelper++;
actions.ACT_PS4_1 = actHelper++;
actions.ACT_PS3_2 = actHelper++;
actions.ACT_PS3_1 = actHelper++;

actions.ACT_PS6_2 = actHelper++;
actions.ACT_PS6_1 = actHelper++;

actHelper = 27;
actions.ACT_OTHER      = actHelper++;
actions.ACT_CONDITION  = actHelper++;
actions.ACT_Wait       = actHelper++;
actions.ACT_CHECK      = actHelper++;
actions.ACT_PARALLEL   = actHelper++;
actions.ACT_END        = actHelper++;
actions.ACT_COMMENT    = actHelper;
actions.ACT_OUTPUT     = 0x80;
actions.ACT_SYNC_BEGIN = 126;
actions.ACT_SYNC_END   = 127;
actions.ACT_GROUP_END  = 125;
actions.ACT_FLAG       = 100;

var kCCErr_Invalid = 1;
var kCCErr_Sync_Nesting = 2;
var kCCErr_Sync_NoBegin = 3;
var kCCErr_Sync_NoEnd = 4;
var kCCErr_Group_Nesting = 5;
var kCCErr_Group_NoBegin = 6;
var kCCErr_Group_NoEnd = 7;
var kCCErr_Last_Is_Not_End_Action = 8;

var kAxisType_NoUse = 0;
var kAxisType_Servo = 1;
var kAxisType_Pneumatic = 2;
var kAxisType_Reserve = 3;

var generateAxisServoAction = function(action,
                                       pos,
                                       speed,
                                       delay,
                                       isBadEn,
                                       isEarlyEnd,
                                       earlyEndPos){
    return {
        "action":action,
        "pos": pos||0.00,
        "speed":speed||80,
        "delay":delay||0.00,
        "isBadEn":isBadEn||false,
        "isEarlyEnd":isEarlyEnd||false,
        "earlyEndPos":earlyEndPos||0.00
    };
}

var generateAxisPneumaticAction = function(action,delay){
    return {
        "action":action,
        "delay": delay||0.00
    }
}

var generteEndAction = function(){
    return {
        "action":actions.ACT_END
    };
}

var generateWaitAction = function(which, status, limit){
    return {
        "action":actions.ACT_Wait,
        "point":which,
        "pointStatus":status,
        "limit":limit || 0.50
    };
}

var generateCheckAction = function(which, status, limit){
    return {
        "action":actions.ACT_CHECK,
        "point":which,
        "pointStatus":status,
        "limit":limit || 0.50
    };
}

var generateConditionAction = function(which, status, limit, flag){
    return {
        "action":actions.ACT_CONDITION,
        "point":which,
        "pointStatus":status,
        "limit":limit || 0.50,
        "flag": flag || 0,
    };
}

var generateFlagAction = function(flag,descr){
    return {
        "action":actions.ACT_FLAG,
        "flag":flag,
        "comment":descr
    };
}

var generateSyncBeginAction = function(){
    return {
        "action":actions.ACT_SYNC_BEGIN
    };
}

var generateSyncEndAction = function(){
    return {
        "action":actions.ACT_SYNC_END
    };
}

var generateOutputAction = function(point, status, delay){
    return {
        "action":actions.ACT_OUTPUT,
        "point":point,
        "pointStatus": status,
        "delay":delay
    };
}

var generateCommentAction = function(comment){
    return {
        "action": actions.ACT_COMMENT,
        "comment":comment
    };
}

var generateInitProgram = function(axisDefine){

    var initStep = [];
    initStep.push(generateSyncBeginAction());
    initStep.push(axisDefine.s8Axis == kAxisType_Reserve ? generateAxisServoAction(actions.ACT_GS8) :
                                                           generateAxisPneumaticAction(actions.ACT_PS8_1));
    var aT;
    for(var i = 1; i < 8; ++i){
        aT = axisDefine["s"+ i + "Axis"];
        if(aT == kAxisType_Servo){
            initStep.push(generateAxisServoAction(actions["ACT_GS" + i]));
        }else if(aT == kAxisType_Pneumatic){
            initStep.push(generateAxisPneumaticAction(actions["ACT_PS" + i + "_1"]));
        }
    }

    initStep.push(generateSyncEndAction());
    initStep.push(generateWaitAction(1));
    initStep.push(generteEndAction());

    return JSON.stringify(initStep);

}

var gsActionToStringHelper = function(actionStr, actionObject){
    var ret =  actionStr + ":" +  actionObject.pos + " " +
            qsTr("Speed:") + actionObject.speed + " " +
            qsTr("Delay:") + actionObject.delay;
    if(actionObject.isBadEn)
        ret += " " + qsTr("Bad En");
    if(actionObject.isEarlyEnd){
        ret += " " + qsTr("Early End Pos:") + actionObject.earlyEndPos;
    }
    return ret;
}

var psActionToStringHelper = function(actionStr, actionObject){
    var ret =  actionStr + " " +
            qsTr("Delay:") + actionObject.delay;
    return ret;
}

var gs1ToStringHandler = function(actionObject){
    return gsActionToStringHelper(qsTr("X1"), actionObject);
}


var gs2ToStringHandler = function(actionObject){
    return gsActionToStringHelper(qsTr("Y1"), actionObject);
}

var gs3ToStringHandler = function(actionObject){
    return gsActionToStringHelper(qsTr("Z"), actionObject);
}

var gs4ToStringHandler = function(actionObject){
    return gsActionToStringHelper(qsTr("X2"), actionObject);

}

var gs5ToStringHandler = function(actionObject){
    return gsActionToStringHelper(qsTr("Y2"), actionObject);

}

var gs6ToStringHandler = function(actionObject){
    return gsActionToStringHelper(qsTr("A"), actionObject);
}

var gs7ToStringHandler = function(actionObject){
    return gsActionToStringHelper(qsTr("B"), actionObject);

}

var gs8ToStringHandler = function(actionObject){
    return gsActionToStringHelper(qsTr("C"), actionObject);
}

var ps1_1ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("X1 OFF"), actionObject)
}
var ps1_2ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("X1 ON"), actionObject)

}

var ps2_1ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("Y1 OFF"), actionObject)

}
var ps2_2ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("Y1 ON"), actionObject)

}

var ps3_1ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("Z OFF"), actionObject)

}
var ps3_2ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("Z ON"), actionObject)

}

var ps4_1ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("X2 OFF"), actionObject)

}
var ps4_2ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("X2 ON"), actionObject)

}

var ps5_1ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("A OFF"),actionObject)

}
var ps5_2ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("A ON"),actionObject)

}

var ps6_1ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("B OFF"), actionObject)

}
var ps6_2ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("B ON"), actionObject)
}

var ps8_1ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("C OFF"), actionObject)
}
var ps8_2ToStringHandler = function(actionObject){
    return psActionToStringHelper(qsTr("C ON"), actionObject)

}

var otherActionToStringHandler = function(actionObject){

}

var conditionActionToStringHandler = function(actionObject){
    return qsTr("IF:") + actionObject.point +
            (actionObject.pointStatus ? qsTr("ON") : qsTr("OFF")) + " "
            + qsTr("Limit:") + actionObject.limit + " " +
            qsTr("Go to flag") +"[" + actionObject.flag + "]";
}

var waitActionToStringHandler = function(actionObject){
    return qsTr("Wait:") + actionObject.point +
            (actionObject.pointStatus ? qsTr("ON") : qsTr("OFF")) + " " +
                                       qsTr("Limit:") + actionObject.limit;
}

var checkActionToStringHandler = function(actionObject){
    return qsTr("Check:") + actionObject.point +
            (actionObject.pointStatus ? qsTr("ON") :qsTr("OFF")) + " " +
            qsTr("Limit:") + actionObject.limit;
}

var parallelActionToStringHandler = function(actionObject){

}

var endActionToStringHandler = function(actionObject){
    return qsTr("End");
}

var commentActionToStringHandler = function(actionObject){
    return qsTr("Comment:") + actionObject.comment;
}

var flagActionToStringHandler = function(actionObject){
    return qsTr("Flag") + icStrformat("[{0}]", actionObject.flag) + ":"
            + actionObject.comment;
}

var outputActionToStringHandler = function(actionObject){
    return qsTr("Output:") + actionObject.point + (actionObject.pointStatus ? qsTr("ON") :qsTr("OFF")) + " "
            + qsTr("Delay:") + actionObject.delay;
}

var syncBeginActionToStringHandler = function(actionObject){
    return qsTr("Sync Begin");
}

var syncEndActionToStringHandler = function(actionObject){
    return qsTr("Sync End");
}



var actionToStringHandlerMap = new HashTable();
actionToStringHandlerMap.put(actions.ACT_GS8, gs8ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_GS1, gs1ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_GS2, gs2ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_GS3, gs3ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_GS4, gs4ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_GS5, gs5ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_GS6, gs6ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_GS7, gs7ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS1_1, ps1_1ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS1_2, ps1_2ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS2_1, ps2_1ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS2_2, ps2_2ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS3_1, ps3_1ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS3_2, ps3_2ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS4_1, ps4_1ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS4_2, ps4_2ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS5_1, ps5_1ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS5_2, ps5_2ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS6_1, ps6_1ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS6_2, ps6_2ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS8_1, ps8_1ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PS8_2, ps8_2ToStringHandler);
actionToStringHandlerMap.put(actions.ACT_OTHER, otherActionToStringHandler);
actionToStringHandlerMap.put(actions.ACT_CONDITION, conditionActionToStringHandler);
actionToStringHandlerMap.put(actions.ACT_Wait, waitActionToStringHandler);
actionToStringHandlerMap.put(actions.ACT_CHECK, checkActionToStringHandler);
actionToStringHandlerMap.put(actions.ACT_PARALLEL, parallelActionToStringHandler);
actionToStringHandlerMap.put(actions.ACT_END, endActionToStringHandler);
actionToStringHandlerMap.put(actions.ACT_COMMENT, commentActionToStringHandler);
actionToStringHandlerMap.put(actions.ACT_OUTPUT, outputActionToStringHandler);
actionToStringHandlerMap.put(actions.ACT_SYNC_BEGIN, syncBeginActionToStringHandler);
actionToStringHandlerMap.put(actions.ACT_SYNC_END, syncEndActionToStringHandler);
actionToStringHandlerMap.put(actions.ACT_FLAG, flagActionToStringHandler);



var actionToString = function(actionObject){
    var  toStrHandler = actionToStringHandlerMap.get(actionObject.action);
    if(toStrHandler === undefined) {console.log(actionObject.action)}
    return toStrHandler(actionObject);
}

function ProgramModelItem(actionObject){
    this.actionObject = actionObject;
    this.commentedObject = actionObject;
}

function ccErrnoToString(errno){
    switch(errno){
    case -1:
        return qsTr("Sub program is out of ranged");
    case kCCErr_Invalid:
        return qsTr("Invalid program");
    case kCCErr_Group_NoBegin:
        return qsTr("Has not Group-Begin action but has Group-End action");
    case kCCErr_Group_Nesting:
        return qsTr("Group action is nesting");
    case kCCErr_Group_NoEnd:
        return qsTr("Has Group-Begin action but has not Group-End action");
    case kCCErr_Sync_NoBegin:
        return qsTr("Has not Sync-Begin action but has Sync-End action");
    case kCCErr_Sync_Nesting:
        return qsTr("Sync action is nesting");
    case kCCErr_Sync_NoEnd:
        return qsTr("Has Sync-Begin action but has not Sync-End action");
    case kCCErr_Last_Is_Not_End_Action:
        return qsTr("Last action is not End action");
    }
    return qsTr("Unknow Error");
}

var flags = [];
var pushFlag = function(flag){
    for(var i = 0; i < flags.length; ++i){
        if(flag < flags[i]){
            flags.splice(i, 0, flag);
            return;
        }
    }
    flags.push(flag);
    return;
}

var delFlag = function(flag){
    for(var i = 0; i < flags.length; ++i){
        if(flag === flags[i]){
            flags.splice(i, 1);
            break;
        }
    }
}

var useableFlag = function(){
    if(flags.length === 0) return 0;
    if(flags.length < 3)
        return flags[flags.length - 1] + 1;
    if(flags[0] != 0) return 0;
    for(var i = 1; i < flags.length; ++i){
        if(flags[i] - flags[i - 1] > 1){
            return flags[i - 1] + 1;
        }
    }
    return flags[i - 1] + 1;
}
