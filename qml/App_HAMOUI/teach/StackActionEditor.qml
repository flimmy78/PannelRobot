import QtQuick 1.1
import "../../ICCustomElement"
import "Teach.js" as Teach
import "../configs/AxisDefine.js" as AxisDefine
import "../../utils/utils.js" as Utils
import "../ExternalData.js" as ESData
import "ProgramFlowPage.js" as ProgramList

Rectangle {
    property int stackType: 0
    property int currentPage: 0
    property int pageCount: 2

    signal stackUpdated(int id);

    function createActionObjects(){
        var ret = [];
        if(useFlag.isChecked){
            var statckStr = stackSelector.configText();
            if(stackSelector.configValue < 0) return ret;
            var begin = statckStr.indexOf('[') + 1;
            var end = statckStr.indexOf(']');
            ret.push(Teach.generateStackAction(statckStr.slice(begin, end), speed0.configValue,speedY.configValue,speedZ.configValue,speed1.configValue));
        }
        return ret;
    }

    function updateStacksSel(){
        Teach.parseStacks(panelRobotController.stacks());
        var hasStacks = Teach.stackInfosDescr();
        stackSelector.configValue = -1;
        stackViewSel.currentIndex = -1;
        stackSelector.items =  hasStacks;
        stackViewSel.items = hasStacks;
    }
    onStackTypeChanged: {
        if(stackType == 1){
            pageCount = 3
            speed0.configName = AxisDefine.axisInfos[0].name + qsTr("Speed0");
            speedY.configName = AxisDefine.axisInfos[1].name + qsTr("Speed0");
            speedZ.configName = AxisDefine.axisInfos[2].name + qsTr("Speed0");
            speed1.visible = useFlag.isChecked;
        }else{
            pageCount =  2;
            speed0.configName = AxisDefine.axisInfos[0].name + qsTr("Speed");
            speedY.configName = AxisDefine.axisInfos[1].name + qsTr("Speed");
            speedZ.configName = AxisDefine.axisInfos[2].name + qsTr("Speed");
            speed1.visible = false;
        }
    }

    ICMessageBox{
        id:tipBox
        visible: false
        x:200
        y:-50
        z:10
    }

    Row{
        id:navContainer
        x:630
        y:40
        spacing: 2
        Rectangle{
            id:navLine
            width: 1
            height: 150
            color: "gray"
        }

        ICButton{
            id:changePage
            width: 40
            height: navLine.height
            bgColor: "yellow"
            text: "-->"
            visible: defineStack.isChecked
            enabled: stackViewSel.currentIndex >= 0
            onButtonClicked: {
                ++currentPage;
                currentPage %= pageCount;
                if(currentPage == (pageCount - 1)){
                    text = "<--"
                    detailPage.visible  = true;
                    typeSelector.visible = false;

                }else if(currentPage == 0){
                    text = "-->"
                    detailPage.visible  = false;
                    typeSelector.visible = true;
                }
                else{
                    text = "-->"
                    detailPage.visible  = true;
                    typeSelector.visible = false;
                }

            }
        }
    }

    ICMessageBox{
        id:tip
        z:100
        x:200
        anchors.top: topContainer.bottom
        anchors.topMargin: 6
    }

    ICComboBox{
        id:stackViewSel
        z: 11
        y:topContainer.y
        x:220
        visible: defineStack.isChecked
        popupWidth: 170
        popupHeight: 150
        width: popupWidth
        onCurrentIndexChanged: {
            if(currentIndex < 0 ) return;
            var stackInfo;

            var stackID = parseInt(Utils.getValueFromBrackets(items[currentIndex]));
            stackInfo = Teach.getStackInfoFromID(stackID);
            ESData.externalDataManager.registerDataSource(stackInfo.dsName, ESData.CustomDataSource.createNew("custompoint[" + stackID +"]", stackID));
            page1.motor0 = stackInfo.si0.m0pos;
            page1.motor1 = stackInfo.si0.m1pos;
            page1.motor2 = stackInfo.si0.m2pos;
            page1.motor3 = stackInfo.si0.m3pos;
            page1.motor4 = stackInfo.si0.m4pos;
            page1.motor5 = stackInfo.si0.m5pos;
            page1.space0 = stackInfo.si0.space0;
            page1.space1 = stackInfo.si0.space1;
            page1.space2 = stackInfo.si0.space2;
            page1.count0 = stackInfo.si0.count0;
            page1.count1 = stackInfo.si0.count1;
            page1.count2 = stackInfo.si0.count2;
            page1.seq = stackInfo.si0.sequence;
            page1.dir0 = stackInfo.si0.dir0;
            page1.dir1 = stackInfo.si0.dir1;
            page1.dir2 = stackInfo.si0.dir2;
            page1.doesBindingCounter = stackInfo.si0.doesBindingCounter;
            page1.setCounterID(stackInfo.si0.counterID);
            page1.isOffsetEn = stackInfo.si0.isOffsetEn;
            page1.isZWithYEn = stackInfo.si0.isZWithYEn || false;
            page1.offsetX = stackInfo.si0.offsetX;
            page1.offsetY = stackInfo.si0.offsetY;
            page1.offsetZ = stackInfo.si0.offsetZ;
            page1.setDataSourceName(stackInfo.si0.dataSourceName)
            page1.runSeq = stackInfo.si0.runSeq;


            page2.motor0 = stackInfo.si1.m0pos;
            page2.motor1 = stackInfo.si1.m1pos;
            page2.motor2 = stackInfo.si1.m2pos;
            page2.motor3 = stackInfo.si1.m3pos;
            page2.motor4 = stackInfo.si1.m4pos;
            page2.motor5 = stackInfo.si1.m5pos;
            page2.space0 = stackInfo.si1.space0;
            page2.space1 = stackInfo.si1.space1;
            page2.space2 = stackInfo.si1.space2;
            page2.count0 = stackInfo.si1.count0;
            page2.count1 = stackInfo.si1.count1;
            page2.count2 = stackInfo.si1.count2;
            page2.seq = stackInfo.si1.sequence;
            page2.dir0 = stackInfo.si1.dir0;
            page2.dir1 = stackInfo.si1.dir1;
            page2.dir2 = stackInfo.si1.dir2;
            page2.doesBindingCounter = stackInfo.si1.doesBindingCounter;
            page2.setCounterID(stackInfo.si1.counterID);
            page2.isOffsetEn = stackInfo.si1.isOffsetEn;
            page2.isZWithYEn = stackInfo.si1.isZWithYEn || false;
            page2.offsetX = stackInfo.si1.offsetX;
            page2.offsetY = stackInfo.si1.offsetY;
            page2.offsetZ = stackInfo.si1.offsetZ;
            page2.setDataSourceName(stackInfo.si1.dataSourceName)
            page2.runSeq = stackInfo.si1.runSeq;

            stackType = stackInfo.type;

            if(stackType == 0 ||
                    stackType == 1){
                page1.mode = 0;
            }else{
                page1.mode = 2;
                posAndCmp.setChecked(stackType == 4);
                onlyCmp.setChecked(stackType == 5);
            }
        }
    }


    Item{
        id:topContainer

        function saveStack(id, name, exist, posData){
            var selectedDS;
            var dsID;
            if(page1.isCustomDataSource){
                selectedDS = "custompoint[" + id + "]";
                dsID = id;
            }
            else{
                selectedDS = page1.dataSourceName;
                dsID = ESData.externalDataManager.getDataSourceHostIDByDisplayName(page1.dataSourceName);
            }
            var si0 = new Teach.StackItem(page1.motor0 || 0.000,
                                          page1.motor1 || 0.000,
                                          page1.motor2 || 0.000,
                                          page1.motor3 || 0.000,
                                          page1.motor4 || 0.000,
                                          page1.motor5 || 0.000,
                                          page1.space0 || 0.000,
                                          page1.space1 || 0.000,
                                          page1.space2 || 0.000,
                                          page1.count0 || 0,
                                          page1.count1 || 0,
                                          page1.count2 || 0,
                                          page1.seq,
                                          page1.dir0,
                                          page1.dir1,
                                          page1.dir2,
                                          page1.realDoesBindingCounter(),
                                          page1.counterID(),
                                          page1.isOffsetEn,
                                          page1.offsetX,
                                          page1.offsetY,
                                          page1.offsetZ,
                                          page1.dataSourceName,
                                          selectedDS,
                                          page1.isZWithYEn,
                                          page1.runSeq);
            var si1 = new Teach.StackItem(page2.motor0 || 0.000,
                                          page2.motor1 || 0.000,
                                          page2.motor2 || 0.000,
                                          page2.motor3 || 0.000,
                                          page2.motor4 || 0.000,
                                          page2.motor5 || 0.000,
                                          page2.space0 || 0.000,
                                          page2.space1 || 0.000,
                                          page2.space2 || 0.000,
                                          page2.count0 || 0,
                                          page2.count1 || 0,
                                          page2.count2 || 0,
                                          page2.seq,
                                          page2.dir0,
                                          page2.dir1,
                                          page2.dir2,
                                          page2.realDoesBindingCounter(),
                                          page2.counterID(),
                                          page2.isOffsetEn,
                                          page2.offsetX,
                                          page2.offsetY,
                                          page2.offsetZ,
                                          page2.dataSourceName,
                                          selectedDS,
                                          page2.isZWithYEn,
                                          page2.runSeq);
            var realST = stackType;
            if(realST >= 2){
                realST = page1.isCustomDataSource ? 3 : 2;
                if(realST == 2){
                    if(posAndCmp.isChecked)
                        realST = 4;
                    else if(onlyCmp.isChecked)
                        realST = 5;
                }
            }


            var stackInfo = new Teach.StackInfo(si0, si1, realST, name, "custompoint[" + id + "]", id, posData);
            var sid;
            if(!exist){
                sid = Teach.appendStackInfo(stackInfo);
                stackInfo.dsName = "custompoint[" + sid + "]";
                stackInfo.dsHostID = sid;
                panelRobotController.saveStacks(Teach.stacksToJSON());
                updateStacksSel();
            }
            else{
                stackInfo.dsName = selectedDS;
                stackInfo.dsHostID = dsID;
                sid = Teach.updateStackInfo(id, stackInfo);
                panelRobotController.saveStacks(Teach.stacksToJSON());
            }
            stackUpdated(sid);
            return sid;
        }

        function copyStack(toCopySID, name){
            var sI = Teach.getStackInfoFromID(toCopySID);
            var cpSI = Utils.cloneObject(sI);
            cpSI.descr = name;
            var sid = Teach.appendStackInfo(cpSI);
            if(cpSI.dsHostID == toCopySID){
                cpSI.dsName = "custompoint[" + sid + "]";
                cpSI.dsHostID = sid;
            }
            panelRobotController.saveStacks(Teach.stacksToJSON());
            updateStacksSel();
            stackUpdated(sid);
            return sid;
        }

        function onNewStack(status){
            tip.finished.disconnect(topContainer.onNewStack);
            if(status){
                var toAdd = tip.inputText;
                var sid = saveStack(null, toAdd, false);
                var ss = stackViewSel.items;
                for(var i = 0 ; ss.length; ++i){
                    if(sid == Utils.getValueFromBrackets(ss[i])){
                        stackViewSel.currentIndex = i;
                        break;
                    }
                }
            }

        }

        function onCopyStack(status){
            tip.finished.disconnect(topContainer.onCopyStack);
            if(status){
                var sid = copyStack(Utils.getValueFromBrackets(stackViewSel.currentText()),
                                   tip.inputText);
                var ss = stackViewSel.items;
                for(var i = 0 ; ss.length; ++i){
                    if(sid == Utils.getValueFromBrackets(ss[i])){
                        stackViewSel.currentIndex = i;
                        break;
                    }
                }
            }
        }

        height: flagPageSel.height
        ICButtonGroup{
            id:flagPageSel
            spacing: 10
            mustChecked: true
            isAutoSize: true
            layoutMode: 0
            ICCheckBox{
                id:useFlag
                text: qsTr("Use Stack")
            }
            ICCheckBox{
                id:defineStack
                text: qsTr("Define Stack")
                isChecked: true
            }
            onCheckedItemChanged: {
                stackSelector.configValue = -1;
                stackViewSel.currentIndex = -1;
                stackType = 0;
                speed1.visible = false;
                currentPage = 0;
                changePage.text = "-->";
                detailPage.visible  = false;
                typeSelector.visible = true;
            }

        }

        ICButton{
            id:newStackBtn
            text: qsTr("New")
            width: 60
            height: stackViewSel.height
            x:400
            visible: stackViewSel.visible
            bgColor: "lime"
            onButtonClicked: {
                tip.showInput(qsTr("Please input the new stack name"),
                              qsTr("Stack Name"), false, qsTr("OK"), qsTr("Cancel"))
                tip.finished.connect(topContainer.onNewStack);
            }
        }

        ICButton{
            id:copyStackBtn
            text: qsTr("Copy")
            width: newStackBtn.width
            height: stackViewSel.height
            visible: newStackBtn.visible && stackViewSel.currentIndex >= 0
            bgColor: "lime"

            anchors.left: newStackBtn.right
            anchors.leftMargin: 6
            onButtonClicked: {
                tip.showInput(qsTr("Please input the new stack name"),
                              qsTr("Stack Name"), false, qsTr("OK"), qsTr("Cancel"))
                tip.finished.connect(topContainer.onCopyStack);
            }

        }


        ICButton{
            id:deleteStack
            text: qsTr("Delete")
            width: newStackBtn.width
            height: stackViewSel.height
            visible: stackViewSel.visible && stackViewSel.currentIndex >= 0
            bgColor: "red"

            anchors.left: copyStackBtn.right
            anchors.leftMargin: 6
            onButtonClicked: {
                var sid = parseInt(Utils.getValueFromBrackets(stackViewSel.currentText()));
                var usedInfo = ProgramList.stackLinesInfo.idUsed(sid);
                if(usedInfo.used){
                   tipBox.warning(qsTr("Stack") + "[" + sid + "] " + " " + qsTr("is using!"),
                                  ProgramList.LinesInfo.usedLineInfoString(usedInfo));
                    return;
                }

                Teach.delStack(sid);
                panelRobotController.saveStacks(Teach.stacksToJSON());
                updateStacksSel();
                stackUpdated(sid);
            }

        }

        ICButton{
            id:save
            text: qsTr("Save")
            width: 80
            height: stackViewSel.height
            visible: stackViewSel.visible && stackViewSel.currentIndex >= 0
            bgColor: "yellow"
            anchors.left: deleteStack.right
            anchors.leftMargin: 6
            onButtonClicked: {
                if(stackViewSel.currentIndex < 0) return;
                var id = parseInt(Utils.getValueFromBrackets(stackViewSel.currentText()));
                var sI = Teach.getStackInfoFromID(id);
                topContainer.saveStack(id,sI.descr, true, sI.posData);
            }

        }


    }
    Column{
        anchors.top: topContainer.bottom
        anchors.topMargin: 6
        spacing: 4
        Column{
            spacing: 4
            visible: defineStack.isChecked

            Row{
                id:typeSelector
                spacing: 10
                height: 140
                visible: defineStack.isChecked
                //        layoutMode: 1
                ICButton{
                    id:type1
                    text: qsTr("Normal")
                    height: parent.height
                    width: parent.height
                    bgColor: stackType == 0 ? "lime" : "white"
                    onButtonClicked: {
                        stackType = 0;
                        pageCount = 2;
                        page1.mode = 0;
                    }
                }
                ICButton{
                    id:type2
                    text: qsTr("Box")
                    height: parent.height
                    width: parent.height
                    bgColor: stackType == 1 ? "lime" : "white"

                    onButtonClicked: {
                        stackType = 1;
                        pageCount = 3;
                        page1.mode = 0;

                    }
                }
                ICButton{
                    id:type3
                    text: qsTr("Data Source")
                    height: parent.height
                    width: parent.height
                    bgColor: ((stackType >= 2) ? "lime" : "white")

                    onButtonClicked: {
                        stackType = 2;
                        pageCount = 2;
                        page1.mode = 2;
                    }
                }
            }

            Column{
                id:detailPage
                visible: false;
                spacing: 4
                ICButton{
                    id:setIn
                    text: qsTr("Set In")
                    visible: page1.mode != 2
                    onButtonClicked: {
                        page1.motor0 = panelRobotController.statusValueText("c_ro_0_32_3_900");
                        page1.motor1 = panelRobotController.statusValueText("c_ro_0_32_3_904");
                        page1.motor2 = panelRobotController.statusValueText("c_ro_0_32_3_908");
                        page1.motor3 = panelRobotController.statusValueText("c_ro_0_32_3_912");
                        page1.motor4 = panelRobotController.statusValueText("c_ro_0_32_3_916");
                        page1.motor5 = panelRobotController.statusValueText("c_ro_0_32_3_920");
                    }

                }
                ICButton{
                    id:editPos
                    text: qsTr("Edit Pos")
                    visible: page1.isCustomDataSource && page1.mode == 2
                    function onEditConfirm(accepted, points){
                        if(accepted){
                            if(stackViewSel.currentIndex < 0) return;
                            var id = parseInt(Utils.getValueFromBrackets(stackViewSel.currentText()));
                            var sI = Teach.getStackInfoFromID(id);
                            sI = Teach.getStackInfoFromID(topContainer.saveStack(id,sI.descr, true, points));
                            var toSend = new ESData.RawExternalDataFormat(sI.dsName, sI.posData);
                            toSend = ESData.externalDataManager.parseRaw(toSend);
                            panelRobotController.sendExternalDatas(JSON.stringify(toSend));
                        }else
                            customPointEditor.editConfirm.disconnect(editPos.onEditConfirm);
                    }

                    onButtonClicked: {
//                        customPointEditor.visible = true;
//                        customPointEditor.editConfirm.connect(editPos.onEditConfirm);
                        var id = parseInt(Utils.getValueFromBrackets(stackViewSel.currentText()));
                        var sI = Teach.getStackInfoFromID(id);
                        if(sI.posData === undefined)
                            sI.podData = [];
                        customPointEditor.show(sI.posData, true, editPos.onEditConfirm);
                    }
                }

                ICButtonGroup{
                    spacing: 24
                    id:visionType
                    visible: !page1.isCustomDataSource && page1.mode == 2
                    ICCheckBox{
                        id:posAndCmp
                        text: qsTr("Pos And Cmp")
                    }
                    ICCheckBox{
                        id:onlyCmp
                        text: qsTr("Only Cmp")
                    }
                }

                StackActionEditorComponent{
                    x:setIn.x
                    id:page1
                    visible: currentPage == 1;
                }
                StackActionEditorComponent{
                    x:setIn.x
                    id:page2
                    visible: currentPage == 2;
                    mode: 1
                }

            }
        }
        ICComboBoxConfigEdit{
            id:stackSelector
            visible: useFlag.isChecked
            configName: qsTr("Stack")
            inputWidth: 200
            popupHeight: 150
            z:10
            onConfigValueChanged: {
                if(configValue < 0) return;
                var stackInfo = Teach.getStackInfoFromID(parseInt(Utils.getValueFromBrackets(items[configValue])));
                stackType = stackInfo.type;
            }
        }
        ICConfigEdit{
            id:speed0
            visible: useFlag.isChecked
            configName: AxisDefine.axisInfos[0].name +qsTr("Speed")
//            configAddr: "s_rw_0_16_1_294"
            configAddr: "s_rw_0_32_1_212"
            unit: "%"
            configValue: "80.0"
        }
        ICConfigEdit{
            id:speedY
            visible: useFlag.isChecked
            configName: AxisDefine.axisInfos[1].name +qsTr("Speed")
            configNameWidth: speed0.configNameWidth
            configAddr: "s_rw_0_32_1_212"
            unit: "%"
            configValue: "80.0"
        }
        ICConfigEdit{
            id:speedZ
            visible: useFlag.isChecked
            configName: AxisDefine.axisInfos[2].name +qsTr("Speed")
            configNameWidth: speed0.configNameWidth
            configAddr: "s_rw_0_32_1_212"
            unit: "%"
            configValue: "80.0"
        }
        ICConfigEdit{
            id:speed1
            visible: useFlag.isChecked
            configName: qsTr("Speed1")
//            configAddr: "s_rw_0_16_1_294"
            configAddr: "s_rw_0_32_1_212"
            unit: "%"
            configValue: "80.0"
        }
    }

    onVisibleChanged:{
        if(visible){
            page1.updateCounters();
            page2.updateCounters();
            stackSelector.configValue = -1;
            stackViewSel.currentIndex = -1;
            stackType = 0;
            speed1.visible = false;
            currentPage = 0;
            changePage.text = "-->";
            detailPage.visible  = false;
            typeSelector.visible = true;
        }
    }

    Component.onCompleted: {
        updateStacksSel();
        panelRobotController.moldChanged.connect(updateStacksSel);
        page1.dataSource = ESData.externalDataManager.dataSourceNameList();
        page2.dataSource = page1.dataSource;


    }
}
