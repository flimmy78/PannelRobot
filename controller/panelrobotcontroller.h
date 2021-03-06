#ifndef PANELROBOTCONTROLLER_H
#define PANELROBOTCONTROLLER_H

#include <QObject>
#include <QMap>
#include <QSettings>
#include <QApplication>
#include "icrobotmold.h"
#include "icmachineconfig.h"
#include "icrobotvirtualhost.h"
//#include <QtDeclarative>
#include <QScriptEngine>
#include <QSharedPointer>
#include <QTimer>
#include <QFileSystemWatcher>
#include <QSplashScreen>
#include <QTranslator>
#include <QWidget>
#include "icdatatype.h"
#include "icparameterscache.h"
#include "qtquick1applicationviewer.h"
#include "icvirtualkeyboard.h"
#include "iclog.h"
#include "ictcptransceiver.h"

#ifndef Q_WS_WIN32
#ifndef Q_OS_MAC
#include <linux/input.h>
#endif
#endif


#ifdef Q_WS_QWS
#include <QWSScreenSaver>


class ScreenFunctionObject: public QObject
{
    Q_OBJECT
public:
    void ScreenSave() { emit ScreenSaved();}
    void ScreenRestore() { emit ScreenRestored();}

Q_SIGNALS:
    void ScreenSaved();
    void ScreenRestored();
};

class ICDefaultScreenSaver:public QWSScreenSaver
{
public:
    ~ICDefaultScreenSaver()
    {
        if(screenFunctionObject_ != NULL)
        {
            delete screenFunctionObject_;
        }
    }

    void restore()
    {
        qDebug("SimpleScreenSaver::restore");
        QWSServer::instance()->refresh();
        //        ICPeripherals::ICBacklightOn();
        if(screenFunctionObject_ != NULL)
        {
            screenFunctionObject_->ScreenRestore();
        }
    }

    bool save(int level)
    {
        Q_UNUSED(level)
        qDebug("SimpleScreenSaver::save");
        //        ICPeripherals::ICBacklightOff();
        //        ICPeripherals::ICShowScreenSaver();
        if(screenFunctionObject_ != NULL)
        {
            screenFunctionObject_->ScreenSave();
        }
        return true;
    }

    void SetScreenFunction(ScreenFunctionObject* o) {screenFunctionObject_ = o;}

private:
    ScreenFunctionObject* screenFunctionObject_;
};
#endif

union PullyData{
    struct{
        quint32 type:8;//< 类型
        quint32 lenth:8;//< 单位长度
        quint32 res:15;//< 预留
        quint32 en:1;//< 使能
    }b;
    quint32 all;
};

union QKCmdData{
    struct {
        quint32 cmd:4;  //< 命令
        quint32 id:4; //< 轴地址
        quint32 addr:8; //< 地址
        quint32 data:16; //< 数据
    }b;
    quint32 all;
};

union AutoRunData{
    struct{
        quint32 mode:16;
        quint32 programIndex:16;
    }b;
    quint32 all;
};


static QString ErrInfoToJSON(const QMap<int, int>& errInfo)
{
    QString ret = "[";
    QMap<int, int>::const_iterator p = errInfo.constBegin();
    while(p != errInfo.constEnd())
    {
        ret += QString("{\"line\": %1, \"errno\": %2},").arg(p.key()).arg(p.value());
        ++p;
    }
    if(!errInfo.isEmpty())
        ret.chop(1);
    ret += "]";
    return ret;
}

extern ICRange ICRobotRangeGetter(const QString& addrName);

typedef union{
    struct {
        unsigned    s1 : 2;
        unsigned    s2 : 2;
        unsigned    s3  : 2;
        unsigned    s4 : 2;
        unsigned    s5 : 2;
        unsigned    s6  : 2;
        unsigned    s7  : 2;
        unsigned    s8  : 2;
        unsigned    rev: 16;
    }b;
    quint32 a;
}AxisDefineData;

class ICAxisDefine:public QObject
{
    Q_OBJECT
    Q_ENUMS(AxisName)
    Q_ENUMS(AxisType)
    Q_PROPERTY(AxisType s1Axis READ s1Axis WRITE setS1Axis NOTIFY s1AxisChanged)
    Q_PROPERTY(AxisType s2Axis READ s2Axis WRITE setS2Axis NOTIFY s2AxisChanged)
    Q_PROPERTY(AxisType s3Axis READ s3Axis WRITE setS3Axis NOTIFY s3AxisChanged)
    Q_PROPERTY(AxisType s4Axis READ s4Axis WRITE setS4Axis NOTIFY s4AxisChanged)
    Q_PROPERTY(AxisType s5Axis READ s5Axis WRITE setS5Axis NOTIFY s5AxisChanged)
    Q_PROPERTY(AxisType s6Axis READ s6Axis WRITE setS6Axis NOTIFY s6AxisChanged)
    Q_PROPERTY(AxisType s7Axis READ s7Axis WRITE setS7Axis NOTIFY s7AxisChanged)
    Q_PROPERTY(AxisType s8Axis READ s8Axis WRITE setS8Axis NOTIFY s8AxisChanged)

signals:
    void s1AxisChanged(int);
    void s2AxisChanged(int);
    void s3AxisChanged(int);
    void s4AxisChanged(int);
    void s5AxisChanged(int);
    void s6AxisChanged(int);
    void s7AxisChanged(int);
    void s8AxisChanged(int);
public:
    ICAxisDefine(){}
    enum AxisName
    {
        S1Axis,
        S2Axis,
        S3Axis,
        S4Axis,
        S5Axis,
        S6Axis,
        S7Axis,
        S8Axis
    };
    enum AxisType
    {
        NoUse,
        Servo,
        Pneumatic,
        Reserve
    };

    AxisType s1Axis() const{ return static_cast<AxisType>(data_.b.s1);}
    void setS1Axis(AxisType type) { data_.b.s1 = type;}
    AxisType s2Axis() const{ return static_cast<AxisType>(data_.b.s2);}
    void setS2Axis(AxisType type) { data_.b.s2 = type;}
    AxisType s3Axis() const{ return static_cast<AxisType>(data_.b.s3);}
    void setS3Axis(AxisType type) { data_.b.s3 = type;}
    AxisType s4Axis() const{ return static_cast<AxisType>(data_.b.s4);}
    void setS4Axis(AxisType type) { data_.b.s4 = type;}
    AxisType s5Axis() const{ return static_cast<AxisType>(data_.b.s5);}
    void setS5Axis(AxisType type) { data_.b.s5 = type;}
    AxisType s6Axis() const{ return static_cast<AxisType>(data_.b.s6);}
    void setS6Axis(AxisType type) { data_.b.s6 = type;}
    AxisType s7Axis() const{ return static_cast<AxisType>(data_.b.s7);}
    void setS7Axis(AxisType type) { data_.b.s7 = type;}
    AxisType s8Axis() const{ return static_cast<AxisType>(data_.b.s8);}
    void setS8Axis(AxisType type) { data_.b.s8 = type;}

    int getAxisDefine(int which)
    {
        return (data_.a >> (which << 1)) & 3;
    }
    void setAxisDefine(int which, int mode)
    {
        data_.a &= ~(3 << (which << 1));
        data_.a |= (mode << (which << 1));
    }

private:
    AxisDefineData data_;
};

struct MoldMaintainRet
{
    MoldMaintainRet():err(0){}
    enum MoldErr{
        kME_None,
        kME_InvalidMolds,
        kME_USBNotFound,
        kME_UnknowError,
    };

    int err;
    QString name;
    QString ToJSON() const
    {
        return QString("{\"name\":\"%1\", \"err\":%2}").arg(name).arg(err);
    }
};

class PanelRobotController : public QObject
{
    Q_OBJECT
public:

    explicit PanelRobotController(QSplashScreen* splash, ICLog* logger = NULL, QObject *parent = 0);
    ~PanelRobotController();
    void Init();

    Q_INVOKABLE bool isInputOn(int index, int board) const
    {
        //        return rand() % 2;
        quint32 iStatus = ICRobotVirtualhost::IStatus(board);
        return iStatus & (1 << index);
    }
    Q_INVOKABLE bool isOutputOn(int index, int board) const
    {
        //        return rand() % 2;
        quint32 oStatus = ICRobotVirtualhost::OStatus(board);
        return oStatus & (1 << index);
    }
    Q_INVOKABLE void sendKeyCommandToHost(int key);
    Q_INVOKABLE void sendKnobCommandToHost(int knob);
    Q_INVOKABLE quint32 getConfigValue(const QString& addr) const;
    Q_INVOKABLE QString getConfigValueText(const QString& addr) const;
    Q_INVOKABLE double getRealConfigValue(const QString& addr) const
    {
        return getConfigValueText(addr).toDouble();
    }
    Q_INVOKABLE bool isAutoMode() const { return currentMode() == CMD_AUTO;}
    Q_INVOKABLE bool isAutoRunning() const { return currentMode() == CMD_RUNNING;}
    Q_INVOKABLE bool isInAuto() const
    {
        int m = currentMode();
        return (m == CMD_AUTO) || (m == CMD_RUNNING) || (m == CMD_ONE_CYCLE)
                || (m == CMD_SINGLE);
    }
    Q_INVOKABLE bool isOriginning() const { return currentMode() == CMD_ORIGIN_ING;}
    Q_INVOKABLE bool isOrigined() const { return statusValue("c_ro_0_1_0_938") == 1;}
    Q_INVOKABLE bool isReturnning() const { return currentMode() == CMD_RETURN_ING;}
    Q_INVOKABLE int currentMode() const { return statusValue("c_ro_1_4_0_938");}
    Q_INVOKABLE QString hostStepToUILines(int which, int step) const;
    Q_INVOKABLE QString currentRunningActionInfo(int which) const;
    Q_INVOKABLE int configDecimal(const QString& addr) const
    {
        QStringList item = addr.split("_", QString::SkipEmptyParts);
        return (item.size() == 6) ? item.at(4).toInt() : 0;
    }
    Q_INVOKABLE void setConfigValue(const QString& addr, const QString& v);
    Q_INVOKABLE void syncConfigs();
    Q_INVOKABLE QString records() const;
    Q_INVOKABLE ICAxisDefine* axisDefine();
    Q_INVOKABLE QString newRecord(const QString& name, const QString& initProgram, const QString& subPrograms = "[]");
    Q_INVOKABLE QString copyRecord(const QString& name, const QString& source)
    {
        return ICRobotMold::CopyRecord(name, source).toJSON();
    }

    Q_INVOKABLE bool deleteRecord(const QString& name)
    {
        return ICRobotMold::DeleteRecord(name);
    }

    Q_INVOKABLE QString readRecord(const QString& name) const;

    Q_INVOKABLE bool loadRecord(const QString& name);

    Q_INVOKABLE bool loadSysconfig(const QString& name)
    {
        ICMachineConfigPTR mold = ICMachineConfig::CurrentMachineConfig();
        bool ret =  mold->LoadMachineConfig(name);

        if(ret)
        {
            ICRobotVirtualhost::InitMachineConfig(host_,mold->BareMachineConfigs());
            ICSuperSettings as;
            as.SetCurrentSystemConfig(name);

            emit moldChanged();
        }

        return ret;

    }


    Q_INVOKABLE QString currentRecordName() const
    {
        return ICAppSettings().CurrentMoldConfig();
    }

    Q_INVOKABLE bool sendMainProgramToHost()
    {
        return ICRobotVirtualhost::SendMold(host_, ICRobotMold::CurrentMold()->ProgramToDataBuffer(0));
    }

    Q_INVOKABLE bool sendSubProgramToHost(int which)
    {
        if(which < ICRobotMold::kSub1Prog ||
                which > ICRobotMold::kSub8Prog)
            return false;
        return ICRobotVirtualhost::SendMoldSub(host_, which, ICRobotMold::CurrentMold()->ProgramToDataBuffer(which));

    }

    Q_INVOKABLE QString saveMainProgram(const QString& program)
    {
        QMap<int, int> ret =  ICRobotMold::CurrentMold()->SaveMold(ICRobotMold::kMainProg, program);
        //        if(ret == ICRobotMold::kCCErr_None)
        //        {
        //            ICRobotVirtualhost::SendMold(host_, ICRobotMold::CurrentMold()->ProgramToDataBuffer(0));
        //        }
        if(ret.isEmpty())
            modifyConfigValue(ICAddr_System_Retain_11, ICRobotMold::CurrentMold()->CheckSum());
        return ErrInfoToJSON(ret);
    }

    Q_INVOKABLE QString saveSubProgram(int which, const QString& program)
    {
        //        if(which < ICRobotMold::kSub1Prog ||
        //                which > ICRobotMold::kSub8Prog)
        //            return -1;
        QMap<int, int> ret =  ICRobotMold::CurrentMold()->SaveMold(which, program);
        //        if(ret == ICRobotMold::kCCErr_None)
        //        {
        //            ICRobotVirtualhost::SendMoldSub(host_, which, ICRobotMold::CurrentMold()->ProgramToDataBuffer(which));
        //        }
        if(ret.isEmpty())
            modifyConfigValue(ICAddr_System_Retain_11, ICRobotMold::CurrentMold()->CheckSum());
        return ErrInfoToJSON(ret);
    }

    Q_INVOKABLE bool fixProgramOnAutoMode(int which, int module,int line, const QString& lineContent);

    Q_INVOKABLE QString mainProgram() const
    {
        return ICRobotMold::CurrentMold()->MainProgram();
    }

    Q_INVOKABLE QString subProgram(int which) const
    {
        if(which < ICRobotMold::kSub1Prog ||
                which > ICRobotMold::kSub8Prog)
            return QString();
        return ICRobotMold::CurrentMold()->SubProgram(which);
    }
    Q_INVOKABLE QString programs(int which) const
    {
        if(which == ICRobotMold::kMainProg)
            return mainProgram();

        return subProgram(which);
    }
    Q_INVOKABLE QString stacks() const {return ICRobotMold::CurrentMold()->Stacks();}
    Q_INVOKABLE bool saveStacks(const QString& stacks){ return ICRobotMold::CurrentMold()->SaveStacks(stacks);}
    Q_INVOKABLE QString usbDirs();
    Q_INVOKABLE QString localUIDirs();
    Q_INVOKABLE void setToRunningUIPath(const QString& dirname);
    Q_INVOKABLE bool changeTranslator(const QString& translatorName);
    Q_INVOKABLE QString scanUSBUpdaters(const QString& filter) const;
    Q_INVOKABLE QString scanUpdaters(const QString& filter, int mode = 0) const;
    Q_INVOKABLE void startUpdate(const QString& updater, int mode = 0);
    Q_INVOKABLE QString backupUpdater(const QString& updater);

    Q_INVOKABLE void modifyConfigValue(int addr, int value);
    Q_INVOKABLE void modifyConfigValue(const QString& addr, const QString &value);
    Q_INVOKABLE int statusValue(const QString& addr) const;
    Q_INVOKABLE QString statusValueText(const QString& addr) const;

    Q_INVOKABLE int configsCheckSum(const QString& addrs) const;
    Q_INVOKABLE void loadHostMachineConfigs();

    Q_INVOKABLE QString scanUSBBackupPackages(const QString& filter) const;

    Q_INVOKABLE int exportRobotMold(const QString& molds, const QString &name) const;

    Q_INVOKABLE QString viewBackupPackageDetails(const QString& package) const;

    Q_INVOKABLE QString importRobotMold(const QString& molds, const QString &backupPackage);

    Q_INVOKABLE bool setCurrentTranslator(const QString& name);

    Q_INVOKABLE QString getCustomSettings(const QString& key, const QVariant& defval, const QString& group = QString::fromLatin1("custom"))
    {
        QString ret;
        customSettings_.beginGroup(group);
        ret = customSettings_.value(key, defval).toString();
        customSettings_.endGroup();
        return ret;
    }

    Q_INVOKABLE void setCustomSettings(const QString& key,
                                       const QVariant& val,
                                       const QString& group = QString::fromLatin1("custom"),
                                       bool isSync = true)
    {
        customSettings_.beginGroup(group);
        customSettings_.setValue(key, val);
        customSettings_.endGroup();
        if(isSync)
            customSettings_.sync();
    }

    Q_INVOKABLE void setKeyTone(bool status)
    {
#ifndef Q_WS_WIN32
        int beepFD = open("/dev/szhc_beep", O_WRONLY);
        if(beepFD > 0)
        {
            ioctl(beepFD, 0, status ? 1 : 0);
            close(beepFD);
        }
#endif
    }

    Q_INVOKABLE void setBrightness(int brightness)
    {
        if(brightness > 0 && brightness <9)
            ::system(QString("BackLight.sh  %1").arg(brightness).toLatin1());
    }

    Q_INVOKABLE void closeBacklight()
    {
        system("BackLight.sh 0");
    }

    Q_INVOKABLE void setDatetime(const QString& datetime)
    {
        QDateTime dateTime = QDateTime::fromString(datetime, "yyyy/M/d h:m:s");
        if(dateTime.isValid())
        {
            ::system(QString("date -s %1 && hwclock -w").arg(dateTime.toString("yyyy.MM.dd-hh:mm:ss")).toLatin1());
        }
    }

    Q_INVOKABLE void setScreenSaverTime(int min)
    {
#ifdef Q_WS_QWS
        QWSServer::setScreenSaverInterval(min * 60000);
#endif
    }

    Q_INVOKABLE quint32 iStatus(int boardID) const  { return ICRobotVirtualhost::IStatus(boardID);}
    Q_INVOKABLE quint32 oStatus(int boardID) const { return ICRobotVirtualhost::OStatus(boardID);}

    Q_INVOKABLE void setYStatus(const QString& defineJson, bool isOn);

    Q_INVOKABLE void initValveDefines(const QString& defineJson);

    Q_INVOKABLE quint32 currentErrNum() const
    {
        return host_->HostStatusValue(&c_ro_0_32_0_932);
    }

    Q_INVOKABLE QString hostVersion() const { return ICRobotVirtualhost::HostVersion();}
    Q_INVOKABLE QString panelControllerVersion() const { return SW_VER;}
    Q_INVOKABLE QString controllerVersion() const {
        return panelControllerVersion() + "_" + hostVersion();
    }
    Q_INVOKABLE void recal() const
    {
        ::system("touch /home/szhc/recal && sync && reboot");
    }

    Q_INVOKABLE void logTestPoint(int type, const QString& axisDataJSON);

    Q_INVOKABLE bool isQWS() const
    {
#ifdef Q_WS_QWS
        return true;
#endif
        return false;
    }

    Q_INVOKABLE void swichPulseAngleDisplay(int mode)
    {
        modifyConfigValue(ICAddr_System_Retain_26, mode);
    }

    Q_INVOKABLE bool saveCounterDef(quint32 id, const QString& name, quint32 current, quint32 target);
    Q_INVOKABLE bool delCounterDef(quint32 id);
    Q_INVOKABLE QString counterDefs() const;

    Q_INVOKABLE bool saveVariableDef(quint32 id, const QString& name, const QString& unit, quint32 val, quint32 decimal);
    Q_INVOKABLE bool delVariableDef(quint32 id);
    Q_INVOKABLE QString variableDefs() const;

    Q_INVOKABLE QString functions() const
    {
        return ICRobotMold::CurrentMold()->Functions();
    }

    Q_INVOKABLE QString saveFunctions(const QString& functionsJSON, bool syncMold = true, bool sendToHost = true)
    {
        QMap<int, QMap<int, int> > ret =  ICRobotMold::CurrentMold()->SaveFunctions(functionsJSON, syncMold);
        QString toJSON = "{";
        QMap<int, QMap<int, int> >::const_iterator p = ret.constBegin();
        while(p != ret.constEnd())
        {
            toJSON += QString("\"%1\":").arg(p.key());
            toJSON += ErrInfoToJSON(p.value()) + ",";
            ++p;
        }
        if(!ret.isEmpty())
        {
            toJSON.chop(1);
        }
        toJSON += "}";
        if(sendToHost)
        {
            sendMainProgramToHost();
            for(int i = 0;  i<ICRobotMold::kSubEnd; ++i)
            {
                sendSubProgramToHost(i);
            }
        }
        return toJSON;
    }


    Q_INVOKABLE void usbNetInit()
    {
        system("/etc/init.d/net-init.sh");
    }

    Q_INVOKABLE void readCurrentKnobValue() const
    {
#ifndef Q_WS_WIN32
#ifndef Q_OS_MAC
        int keyFD_ = open("/dev/input/event1", O_RDWR);
        struct input_event inputEvent;
        inputEvent.type = EV_SYN; //__set_bit
        inputEvent.code = SYN_CONFIG;  //__set_bit
        inputEvent.value = 1;
        write(keyFD_,&inputEvent,sizeof(inputEvent));
        ::close(keyFD_);
#endif
#endif
    }

    Q_INVOKABLE void setMotorTestPulseNum(int pulse)
    {
        modifyConfigValue(ICAddr_System_Retain_23, pulse);
    }

    Q_INVOKABLE void manualRunProgram(const QString& program,
                                      const QString& stacks,
                                      const QString& counters,
                                      const QString& variables,
                                      const QString &functions,
                                      int channel = 10,
                                      bool sendKeyNow = true);


    Q_INVOKABLE QString checkProgram(const QString& program,
                                     const QString& stacks,
                                     const QString& counters,
                                     const QString& variables,
                                     const QString &functions);

    Q_INVOKABLE quint32 debug_GetAddrValue(int addr)
    {
        ICRobotVirtualhost::AddReadConfigCommand(host_, addr, 1);
        connect(host_.data(),
                SIGNAL(QueryFinished(int , const QVector<quint32>& )),
                this,
                SLOT(OnQueryStatusFinished(int, const QVector<quint32>&)),
                Qt::UniqueConnection);
        return readedConfigValues_.value(addr, -1);
    }

    Q_INVOKABLE QString debug_LogContent() const
    {
        if(logger_ == NULL)
            return QString();
        return logger_->LogContent();
    }

    Q_INVOKABLE QString disableImage(const QString& enabledImage);

    Q_INVOKABLE void setPullySpeed(int speed)
    {
        //        uint32_t type:8;//< 类型
        //        uint32_t lenth:8;//< 单位长度
        //        uint32_t res:15;//< 预留
        //        uint32_t en:1;//< 使能
        PullyData pD;
        pD.all = ICRobotVirtualhost::MultiplexingConfig(ICAddr_Read_Status33);
        pD.b.lenth = speed & 0xFF;
        modifyConfigValue(ICAddr_System_Retain_27, pD.all);

    }

    Q_INVOKABLE void setPullyAxis(int axis, int speed)
    {
        PullyData pD;
        //        pD.all = ICRobotVirtualhost::MultiplexingConfig(ICAddr_Read_Status33);
        pD.b.type = axis & 0xFF;
        pD.b.lenth = speed;
        modifyConfigValue(ICAddr_System_Retain_27, pD.all);
    }

    Q_INVOKABLE int getPullyAxis() const
    {
        PullyData pD;
        pD.all = ICRobotVirtualhost::MultiplexingConfig(ICAddr_Read_Status33);
        return pD.b.type;
    }

    Q_INVOKABLE void setAutoRunningMode(int which, int mode)
    {
        AutoRunData d;
        d.b.programIndex = which;
        d.b.mode = mode;
        modifyConfigValue(ICAddr_System_Retain_17, d.all);
    }

    Q_INVOKABLE void setSingleRunStart(int which, int module,int line)
    {
        QPair<int, int> stepInfo = ICRobotMold::CurrentMold()->UIStepToRealStep(which, module, line);
        //        ICMoldItem item = ICRobotMold::CurrentMold()->SingleLineCompile(which, module, line, lineContent,stepInfo);
        //        return ICRobotVirtualhost::FixProgram(host_, which, stepInfo.first, stepInfo.second, item);
        modifyConfigValue(ICAddr_System_Retain_18, stepInfo.first);
    }

    Q_INVOKABLE void setEth0Enable(bool en, int mode, const QString& localAddr, const QString& hostAddr, int hostPort)
    {
        if(en)
        {
#ifdef Q_WS_QWS
            ::system(QString("ifconfig eth0 up && ifconfig eth0 %1").arg(localAddr).toAscii());
#endif
            if(eth0Transceiver_.isNull())
            {
                eth0Transceiver_.reset( new ICTcpTransceiver());
            }
            if(eth0DataMonitor_.isNull())
            {
                eth0DataMonitor_.reset( new TCPCommunicateMonitor());
                //                eth0DataMonitor_->SetFilter(QRegExp("test\r\n"));
                connect(eth0DataMonitor_.data(),
                        SIGNAL(dataComeIn(QByteArray)),
                        SIGNAL(eth0DataComeIn(QByteArray)));
            }
            eth0Transceiver_->SetHostAddr(QHostAddress(hostAddr), hostPort);
            eth0Transceiver_->SetCommuncateMode(static_cast<ICTcpTransceiver::CommunicateMode>(mode));
            eth0Transceiver_->RegisterCommMonitor(eth0DataMonitor_.data());
            eth0Transceiver_->StartCommunicate();
        }
        else
        {
            eth0Transceiver_->StopCommunicate();
#ifdef Q_WS_QWS
            ::system("ifconfig eth0 down");
#endif
        }
    }

    Q_INVOKABLE void writeDataToETH0(const QByteArray& data)
    {
        eth0Transceiver_->WriteRawData(data);
    }

    Q_INVOKABLE void setETh0Filter(const QString& re)
    {
        eth0DataMonitor_->SetFilter(QRegExp(re));
    }

    Q_INVOKABLE void sendExternalDatas(const QString& dsData);

    Q_INVOKABLE quint32 getMultiplexingConfig(int addr)
    {
        return ICRobotVirtualhost::MultiplexingConfig(addr);
    }

    Q_INVOKABLE void runHardwareTest()
    {
        setWatchDogEnabled(false);
        ::system("chmod +x /usr/bin/run_boardtest.sh && run_boardtest.sh");
        setWatchDogEnabled(true);

    }

    Q_INVOKABLE void setWatchDogEnabled(bool en);

    Q_INVOKABLE QString getPictures() const;
    Q_INVOKABLE QString getPicturesPath(const QString& picName) const;
    Q_INVOKABLE void copyPicture(const QString &picName, const QString& to) const;

    Q_INVOKABLE QString usedSourceStacks() const
    {
        QMap<int, int> sids = ICRobotMold::CurrentMold()->UsedSourceStack();
        QString ret = "{";
        QMap<int, int>::const_iterator p = sids.constBegin();
        while(p != sids.constEnd())
        {
            ret += QString("\"%1\":\"%2\",").arg(p.key()).arg(p.value());
            ++p;
        }
        if(!sids.isEmpty())
            ret.chop(1);
        ret += "}";
        return ret;
    }

    Q_INVOKABLE QString scanUserDir(const QString& path, const QString& filter) const;
    Q_INVOKABLE QString scanMachineBackups(int mode) const;
    Q_INVOKABLE QString scanHMIBackups(int mode) const;
    Q_INVOKABLE QString scanGhostBackups(int mode) const;
    Q_INVOKABLE QString backupHMIBackup(const QString& backupName, const QString& sqlData) const;
    Q_INVOKABLE QString backupMRBackup(const QString& backupName) const;
    Q_INVOKABLE QString makeGhost(const QString& ghostName, const QString& hmiSqlData) const;
    Q_INVOKABLE int exportHMIBackup(const QString& backupName) const;
    Q_INVOKABLE int exportMachineBackup(const QString& backupName) const;
    Q_INVOKABLE int exportGhost(const QString& backupName) const;
    Q_INVOKABLE int exportUpdater(const QString& updaterName) const;
    Q_INVOKABLE QString restoreHMIBackup(const QString& backupName, int mode);
    Q_INVOKABLE void restoreMRBackup(const QString& backupName, int mode);
    Q_INVOKABLE QString restoreGhost(const QString& backupName, int mode);
    Q_INVOKABLE void deleteHIMBackup(const QString& backupName, int mode);
    Q_INVOKABLE void deleteMRBackup(const QString& backupName, int mode);
    Q_INVOKABLE void deleteGhost(const QString& backupName, int mode);
    Q_INVOKABLE void deleteUpdater(const QString& updater, int mode);
    Q_INVOKABLE void reboot() { ::system("reboot");}

    Q_INVOKABLE void processEvents()
    {
        qApp->processEvents();
    }

    Q_INVOKABLE QString createCustomAddr(int type, int perm , int startPos, int size,
                                         int baseAddr, int decimal = 0, const QString &unit = QString())
    {
        ICAddrWrapperCPTR ca = new ICAddrWrapper(type, perm, startPos, size,
                                                 baseAddr, decimal, unit);
        return ca->ToString();

    }
    Q_INVOKABLE void registerCustomProgramAction(const QString& actionDefine);

    Q_INVOKABLE int registerUseTime(const QString& fc, const QString& mC, const QString& rcCode);
    Q_INVOKABLE QString generateMachineCode() const;
    Q_INVOKABLE int restUseTime() const;
    Q_INVOKABLE void setRestUseTime(int hour);
    Q_INVOKABLE bool isTryTimeOver() const;

    Q_INVOKABLE QString factoryCode() const
    {
        return ICSuperSettings().FactoryCode();
    }

    Q_INVOKABLE void setFactoryCode(const QString& fc)
    {
        ICSuperSettings().SetFactoryCode(fc);
    }

    Q_INVOKABLE void writeQKConfig(int axis, int addr, int data, bool ep = false);

    Q_INVOKABLE void readQKConfig(int axis, int addr, bool ep = false);

    //    Q_INVOKABLE QString debug_LogContent() const
    //    {
    //        if(logger_ == NULL)
    //            return QString().split("\n");
    //        return logger_->LogContent().split("\n");
    //    }

    void InitMainView();

    //    QDeclarativeView* MainView() { return mainView_;}
    QWidget* MainView()
    {
#ifdef QT5
        QWidget *container = QWidget::createWindowContainer(mainView_);
        return container;
#else
        return mainView_;
#endif
    }

signals:
    //    void currentMoldChanged(QString);
    //    void currentMachineConfigChanged(QString);
    void moldChanged();
    void screenSave();
    void screenRestore();
    void machineConfigChanged();
    void LoadMessage(const QString&);
    void eth0DataComeIn(const QByteArray& data);
    void sendingContinuousData();
    void sentContinuousData(int);
    void needToInitHost();
    void tryTimeOver();
    void readQKConfigFinished(int data);
public slots:
    void OnNeedToInitHost();
    void OnConfigRebase(QString);
    void OnQueryStatusFinished(int addr, const QVector<quint32>&v);
    void OnkeyCheckTimeOut();

private slots:
    void OnHostUpdateFinished(QString);
    void OnWatchDogTimeOut();

private:
    void InitDatabase_();
    void InitMold_();
    void InitMachineConfig_();
    bool LoadTranslator_(const QString& name);
    void SaveTranslatorName_(const QString& name);
    QVector<QVariantList> ParseCounters(const QString& counters);
    QVector<QVariantList> ParseVariables(const QString& variables);

    quint32 AddrStrValueToInt(ICAddrWrapperCPTR addr, const QString& value)
    {
        double v = value.toDouble();
        double diff = 5 * (v < 0 ? -1 : 1) / qPow(10, addr->Decimal() + 1);
        v += diff;
        qint32 ret = v * qPow(10, addr->Decimal());
        return static_cast<quint32>(ret);
    }

    ICVirtualHostPtr host_;
    bool isMoldFncsChanged_;
    bool isMachineConfigsChanged_;
    ICAddrWrapperValuePairList moldFncModifyCache_;
    ICAddrWrapperValuePairList machineConfigModifyCache_;
    ICAxisDefine *axisDefine_;
    QList<QPair<int, quint32> > baseFncs_;
    QScriptEngine engine_;
    QScriptValue configRangeGetter_;
    QTranslator translator;
    QTranslator panelRoboTranslator_;
    QTimer keyCheckTimer_;
    QSettings customSettings_;
    QString valveDefineJSON_;
    QtQuick1ApplicationViewer *mainView_;
    ICVirtualKeyboard virtualKeyboard;
    QFileSystemWatcher hostUpdateFinishedWatcher_;
    QMap<int, quint32> readedConfigValues_;
    ICLog* logger_;
    QTimer watchDogTimer_;

    QScopedPointer<ICTcpTransceiver> eth0Transceiver_;
    QScopedPointer<TCPCommunicateMonitor> eth0DataMonitor_;


#ifdef Q_WS_QWS
    ICDefaultScreenSaver* screenSaver_;
#endif
};

#endif // PANELROBOTCONTROLLER_H
