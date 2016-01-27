import QtQuick 1.1
import "."
import "ShareData.js" as ShareData
import "ICOperationLog.js" as ICOperationLog

Rectangle {
    id:container
    property int textOffset: 2

    color: "#d1d1d1"

    function onUserChanged(user){
        ICOperationLog.opLog.currentUser =  user.user;
    }

    ListModel{
        id:operationLogModel
    }

    Row{
        id:header
        anchors.horizontalCenter: parent.horizontalCenter
        y:6
        z:2
        Rectangle{
            id:hOpTime
            border.width: 1
            border.color: "gray"
            width: 150
            height: 32
            Text {
                text: qsTr("Operation Time")
                verticalAlignment: Text.AlignVCenter
                height: parent.height
                x:textOffset
            }
        }
        Rectangle{
            id:hUser
            border.width: hOpTime.border.width
            border.color: hOpTime.border.color
            width: 80
            height: hOpTime.height
            Text {
                text: qsTr("User")
                verticalAlignment: Text.AlignVCenter
                height: parent.height
                x:textOffset

            }
        }
        Rectangle{
            id:hDescr
            border.width: hOpTime.border.width
            border.color: hOpTime.border.color
            width: 550
            height: hOpTime.height
            Text {
                text: qsTr("Descr")
                verticalAlignment: Text.AlignVCenter
                height: parent.height
                x:textOffset
            }
        }
    }

    ListView{
        id:logView
        anchors.top: header.bottom
        model: operationLogModel
        x:header.x
        width: header.width + 1
        height: {
            var cH = container.height - header.height - header.y * 2;
            var mH = header.height * operationLogModel.count;
            return Math.min(cH, mH) + 5;
        }
        clip: true
        delegate: Row{
            Rectangle{
                border.width: hOpTime.border.width
                border.color: hOpTime.border.color
                width: hOpTime.width
                height: hOpTime.height
                Text {
                    text: opTime
                    verticalAlignment: Text.AlignVCenter
                    height: parent.height
                    x:textOffset

                }
            }
            Rectangle{
                border.width: hOpTime.border.width
                border.color: hOpTime.border.color
                width: hUser.width
                height: hUser.height
                Text {
                    text: user
                    verticalAlignment: Text.AlignVCenter
                    height: parent.height
                    x:textOffset

                }
            }
            Rectangle{
                border.width: hOpTime.border.width
                border.color: hOpTime.border.color
                width: hDescr.width
                height: hDescr.height
                Text {
                    text:descr
                    verticalAlignment: Text.AlignVCenter
                    height: parent.height
                    x:textOffset

                }
            }
        }
    }


    Component.onCompleted: {
        ICOperationLog.opLog.mapViewModel(operationLogModel);
        ShareData.UserInfo.registUserChangeEvent(container);
    }
}
