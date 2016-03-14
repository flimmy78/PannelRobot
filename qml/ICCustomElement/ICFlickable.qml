import QtQuick 1.1

Flickable{
    id: flick
    property variant hinttext: NULL
    property variant hinttext1: NULL
    property bool isshowhint: false
    onMovementEnded: {
        if(atYEnd){
            hinttext.text = "︽";
            hinttext1.text = "︽"
        }else {hinttext.text = "︾";hinttext1.text = "︾";}
    }
    SequentialAnimation{
        id: flicker
        loops: Animation.Infinite
        running: visible
        PropertyAnimation{ target: hinttext;properties: "color";to:"transparent";duration: 200}
        PropertyAnimation{ target: hinttext1;properties: "color";to:"black";duration: 200}
        PropertyAnimation{ target: hinttext;properties: "color";to:"black";duration: 200}
        PropertyAnimation{ target: hinttext1;properties: "color";to:"transparent";duration: 200}
    }
    Component.onCompleted: {
        var hint = Qt.createQmlObject('import QtQuick 1.0; Rectangle{visible: isshowhint;width: 15;height: 30;x: flick.width;color: "grey"}',
             flick.parent, "dynamicSnippet1");
        hint.y = flick.height - hint.height;
        hinttext = Qt.createQmlObject('import QtQuick 1.0; Text{anchors.centerIn: parent;text: "︾"}',
             hint, "dynamicSnippet2");
        hinttext1 = Qt.createQmlObject('import QtQuick 1.0; Text{text: "︾";x: hinttext.x;y: hinttext.y + 10;visible: hintvisible}',
             hint, "dynamicSnippet3");
    }
}
