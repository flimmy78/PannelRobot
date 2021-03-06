import QtQuick 1.1
import "../../../ICCustomElement"
import "ExtentActionDefine.js" as ExtentActionDefine
import "../../configs/AxisDefine.js" as AxisDefine

ExtentActionEditorBase {
    width: content.width + 20
    height: content.height
    id:instance
    property alias para1: para1Edit.configValue
    property alias pos1 : pos1Edit.configValue
    property alias pos2 : pos2Edit.configValue
    property alias lpos1: lpos1Edit.configValue
    property alias lpos2: lpos2Edit.configValue
    property alias aid  : aidEdit.configValue

    onActionObjectChanged: {
        if(actionObject == null) return;
        para1 = actionObject.para1;
        pos1 = actionObject.pos1;
        pos2 = actionObject.pos2;
        lpos1 = actionObject.lpos1;
        lpos2 = actionObject.lpos2;
        aid = actionObject.aid;
        var id1 = actionObject.para1&0xf;
        var id2 = (actionObject.para1>>4)&0xf;
        var allow = (actionObject.para1>>8)&1;
        limitedAxisSel.configValue = id2;
        limitAxisSel.configValue = id1;
        checkOut.isChecked = allow;
        whenChange.isChecked = para1 >> 11;
    }

    Column{
        id:content
        spacing: 6
        ICCheckBox{
            id:checkOut
            text: qsTr("Out Range")
        }
        Row{
            spacing: 6
            ICComboBoxConfigEdit{
                id:limitedAxisSel
                configName: qsTr("Limited Axis")
                configNameWidth: 70
                items: [
                    AxisDefine.axisInfos[0].name,
                    AxisDefine.axisInfos[1].name,
                    AxisDefine.axisInfos[2].name,
                    AxisDefine.axisInfos[3].name,
                    AxisDefine.axisInfos[4].name,
                    AxisDefine.axisInfos[5].name]
                popupMode: 1
            }
            ICHCAddrEdit{
                id:pos1Edit
                configValue: 0
                configNameWidth: 40
                mode: 0
                configName: checkOut.isChecked ? "<" : ">"
            }
            ICHCAddrEdit{
                id:pos2Edit
                configValue: 0
                configNameWidth: 40
                mode: 0
                configName: checkOut.isChecked ? ">" : "<"
            }
        }

        ICComboBoxConfigEdit{
            id:limitAxisSel
            configName: qsTr("Limit Axis")
            items: limitedAxisSel.items
            configNameWidth: limitedAxisSel.configNameWidth
            popupMode: 1

        }
        ICButtonGroup{
            spacing: 6
            mustChecked: true
            checkedIndex: 0
            ICCheckBox{
                id:whenChange
                text: qsTr("Changed")
                isChecked: true
            }
            ICCheckBox{
                id:range
                text: qsTr("Range")
            }
        }

        Row{
            spacing: 6
            enabled: range.isChecked
            ICHCAddrEdit{
                id:lpos1Edit
                configValue: 0
                configNameWidth: 40
                mode: 0
                configName: "<"
            }
            ICHCAddrEdit{
                id:lpos2Edit
                configValue: 0
                configNameWidth: 40
                mode: 0
                configName: ">"
            }
        }

        ICConfigEdit{
            id:aidEdit
            configName: qsTr("Alarm Num")
            configValue: "5000"
            configNameWidth: 40
        }
        ICConfigEdit{
            id:para1Edit
            visible: false
            configValue: {
                var ret= limitedAxisSel.configValue;
                ret|= limitAxisSel.configValue<<4;
                ret|= checkOut.isChecked?1<<8:0;
                ret |= 3<<9;
                ret |= whenChange.isChecked ? 1 << 11 : 0;
                return ret;
            }
            configNameWidth: 40
        }
    }
    Component.onCompleted: {
        bindActionDefine(ExtentActionDefine.extentSafeRangeAction);
    }
}
