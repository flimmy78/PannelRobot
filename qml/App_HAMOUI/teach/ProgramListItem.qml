import QtQuick 1.1
Rectangle{
    id:container
    property int lineNum: 0
    property bool isComment: false
    property bool isCurrent: false
    property bool isRunning: false
    property string text: ""

    state: {
        var ret = "";
        if(isCurrent){
            ret += "current";
        }
        if(isComment)
            ret += "comment";

        if(!isCurrent && isRunning)
            ret = "running";
        return ret;
    }

    states: [
        State {
            name: "comment"
            PropertyChanges { target: num; text: "#" + lineNum; horizontalAlignment:Text.AlignLeft;}
            PropertyChanges { target: container; color: "gray";}
        },
        State {
            name: "current"
            PropertyChanges { target: container; color: "lightsteelblue";}

        },
        State {
            name: "currentcomment"
            PropertyChanges { target: num; text: "#" + lineNum; horizontalAlignment:Text.AlignLeft;}
            PropertyChanges { target: container; color: "lightsteelblue";}
        },
        State {
            name: "running"
            PropertyChanges {target: container; color:"lime";}
        }
    ]

    Text{
        id:num
        width: 35
        text: lineNum
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignRight
    }
    Text {
        text:"             " + container.text
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
    }
    color: lineNum % 2 == 1 ? "cyan" : "yellow"
}