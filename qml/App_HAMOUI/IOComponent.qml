import QtQuick 1.1
import "configs/IODefines.js" as IODefines
//import "AppSettings.js" as UISettings
import "../ICCustomElement"
import "IOComponent.js" as PData
Rectangle {
//    QtObject{
//        id:PData
//        property string currentLanguage: UISettings.AppSettings.prototype.currentLanguage()

////        property type name: value
//    }

    Row{
        id:menuContainer
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 2
        z:1
        ICButton{
            id:prev
            text: qsTr("Prev")
            width: 60
            onButtonClicked: {
                var currentTypeInfo = PData.ioViewsInfo[ioType.currentIndex];
                var cur = ioContaner.currentIndex;
                --cur;
                if(cur < currentTypeInfo.start)
                    cur = currentTypeInfo.start + currentTypeInfo.count - 1;
                ioContaner.setCurrentIndex(cur)
            }

        }


        ICComboBox{
            id:ioType
            items: [qsTr("Input"), qsTr("Output"), qsTr("M")]
            height: next.height
            currentIndex: 0
            onCurrentIndexChanged: {
                ioContaner.setCurrentIndex(PData.ioViewsInfo[currentIndex].start);
            }
        }

        ICButton{
            id:next
            text: qsTr("Next")
            width: 60
            onButtonClicked: {
                var currentTypeInfo = PData.ioViewsInfo[ioType.currentIndex];
                var cur = ioContaner.currentIndex;
                ++cur;
                if(cur >= currentTypeInfo.start + currentTypeInfo.count)
                    cur = currentTypeInfo.start;
                ioContaner.setCurrentIndex(cur)
            }

        }
    }
    ICStackContainer{
        id:ioContaner
        anchors.top: menuContainer.bottom
        anchors.topMargin: 10
        function ioDefinesToViewDefines(defs, startIndex){
            var ret = [];
            var def;
            for(var i = 0 ; i < defs.length; ++i){
                def = defs[i]
                ret[i] = {"pointNum":def.pointName,
                    "index":i + startIndex,
                    "descr":def.descr
                };
            }
            return ret;
        }

        function generatePageBaseDefines(defs,type){
            var ioView = Qt.createComponent('IOComponentView.qml');
            var ret = [];
            var ioBoardCount = panelRobotController.getConfigValue("s_rw_22_2_0_184");
            if(ioBoardCount == 0)
                ioBoardCount = 1;
            if (ioView.status === Component.Ready){
                var l = Math.min(ioBoardCount * 32, defs.length);
                var pageCount = Math.ceil(l / 8);
                for(var i = 0; i < pageCount; ++i){
                    ret[i] = ioView.createObject(ioContaner,
                                                 {"ioDefines":ioDefinesToViewDefines(defs.slice(i * 8, (i + 1) * 8), i * 8), "type":type})
                }
            }
            return ret;
        }

        function appendPagesToContainer(pages, pageType, start){
            PData.ioViewsInfo[pageType] = {"start":start, "count":pages.length};
            for(var i = 0; i < pages.length; ++i){
                ioContaner.addPage(pages[i]);
            }
        }

        Component.onCompleted: {
            var xDefs = IODefines.xDefines;
            var yDefs = IODefines.yDefines;
            var mDefs = IODefines.mYDefines;

            PData.xPages = generatePageBaseDefines(xDefs, IODefines.IO_TYPE_INPUT);
            var lastLength = PData.xPages.length;
            appendPagesToContainer(PData.xPages, 0, 0);

            PData.yPages = generatePageBaseDefines(yDefs, IODefines.IO_TYPE_OUTPUT);
            appendPagesToContainer(PData.yPages, 1, lastLength);
            lastLength += PData.yPages.length;

            PData.mPages = generatePageBaseDefines(mDefs, IODefines.IO_TYPE_OUTPUT);
            appendPagesToContainer(PData.mPages, 2, lastLength);

            ioContaner.setCurrentIndex(0)
        }
    }
    Timer{
        interval: 50; running: visible; repeat: true;
        onTriggered: {
            var xStatus = panelRobotController.iStatus(0).toString(2).split("").reverse().join("");
            var yStatus = panelRobotController.oStatus(0).toString(2).split("").reverse().join("");
            var i;
            for(i = 0; i < PData.xPages.length; ++i){
                PData.xPages[i].status = xStatus;
            }
            for(i = 0; i < PData.yPages.length; ++i){
                PData.yPages[i].status = yStatus;
            }
            yStatus = panelRobotController.oStatus(4).toString(2).split("").reverse().join("");
            for(i = 0; i < PData.mPages.length; ++i){
                PData.mPages[i].status = yStatus;
            }

        }
    }
}
