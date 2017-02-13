import QtQuick 1.1
import "../../ICCustomElement"
import "../configs/AxisDefine.js" as AxisDefine
import "../configs/IOConfigs.js" as IOConfigs
import "../configs/IODefines.js" as IODefines
import "../configs/Keymap.js" as Keymap

Item {
    id:root
    property int currentTest: -1
    property variant sentPulseAddrs: ["c_ro_0_32_3_900","c_ro_0_32_3_904",
        "c_ro_0_32_3_908", "c_ro_0_32_3_912","c_ro_0_32_3_916", "c_ro_0_32_3_920", "c_ro_0_32_3_924", "c_ro_0_32_3_928"
    ]
    property variant receivedPulseAddrs: ["c_ro_0_32_0_901", "c_ro_0_32_0_905",
        "c_ro_0_32_0_909","c_ro_0_32_0_913","c_ro_0_32_0_917","c_ro_0_32_0_921", "c_ro_0_32_0_925", "c_ro_0_32_0_929"]
    width: parent.width
    height: parent.height
    function startTest(index){
        debugItems.setProperty(index,"status",-1);
        currentTest = index;
    }
    function testResult(index,st){
        debugItems.setProperty(index,"status",st);
    }
    function testStop(){
        if(currentTest >=0){
            refreshTimer.testDelay = 0;
            debugItems.setProperty(currentTest,"status",-2);
        }
    }
    function setErrTip(index,tip){
        debugItems.setProperty(index,"errTip",tip);
    }


    Item {
        id: reserve
        width: parent.width-5
        height: 100
        Text {
            id: debugArea
        }
        ICButton{
            id:testBegin
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            radius: height >> 1
            text:qsTr("StartTest")
            bgColor:"green"
            textColor: "white"
            onButtonClicked: {
                if(testBegin.bgColor == "green"){
                    debugItems.clear();
                    var axisNum = panelRobotController.getConfigValue("s_rw_16_6_0_184");
                    for(var i=0;i<axisNum;++i){
                        if(AxisDefine.axisInfos[i].visiable === true){
                            debugItems.append({"type":"axisATest","id":i,"descr":qsTr("motor")+AxisDefine.axisInfos[i].name +qsTr("+test"),"status":-2,"errTip":""});
                            debugItems.append({"type":"axisDTest","id":i,"descr":qsTr("motor")+AxisDefine.axisInfos[i].name +qsTr("-test"),"status":-2,"errTip":""});
                        }
                    }
                    var yDefines = IOConfigs.teachSingleY;
                    for(var j=0;j<yDefines.length;++j){
                        debugItems.append({"type":"singleYOnTest","id":yDefines[j],"descr":qsTr("singleY")+ IODefines.getValveItemFromValveName(yDefines[j]).descr+qsTr("onTest"),"status":-2,"errTip":""});
                        debugItems.append({"type":"singleYOffTest","id":yDefines[j],"descr":qsTr("singleY")+ IODefines.getValveItemFromValveName(yDefines[j]).descr+qsTr("offTest"),"status":-2,"errTip":""});
                    }
                    yDefines = IOConfigs.teachHoldDoubleY;
                    for(var k=0;k<yDefines.length;++k){
                        debugItems.append({"type":"HoldDoubleYOnTest","id":yDefines[k],"descr":qsTr("HoldDoubleY")+ IODefines.getValveItemFromValveName(yDefines[k]).descr+qsTr("onTest"),"status":-2,"errTip":""});
                        debugItems.append({"type":"HoldDoubleYOffTest","id":yDefines[k],"descr":qsTr("HoldDoubleY")+ IODefines.getValveItemFromValveName(yDefines[k]).descr+qsTr("offTest"),"status":-2,"errTip":""});
                    }
                    if(debugItems.count === 0)return;
                    text = qsTr("StopTest")
                    bgColor = "red"
                    refreshTimer.singleMode =0;
                    startTest(0);
                }
                else if(testBegin.bgColor == "red"){
                    testStop();
                    text = qsTr("StartTest")
                    bgColor = "green"
                    currentTest = -1;
                }
            }
        }
    }
    ListModel{
        id:debugItems
    }
    ICListView{
        id:debugView
        border.color:"black"
        border.width: 1
        anchors.top:reserve.bottom
        width: parent.width-5
        height: parent.height - reserve.height -10
        spacing: 2
        clip: true
        model: debugItems
        delegate: Rectangle{
            id:item
            width: debugView.width
            height: itemDescr.height + 12
            color: ListView.isCurrentItem? "lightsteelblue":"white"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    debugView.currentIndex = index;
                }
            }
            Text {
                id: itemDescr
                anchors.verticalCenter: parent.verticalCenter
                text: descr
            }
            Row{
                id: itemStatus
                spacing: 4
                anchors.right: parent.right
                anchors.rightMargin: 10
                height: parent.height
                Text{
                    id:tip
                    visible: status === 0
                    anchors.verticalCenter: parent.verticalCenter
                    color: "red"
                    text:errTip
                }
                Text {
                    id: itemStatusSignal
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize:16
                    text:{
                        if(status === -1){
                            return "○";
                        }
                        else if(status === 0){
                            return "x";
                        }
                        else if(status === 1){
                            return "√";
                        }
                        else{
                            return "";
                        }
                    }
                    color: {
                        if(status === -1){
                            return "black";
                        }
                        else if(status === 0){
                            return "red";
                        }
                        else if(status === 1){
                            return "green";
                        }
                        else{
                           return "black";
                        }
                    }
                }
                ICButton{
                    id:redebug
                    visible: status === 0
                    height: parent.height-2
                    width: (height << 1) + 10
                    text: qsTr("ReTest")
                    enabled: testBegin.bgColor == "green"
                    onButtonClicked:{
                        refreshTimer.singleMode = 1;
                        testStop();
                        startTest(index);
                    }
                }
            }
        }
    }

    onCurrentTestChanged: {
        if(currentTest === -1) return;
        if(debugItems.get(currentTest).status === -1){
            var type = debugItems.get(currentTest).type;
            var id = debugItems.get(currentTest).id;
            switch(type){
            case "axisATest":{
                panelRobotController.setMotorTestPulseNum(10000);
                panelRobotController.sendKeyCommandToHost(Keymap.CMD_TEST_JOG_PX + id);
            }break;
            case "axisDTest":{
                panelRobotController.setMotorTestPulseNum(10000);
                panelRobotController.sendKeyCommandToHost(Keymap.CMD_TEST_JOG_NX + id);
            }break;
            case "singleYOnTest":
            case "singleYOffTest":
            case "HoldDoubleYOnTest":
            case "HoldDoubleYOffTest":{
                var toSend = JSON.stringify(IODefines.getValveItemFromValveName(id));
                var st;
                if(type === "singleYOnTest" || type === "HoldDoubleYOnTest"){
                    st = 1;
                }else{
                    st = 0;
                }
                panelRobotController.setYStatus(toSend, st);
            }break;
            default:break;
            }
        }
    }

    Timer{
        id:refreshTimer
        property int testDelay: 0
        property int sDelay: 0
        property int rDelay: 0
        property int singleMode: 0
        interval: 50;repeat:true;running: visible
        onTriggered: {
            if(currentTest >=0 && currentTest < debugItems.count){
                if(debugItems.get(currentTest).status === -1){
                    var type = debugItems.get(currentTest).type;
                    var id = debugItems.get(currentTest).id;
                    var pulseSent,pulseReceived;
                    switch(type){
                    case "axisATest":
                    case "axisDTest":{
                        var tmp;
                        pulseSent = panelRobotController.statusValue(sentPulseAddrs[id]);
                        pulseReceived = panelRobotController.statusValue(receivedPulseAddrs[id]);
                        debugArea.text ="id:"+id+" R:"+pulseReceived+" S:"+pulseSent;
                        if(type==="axisDTest") tmp =-10000;
                        else tmp =10000;
                        if(Math.abs(pulseSent-tmp)<10){
                            rDelay = 0;
                            if(Math.abs(pulseSent-pulseReceived)<10){
                                sDelay =0;
                                testResult(currentTest,1);
                                break;
                            }
                            else{
                                if(sDelay ===40){
                                    sDelay = 0;
                                    testResult(currentTest,0);
                                    setErrTip(currentTest,qsTr("receivedErr"));
                                    break;
                                }
                                sDelay++;
                            }
                        }
                        else{
                            if(rDelay ===20){
                                rDelay=0;
                                testResult(currentTest,0);
                                setErrTip(currentTest,qsTr("sendErr"));
                                break;
                            }
                            rDelay++;
                        }
                    }break;
                    case "singleYOnTest":
                    case "singleYOffTest":
                    case "HoldDoubleYOnTest":
                    case "HoldDoubleYOffTest":{
                        var valve = IODefines.getValveItemFromValveName(id);
                        var y1status = panelRobotController.isOutputOn(valve.y1Point, valve.y1Board);
                        var y2status = 0;
                        if(type === "HoldDoubleYOnTest" || type === "HoldDoubleYOffTest"){
                            y2status = panelRobotController.isOutputOn(valve.y2Point, valve.y2Board);
                        }
                        if(type === "singleYOffTest" || type === "HoldDoubleYOffTest"){
                            y1status = !y1status;
                            if(type === "HoldDoubleYOffTest"){
                                y2status = !y2status;
                            }
                        }
                        if(y1status && !y2status){
                            rDelay = 0;
                            var x1Status = panelRobotController.isInputOn(valve.x1Point, valve.x1Board);
                            var x2Status = 0;
                            var x2DirStatus = 1;
                            if(type === "HoldDoubleYOnTest" || type === "HoldDoubleYOffTest"){
                                x2Status = panelRobotController.isInputOn(valve.x2Point, valve.x2Board);
                                x2DirStatus = valve.x2Dir;
                            }
                            if(type === "singleYOffTest" ||type === "HoldDoubleYOffTest"){
                                x1Status = !x1Status;
                                if(type === "HoldDoubleYOffTest"){
                                    x2Status = !x2Status;
                                }
                            }
                            if((valve.x1Dir?x1Status:(!x1Status)) && (x2DirStatus?(!x2Status):x2Status)){
                                   sDelay =0;
                                   testResult(currentTest,1);
                            }
                            else{
                                if(sDelay ===20){
                                    sDelay = 0;
                                    testResult(currentTest,0);
                                    setErrTip(currentTest,qsTr("inputErr"));
                                    break;
                                }
                                sDelay++;
                            }
                        }
                        else{
                            if(rDelay === 10){
                                rDelay=0;
                                testResult(currentTest,0);
                                setErrTip(currentTest,qsTr("outputErr"));
                                break;
                            }
                            rDelay++;
                        }

//                        valveStatus.y1 = panelRobotController.isOutputOn(valve.y1Point, valve.y1Board);
//                        valveStatus.x1 = panelRobotController.isInputOn(valve.x1Point, valve.x1Board);
//                        valveStatus.y2 = panelRobotController.isOutputOn(valve.y2Point, valve.y2Board);
//                        valveStatus.x2 = panelRobotController.isInputOn(valve.x2Point, valve.x2Board);
                    }break;
                    default:break;
                    }
                }
                var currStatus = debugItems.get(currentTest).status;
                if(currStatus === 0 || currStatus ===1){
                    if(singleMode ===0){
                        if(currentTest == debugItems.count -1){
                            currentTest = -1;
                            testBegin.text = qsTr("StartTest");
                            testBegin.bgColor = "green";
                        }
                        else{
                            testDelay++;
                            if(testDelay === 10){
                                testDelay = 0;
                                startTest(currentTest+1);
                            }
                        }
                    }
                    else{
                        currentTest = -1;
                    }
                }
            }

        }
    }
    onVisibleChanged: {
        panelRobotController.swichPulseAngleDisplay(visible ? 5:0);
    }
}

