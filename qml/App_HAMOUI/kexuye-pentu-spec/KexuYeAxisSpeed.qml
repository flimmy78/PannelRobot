import QtQuick 1.1
import "../../ICCustomElement"
import "../configs/AxisDefine.js" as AxisDefine

Item {
    id:container
    width: parent.width
    height: parent.height
    property variant actionObject: null

    function updateActionObject(ao){
        ao.startSpeed0 = m0Speed.configValue;
        ao.startSpeed1 = m1Speed.configValue;
        ao.startSpeed2 = m2Speed.configValue;
        ao.startSpeed3 = m3Speed.configValue;
        ao.startSpeed4 = m4Speed.configValue;
        ao.startSpeed5 = m5Speed.configValue;
        ao.fixtureDelay0 = delay0.configValue;
        ao.fixtureDelay1 = delay1.configValue;
        ao.fixtureDelay2 = delay2.configValue;
    }

    function getDetails(){
        return {
            "spd0":m0Speed.configValue,
            "spd1":m1Speed.configValue,
            "spd2":m2Speed.configValue,
            "spd3":m3Speed.configValue,
            "spd4":m4Speed.configValue,
            "spd5":m5Speed.configValue,
            "delay0":delay0.configValue,
            "delay1":delay1.configValue,
            "delay2":delay2.configValue,
            "delay20":delay20.configValue,
            "delay21":delay21.configValue,
            "delay22":delay22.configValue,
            "fixtureSwitch":fixtureSwitch.configValue,
            "fixture1Switch":fixture1Switch.configValue
        };
    }
    function speedcontainer() {return configContainer;}

    Column{
        id:configContainer
        property int posNameWidth: 60
        spacing: 10
        Column{
            spacing: 4
            z: 3
            Row{
                spacing: 10
                Text {
                    id: fixtureDelay
                    text: qsTr("Fixture Delay")
                    width: 200
                    anchors.verticalCenter: parent.verticalCenter
                    color: "green"
                }
            }
            Row{
                spacing: 10
                id:delaycontiner
                ICConfigEdit{
                    id:delay0
                    configName: qsTr("Atomization Delay")
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
                ICConfigEdit{
                    id:delay1
                    configName: qsTr("Amplitude Delay")
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
                ICConfigEdit{
                    id:delay2
                    configName: qsTr("Oil Delay")
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
                ICComboBoxConfigEdit{
                    id:fixtureSwitch
                    configName: qsTr("FixSwitch")
                    items: [qsTr("L"), qsTr("R"), qsTr("D"), qsTr("Close"), qsTr("Open")]
                }
            }
        }
        Column{
            spacing: 4
            z: 2
            Row{
                spacing: 10
                Text {
                    id: fixture1Delay
                    text: qsTr("Fixture1 Delay")
                    width: 200
                    anchors.verticalCenter: parent.verticalCenter
                    color: "green"
                }
            }
            Row{
                spacing: 10
                id:delaycontiner2
                ICConfigEdit{
                    id:delay20
                    configName: qsTr("Atomization Delay")
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
                ICConfigEdit{
                    id:delay21
                    configName: qsTr("Amplitude Delay")
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
                ICConfigEdit{
                    id:delay22
                    configName: qsTr("Oil Delay")
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
                ICComboBoxConfigEdit{
                    id:fixture1Switch
                    configName: qsTr("FixSwitch")
                    items: [qsTr("L"), qsTr("R"), qsTr("D"), qsTr("Close"), qsTr("Open")]
                    popupHeight: 100
                }
            }
        }
        Column{
            spacing: 4
            Row{
                spacing: 10
                Text {
                    id: returnspeed
                    text: qsTr("Return Speed")
                    width: 200
                    anchors.verticalCenter: parent.verticalCenter
                    color: "green"
                }
            }
            Row{
                spacing: 10
                id:rspeedContainer
                ICConfigEdit{
                    id:m0Speed
                    configName: AxisDefine.axisInfos[0].name
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
                ICConfigEdit{
                    id:m1Speed
                    configName: AxisDefine.axisInfos[1].name
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
                ICConfigEdit{
                    id:m2Speed
                    configName: AxisDefine.axisInfos[2].name
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
                ICConfigEdit{
                    id:m3Speed
                    configName: AxisDefine.axisInfos[3].name
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
                ICConfigEdit{
                    id:m4Speed
                    configName: AxisDefine.axisInfos[4].name
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
                ICConfigEdit{
                    id:m5Speed
                    configName: AxisDefine.axisInfos[5].name
                    configAddr: "s_rw_0_32_1_1200"
                    unit: qsTr("%")

                }
            }
        }
    }
    onActionObjectChanged: {
        if(actionObject == null) return;
        m0Speed.configValue = actionObject.startSpeed0;
        m1Speed.configValue = actionObject.startSpeed1;
        m2Speed.configValue = actionObject.startSpeed2;
        m3Speed.configValue = actionObject.startSpeed3;
        m4Speed.configValue = actionObject.startSpeed4;
        m5Speed.configValue = actionObject.startSpeed5;
        delay0.configValue = actionObject.fixtureDelay0;
        delay1.configValue = actionObject.fixtureDelay1;
        delay2.configValue = actionObject.fixtureDelay2;
    }

    Component.onCompleted: {
        delay0.configValue = 0.1;
        delay1.configValue = 0;
        delay2.configValue = 0;
        fixtureSwitch.configValue = 2;
        delay20.configValue = 0.1;
        delay21.configValue = 0;
        delay22.configValue = 0;
        fixture1Switch.configValue = 2;
        m0Speed.configValue = 30;
        m1Speed.configValue = 30;
        m2Speed.configValue = 30;
        m3Speed.configValue = 5;
        m4Speed.configValue = 5;
        m5Speed.configValue = 5;


    }
}