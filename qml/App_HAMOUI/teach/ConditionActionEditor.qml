import QtQuick 1.1

import "../../ICCustomElement"
import "Teach.js" as Teach
import "../configs/IODefines.js" as IODefines
import "../../utils/stringhelper.js" as ICString


Item {
    id:container

    property variant ys: [
        "Y010",
        "Y011",
        "Y012",
        "Y013",
        "Y014",
        "Y015",
        "Y016",
        "Y017",
        "Y020",
    ]

    property  variant euYs : ["EuY010", "EuY011", "EuY012"]
    property variant mYs: ["INY010"]

    property variant xs: [
        "X010",
        "X011",
        "X012",
        "X014",
        "X015",
        "X016",
        "X017",
        "X020",
    ]
    property  variant euXs : ["EuX010", "EuX011"]
    property variant mXs: ["INX010"]

    function createActionObjects(){
        var ret = [];
        if(defineFlag.isChecked){
            ret.push(Teach.generateFlagAction(Teach.useableFlag(), flagDescr.configValue));
            return ret;
        }

        var mD;
        var data;
        var ui;
        var inout = 0;
        var flagStr = flag.configText;
        if(flag.currentIndex < 0) return ret;
        var begin = flagStr.indexOf('[') + 1;
        var end = flagStr.indexOf(']');
        if(normalY.isChecked){
            mD = yModel;
            inout = 1;

        }else if(euY.isChecked){
            mD = euYModel;
            inout = 1;
        }else if(mY.isChecked){
            mD = mYModel;
            inout = 1;
        }else if(normalX.isChecked){
            mD = xModel

        }else if(euX.isChecked){
            mD = euXModel
        }else if(mX.isChecked){
            mD = mXModel
        }else{

            ret.push(Teach.generateJumpAction(parseInt(flagStr.slice(begin,end))));
            return ret;
        }

        for(var i = 0; i < mD.count; ++i)
        {
            data = mD.get(i);
            if(data.isSel){
                var isOn = statusGroup.checkedItem == onBox ? true : false;
                ret.push(Teach.generateConditionAction(
                             data.board,
                             data.hwPoint,
                             inout,
                             isOn,
                             limit.configValue,
                             parseInt(flagStr.slice(begin,end))));
                break;
            }
        }
        return ret;
    }
    width: parent.width
    height: parent.height

    Column{
        spacing: 4

        ICButtonGroup{
            id:flagPageSel
            spacing: 10
            ICCheckBox{
                id:defineFlag
                text: qsTr("Define Flag")
                isChecked: true
            }
            ICCheckBox{
                id:useFlag
                text: qsTr("Use Flag")
            }
        }

        Column{
            id:useFlagPage
            spacing: 4
            visible: useFlag.isChecked
            ICButtonGroup{
                id:typeGroup
                spacing: 20
                ICCheckBox{
                    id:normalY
                    text: qsTr("Y")
                    isChecked: true
                    visible:ys.length > 0
                }
                ICCheckBox{
                    id:euY
                    text: qsTr("EUY")
                    visible: euYs.length > 0
                }
                ICCheckBox{
                    id:mY
                    text: qsTr("MY")
                    visible: mYs.length > 0
                }
                ICCheckBox{
                    id:normalX
                    text: qsTr("X")
                }
                ICCheckBox{
                    id:euX
                    text: qsTr("EUX")
                }
                ICCheckBox{
                    id:mX
                    text: qsTr("MX")
                }
                ICCheckBox{
                    id:jump
                    text: qsTr("Jump")
                }
            }
            Rectangle{
                id:yContainer
                width: 690
                height: container.height - typeGroup.height - statusGroup.height - flagPageSel.height - anchors.topMargin - parent.spacing * 4
                color: "#A0A0F0"
                border.width: 1
                border.color: "black"
                //            visible: normalY.isChecked
                ListModel{
                    id:yModel
                }
                ListModel{
                    id:euYModel
                }
                ListModel{
                    id:mYModel
                }
                ListModel{
                    id:xModel
                }
                ListModel{
                    id:euXModel
                }
                ListModel{
                    id:mXModel
                }


                GridView{
                    id:ioView
                    function createMoldItem(ioDefine, hwPoint, board){
                        return {"isSel":false,
                            "pointNum":ioDefine.pointName,
                            "pointDescr":ioDefine.descr,
                            "hwPoint":hwPoint,
                            "board":board,
                            "isOn": false
                        };
                    }

                    function createValveMoldItem(pointNum, pointDescr, hwPoint, board){
                        return {"isSel":false,
                            "pointNum":pointNum,
                            "pointDescr":pointDescr,
                            "hwPoint":hwPoint,
                            "board":board,
                            "isOn": false
                        };
                    }

                    width: parent.width - 4
                    height: parent.height - 4
                    anchors.centerIn: parent
                    cellWidth: 226
                    cellHeight: 32
                    clip: true
                    model: {
                        if(normalY.isChecked) return yModel;
                        if(euY.isChecked) return euYModel;
                        if(mY.isChecked) return mYModel;
                        if(normalX.isChecked) return xModel;
                        if(euX.isChecked) return euXModel;
                        if(mX.isChecked) return mXModel;
                        return null;
                    }

                    delegate: Row{
                        spacing: 2
                        height: 26
                        ICCheckBox{
                            text: pointNum + ":" + pointDescr
                            isChecked: isSel
                            width: ioView.cellWidth * 0.35
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    var m = ioView.model;
                                    var toSetSel = !isSel;
                                    m.setProperty(index, "isSel", toSetSel);
                                    for(var i = 0; i < m.count; ++i){
                                        if( i !== index){
                                            m.setProperty(i, "isSel", false);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Row{
                spacing: 20
                ICButtonGroup{
                    id:statusGroup
                    checkedItem: onBox
                    Row{
                        spacing: 10
                        ICCheckBox{
                            id:onBox
                            text: qsTr("ON")
                            isChecked: true
                        }
                        ICCheckBox{
                            id:offBox
                            text: qsTr("OFF")
                        }
                    }
                    height: 32
                }

                ICConfigEdit{
                    id:limit
                    configName: qsTr("Limit:")
                    unit: qsTr("s")
                    inputWidth: 100
                    height: 24
                    visible: true
                    z:1
                    configAddr: "s_rw_0_32_1_1201"
                    configValue: "0.0"
                }

                ICComboBoxConfigEdit{
                    id: flag
                    configName: qsTr("Flag")
                    popupMode: 1
                    inputWidth: 300

                    onVisibleChanged: {
                        if(visible){
                            items = Teach.flagStrs
                        }
                    }
                }
            }
        }


        ICConfigEdit{
            id:flagDescr
            visible: !flag.visible
            configName: qsTr("Flag")
            isNumberOnly: false
            inputWidth: 200
        }
    }

    Component.onCompleted: {

        var yDefines = ys;
        var yDefine;
        var i;
        for(i = 0; i < yDefines.length; ++i){
            yDefine = IODefines.getYDefineFromPointName(yDefines[i]);
            yModel.append(ioView.createMoldItem(yDefine.yDefine, yDefine.hwPoint, yDefine.type));
        }

        yDefines = euYs;
        for(i = 0; i < yDefines.length; ++i){
            yDefine = IODefines.getYDefineFromPointName(yDefines[i]);
            euYModel.append(ioView.createMoldItem(yDefine.yDefine, yDefine.hwPoint, yDefine.type));
        }

        yDefines = mYs;
        for(i = 0; i < yDefines.length; ++i){
            yDefine = IODefines.getYDefineFromPointName(yDefines[i]);
            mYModel.append(ioView.createMoldItem(yDefine.yDefine, yDefine.hwPoint, yDefine.type));
        }

        var xDefines = xs;
        var xDefine;
        var i;
        for(i = 0; i < xDefines.length; ++i){
            xDefine = IODefines.getXDefineFromPointName(xDefines[i]);
            xModel.append(ioView.createMoldItem(xDefine.xDefine, xDefine.hwPoint, xDefine.type));
        }

        xDefines = euXs;
        for(i = 0; i < xDefines.length; ++i){
            xDefine = IODefines.getXDefineFromPointName(xDefines[i]);
            euXModel.append(ioView.createMoldItem(xDefine.xDefine, xDefine.hwPoint, xDefine.type));
        }

        xDefines = mXs;
        for(i = 0; i < xDefines.length; ++i){
            xDefine = IODefines.getXDefineFromPointName(xDefines[i]);
            mXModel.append(ioView.createMoldItem(xDefine.xDefine, xDefine.hwPoint, xDefine.type));
        }
    }

}
