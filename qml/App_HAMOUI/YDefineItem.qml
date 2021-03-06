import QtQuick 1.1
import "../ICCustomElement"
import "configs/IODefines.js" as IODefines



Item {
    //    property bool isOn: false
    //    property int board: 0
    //    property int hwPoint: 0
    property string valveName: ""
    property variant valveStatus: {"y1":false, "x1":false, "y2":false, "x2":false}
    property variant valve: null
    width: 350
    height: y1Led.height
    Text {
        id: pointDescr
        width: 120
        height: parent.height
        verticalAlignment: Text.AlignVCenter

    }

    Rectangle{
        id:y1Led
        width: 32
        height: 32
        border.color: "black"
        border.width: 2
        color: valveStatus.y1 ? "lime": "gray"
        anchors.left:  pointDescr.right
        anchors.leftMargin: 12
    }

    Rectangle{
        id:x1Led
        width: 32
        height: 32
        border.color: "black"
        border.width: 2
        color: valveStatus.x1 ? "red": "gray"
        anchors.left:  y1Led.right
        anchors.leftMargin: 12
    }

    ICButton{
        id:actionButton
        width: 80
        height: 32
        text: valveStatus.y1 ? qsTr("Off"): qsTr("On")
        anchors.left:  x1Led.right
        anchors.leftMargin: 12
        onButtonClicked: {
            var toSend = IODefines.valveItemJSON(valveName);
            panelRobotController.setYStatus(toSend, !valveStatus.y1);
        }
    }

    Rectangle{
        id:y2Led
        width: 32
        height: 32
        border.color: "black"
        border.width: 2
        color: valveStatus.y2 ? "lime": "gray"
        anchors.left:  actionButton.right
        anchors.leftMargin: 12
    }

    Rectangle{
        id:x2Led
        width: 32
        height: 32
        border.color: "black"
        border.width: 2
        color: valveStatus.x2 ? "red": "gray"
        anchors.left:  y2Led.right
        anchors.leftMargin: 12
    }



    Component.onCompleted: {
        if(valve === null) return;
        pointDescr.text = valve.descr;
        x1Led.visible = !IODefines.isNormalYType(valve);
        y2Led.visible = IODefines.isDoubleYType(valve);
        x2Led.visible = IODefines.isDoubleYType(valve);
    }

    //    onIsOnChanged: {
    //        if(isOn){
    //            yLed.color = "lime" ;
    //            actionButton.text = qsTr("Off");
    //        }else{
    //            yLed.color = "gray"
    //            actionButton.text = qsTr("On");
    //        }
    //    }
}
