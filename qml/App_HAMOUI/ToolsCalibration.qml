import QtQuick 1.1
import "../ICCustomElement"
import "configs/AxisDefine.js" as AxisDefine


Item {
    width: parent.width
    height: parent.height

    function readPulse(){
        return [panelRobotController.statusValue("c_ro_0_32_0_901"),
                panelRobotController.statusValue("c_ro_0_32_0_905"),
                panelRobotController.statusValue("c_ro_0_32_0_909"),
                panelRobotController.statusValue("c_ro_0_32_0_913"),
                panelRobotController.statusValue("c_ro_0_32_0_917"),
                panelRobotController.statusValue("c_ro_0_32_0_921")];
    }

    function pulseToText(pulses){
        return AxisDefine.axisInfos[0].name + ":" + pulses[0] + "," +
                AxisDefine.axisInfos[1].name + ":" + pulses[1] + "," +
                AxisDefine.axisInfos[2].name + ":" + pulses[2] + "," +
                AxisDefine.axisInfos[3].name + ":" + pulses[3] + "," +
                AxisDefine.axisInfos[4].name + ":" + pulses[4] + "," +
                AxisDefine.axisInfos[5].name + ":" + pulses[5];
    }

    function onMoldChanged(){
        var pulses =[
                    panelRobotController.getConfigValueText("m_rw_0_32_0_358"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_359"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_360"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_361"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_362"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_363"),
                ];
        p1Show.text = pulseToText(pulses);
        pulses =[
                    panelRobotController.getConfigValueText("m_rw_0_32_0_364"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_365"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_366"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_367"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_368"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_369"),
                ];
        p2Show.text = pulseToText(pulses);

        pulses =[
                    panelRobotController.getConfigValueText("m_rw_0_32_0_370"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_371"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_372"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_373"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_374"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_375"),
                ];
        p3Show.text = pulseToText(pulses);

        pulses =[
                    panelRobotController.getConfigValueText("m_rw_0_32_0_376"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_377"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_378"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_379"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_380"),
                    panelRobotController.getConfigValueText("m_rw_0_32_0_381"),
                ];
        p4Show.text = pulseToText(pulses);


        p1M0.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_382");
        p1M1.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_383");
        p1M2.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_384");
        p1M3.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_385");
        p1M4.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_386");
        p1M5.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_387");

        p2M0.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_388");
        p2M1.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_389");
        p2M2.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_390");
        p2M3.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_391");
        p2M4.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_392");
        p2M5.configValue = panelRobotController.getConfigValueText("m_rw_0_32_3_393");

        enBtn.isChecked = panelRobotController.getConfigValue("m_rw_9_1_0_357");
        selType.checkedIndex = panelRobotController.getConfigValue("m_rw_10_3_0_357");
        type1.isChecked = panelRobotController.getConfigValue("m_rw_10_3_0_357")==0?true:false;
        type2.isChecked = panelRobotController.getConfigValue("m_rw_10_3_0_357")==1?true:false;
    }

    ICButtonGroup{
        id:selType
        width: parent.width/2
        spacing: 5
        anchors.left: parent.left
        anchors.leftMargin: 20
        mustChecked: true
        ICCheckBox{
             id:type1
             text:qsTr("Four Point")
        }
        ICCheckBox{
             id:type2
             text:qsTr("Two Point")
        }
        function onValueChanged(){
            pageContainer.setCurrentIndex(checkedIndex);
            enBtn.isChecked = false;
            panelRobotController.setConfigValue("m_rw_9_1_0_357",0);
            panelRobotController.setConfigValue("m_rw_10_3_0_357",checkedIndex);
            panelRobotController.syncConfigs();
        }
    }

    ICStackContainer{
        id:pageContainer
        width: parent.width/2
        height: parent.height - 170
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: selType.bottom
        anchors.topMargin: 20
    }

    Item {
        id:fourPointType
        width: parent.width/2
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: selType.bottom
        anchors.topMargin: 20
        Grid{
            spacing: 10
            columns: 2
            width: parent.width
            height: parent.height

            ICButton{
                id:p1
                text: qsTr("Set to P1")
                onButtonClicked: {
                    var pulses = parent.readPulse();
                    panelRobotController.setConfigValue("m_rw_0_32_0_358", pulses[0]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_359", pulses[1]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_360", pulses[2]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_361", pulses[3]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_362", pulses[4]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_363", pulses[5]);
                    p1Show.text = parent.pulseToText(pulses);
                    panelRobotController.syncConfigs();

                }
            }
            Text {
                id: p1Show
                text: qsTr("text")
                verticalAlignment: Text.AlignVCenter
                height: p1.height
            }
            ICButton{
                id:p2
                text: qsTr("Set to P2")
                onButtonClicked: {
                    var pulses = parent.readPulse();
                    panelRobotController.setConfigValue("m_rw_0_32_0_364", pulses[0]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_365", pulses[1]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_366", pulses[2]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_367", pulses[3]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_368", pulses[4]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_369", pulses[5]);
                    p2Show.text = parent.pulseToText(pulses);
                    panelRobotController.syncConfigs();


                }
            }
            Text {
                id: p2Show
                text: qsTr("text")
                verticalAlignment: Text.AlignVCenter
                height: p2.height

            }
            ICButton{
                id:p3
                text: qsTr("Set to P3")
                onButtonClicked: {
                    var pulses = parent.readPulse();
                    panelRobotController.setConfigValue("m_rw_0_32_0_370", pulses[0]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_371", pulses[1]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_372", pulses[2]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_373", pulses[3]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_374", pulses[4]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_375", pulses[5]);
                    p3Show.text = parent.pulseToText(pulses);
                    panelRobotController.syncConfigs();

                }
            }
            Text {
                id: p3Show
                text: qsTr("text")
                verticalAlignment: Text.AlignVCenter
                height: p3.height

            }
            ICButton{
                id:p4
                text: qsTr("Set to P4")
                onButtonClicked: {
                    var pulses = parent.readPulse();
                    panelRobotController.setConfigValue("m_rw_0_32_0_376", pulses[0]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_377", pulses[1]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_378", pulses[2]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_379", pulses[3]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_380", pulses[4]);
                    panelRobotController.setConfigValue("m_rw_0_32_0_381", pulses[5]);
                    p4Show.text = parent.pulseToText(pulses);
                    panelRobotController.syncConfigs();

                }
            }
            Text {
                id: p4Show
                text: qsTr("text")
                verticalAlignment: Text.AlignVCenter
                height: p4.height
            }
    //        ICButton{
    //            id:p5
    //            text: qsTr("Set to P5")
    //            onButtonClicked: {
    //                var pulses = parent.readPulse();
    //                panelRobotController.setConfigValue("m_rw_0_32_0_382", pulses[0]);
    //                panelRobotController.setConfigValue("m_rw_0_32_0_383", pulses[1]);
    //                panelRobotController.setConfigValue("m_rw_0_32_0_384", pulses[2]);
    //                panelRobotController.setConfigValue("m_rw_0_32_0_385", pulses[3]);
    //                panelRobotController.setConfigValue("m_rw_0_32_0_386", pulses[4]);
    //                panelRobotController.setConfigValue("m_rw_0_32_0_387", pulses[5]);
    //                p5Show.text = parent.pulseToText(pulses);
    //                panelRobotController.syncConfigs();

    //            }
    //        }
    //        Text {
    //            id: p5Show
    //            text: qsTr("text")
    //            verticalAlignment: Text.AlignVCenter
    //            height: p5.height
    //        }
    //        ICButton{
    //            id:p6
    //            text: qsTr("Set to P6")
    //            onButtonClicked: {
    //                var pulses = parent.readPulse();
    //                panelRobotController.setConfigValue("m_rw_0_32_0_388", pulses[0]);
    //                panelRobotController.setConfigValue("m_rw_0_32_0_389", pulses[1]);
    //                panelRobotController.setConfigValue("m_rw_0_32_0_390", pulses[2]);
    //                panelRobotController.setConfigValue("m_rw_0_32_0_391", pulses[3]);
    //                panelRobotController.setConfigValue("m_rw_0_32_0_392", pulses[4]);
    //                panelRobotController.setConfigValue("m_rw_0_32_0_393", pulses[5]);
    //                p6Show.text = parent.pulseToText(pulses);
    //                panelRobotController.syncConfigs();

    //            }
    //        }
    //        Text {
    //            id: p6Show
    //            text: qsTr("text")
    //            verticalAlignment: Text.AlignVCenter
    //            height: p6.height
    //        }
            onVisibleChanged: {
                panelRobotController.swichPulseAngleDisplay(visible ? 1 : 0);
            }
          }
    }

    Item {
        id: twoPointType
        width: parent.width/2
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: selType.bottom
        anchors.topMargin: 20
        Row{
            width: parent.width
            height: parent.height
            spacing: 30
            Column{
                spacing: 5
                ICButton{
                    id:termianalSetBtn
                    text: qsTr("T Set")
                    height: p1M0.height
                    width: 80
                    onButtonClicked: {
                        p1M0.configValue = panelRobotController.statusValueText("c_ro_0_32_3_900");
                        p1M1.configValue = panelRobotController.statusValueText("c_ro_0_32_3_904");
                        p1M2.configValue = panelRobotController.statusValueText("c_ro_0_32_3_908");
                        p1M3.configValue = panelRobotController.statusValueText("c_ro_0_32_3_912");
                        p1M4.configValue = panelRobotController.statusValueText("c_ro_0_32_3_916");
                        p1M5.configValue = panelRobotController.statusValueText("c_ro_0_32_3_920");

                    }
                }
                ICConfigEdit{
                    id:p1M0
                    configName: AxisDefine.axisInfos[0].name
                    unit: AxisDefine.axisInfos[0].unit
                    configAddr: AxisDefine.axisInfos[0].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_382", configValue);
                        panelRobotController.syncConfigs();
                    }
                }
                ICConfigEdit{
                    id:p1M1
                    configName: AxisDefine.axisInfos[1].name
                    configNameWidth: p1M0.configNameWidth
                    unit: AxisDefine.axisInfos[1].unit
                    configAddr: AxisDefine.axisInfos[1].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_383", configValue);
                        panelRobotController.syncConfigs();
                    }
                }
                ICConfigEdit{
                    id:p1M2
                    configName: AxisDefine.axisInfos[2].name
                    configNameWidth: p1M0.configNameWidth
                    unit: AxisDefine.axisInfos[2].unit
                    configAddr: AxisDefine.axisInfos[2].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_384", configValue);
                        panelRobotController.syncConfigs();
                    }
                }
                ICConfigEdit{
                    id:p1M3
                    configName: AxisDefine.axisInfos[3].name
                    configNameWidth: p1M0.configNameWidth
                    unit: AxisDefine.axisInfos[3].unit
                    configAddr: AxisDefine.axisInfos[3].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_385", configValue);
                        panelRobotController.syncConfigs();
                    }
                }
                ICConfigEdit{
                    id:p1M4
                    configName: AxisDefine.axisInfos[4].name
                    configNameWidth: p1M0.configNameWidth
                    unit: AxisDefine.axisInfos[4].unit
                    configAddr: AxisDefine.axisInfos[4].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_386", configValue);
                        panelRobotController.syncConfigs();
                    }
                }
                ICConfigEdit{
                    id:p1M5
                    configName: AxisDefine.axisInfos[5].name
                    configNameWidth: p1M0.configNameWidth
                    unit: AxisDefine.axisInfos[5].unit
                    configAddr: AxisDefine.axisInfos[5].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_387", configValue);
                        panelRobotController.syncConfigs();
                    }
                }
            }
            Column{
                spacing: 5
                Text {
                    id: toolDev
                    height: termianalSetBtn.height
                    text: qsTr("Tool Dev:")
                }
                ICConfigEdit{
                    id:p2M0
                    configName: AxisDefine.axisInfos[0].name
                    configNameWidth: p1M0.configNameWidth
                    unit: AxisDefine.axisInfos[0].unit
                    configAddr: AxisDefine.axisInfos[0].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_388", configValue);
                        panelRobotController.syncConfigs();
                    }
                }
                ICConfigEdit{
                    id:p2M1
                    configName: AxisDefine.axisInfos[1].name
                    configNameWidth: p1M0.configNameWidth
                    unit: AxisDefine.axisInfos[1].unit
                    configAddr: AxisDefine.axisInfos[1].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_389", configValue);
                        panelRobotController.syncConfigs();
                    }
                }
                ICConfigEdit{
                    id:p2M2
                    configName: AxisDefine.axisInfos[2].name
                    configNameWidth: p1M0.configNameWidth
                    unit: AxisDefine.axisInfos[2].unit
                    configAddr: AxisDefine.axisInfos[2].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_390", configValue);
                        panelRobotController.syncConfigs();
                    }
                }
                ICConfigEdit{
                    id:p2M3
                    configName: AxisDefine.axisInfos[3].name
                    configNameWidth: p1M0.configNameWidth
                    unit: AxisDefine.axisInfos[3].unit
                    configAddr: AxisDefine.axisInfos[3].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_391", configValue);
                        panelRobotController.syncConfigs();
                    }
                }
                ICConfigEdit{
                    id:p2M4
                    configName: AxisDefine.axisInfos[4].name
                    configNameWidth: p1M0.configNameWidth
                    unit: AxisDefine.axisInfos[4].unit
                    configAddr: AxisDefine.axisInfos[4].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_392", configValue);
                        panelRobotController.syncConfigs();
                    }
                }

                ICConfigEdit{
                    id:p2M5
                    configName: AxisDefine.axisInfos[5].name
                    configNameWidth: p1M0.configNameWidth
                    unit: AxisDefine.axisInfos[5].unit
                    configAddr: AxisDefine.axisInfos[5].rangeAddr
                    function onValueChanged() {
                        panelRobotController.setConfigValue("m_rw_0_32_3_393", configValue);
                        panelRobotController.syncConfigs();
                    }
                }
            }
        }
    }

    ICCheckBox {
        id:enBtn
        text: qsTr("Use it?")
        anchors.top:pageContainer.bottom
        anchors.left: parent.left
        anchors.leftMargin: 20
        onClicked: {
            panelRobotController.setConfigValue("m_rw_9_1_0_357", enBtn.isChecked ? 1 : 0);
            panelRobotController.syncConfigs();
        }
    }

    Component.onCompleted: {
        pageContainer.addPage(fourPointType);
        pageContainer.addPage(twoPointType);
        var pageIndex = panelRobotController.getConfigValue("m_rw_10_3_0_357");
        pageContainer.setCurrentIndex(pageIndex);

        panelRobotController.moldChanged.connect(onMoldChanged);
        onMoldChanged();
        p1M0.configValueChanged.connect(p1M0.onValueChanged);
        p1M1.configValueChanged.connect(p1M1.onValueChanged);
        p1M2.configValueChanged.connect(p1M2.onValueChanged);
        p1M3.configValueChanged.connect(p1M3.onValueChanged);
        p1M4.configValueChanged.connect(p1M4.onValueChanged);
        p1M5.configValueChanged.connect(p1M5.onValueChanged);
        p2M0.configValueChanged.connect(p2M0.onValueChanged);
        p2M1.configValueChanged.connect(p2M1.onValueChanged);
        p2M2.configValueChanged.connect(p2M2.onValueChanged);
        p2M3.configValueChanged.connect(p2M3.onValueChanged);
        p2M4.configValueChanged.connect(p2M4.onValueChanged);
        p2M5.configValueChanged.connect(p2M5.onValueChanged);
        selType.checkedIndexChanged.connect(selType.onValueChanged);
    }
}
