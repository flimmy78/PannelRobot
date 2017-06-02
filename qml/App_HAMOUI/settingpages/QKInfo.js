.pragma library

var qkParaInfo =
[/**/
    {"name":qsTr("PwmPeriod"),          "addr":0,"wVal":1999,   "decs":qsTr("1.Parameter initial value: 1999, whether to modify: No.2.[15:0] PWM cycle, range: 1~4095.3. Description: IGBT switching frequency (Hz) and the system clock frequency of =0.5* / (PwmPeriod+1). When PwmMode=0, the non symmetric mode, current loop sampling frequency =2* switching frequency: when pwmMode=1, symmetric mode, current loop sampling frequency = switching frequency.")},
    {"name":qsTr("SampleStartDelay"),   "addr":1,"wVal":10,     "decs":qsTr("1.parameter initial value: 10, whether to modify: No.2.[15:0] A/D sampling delay, value range: 0~255.3.: A/D sampling delay time (NS) = system master clock cycle *SampleStartDelay.")},
    {"name":qsTr("SpdPosLpRate"),       "addr":2,"wVal":516,    "decs":qsTr("1.parameter initial value: 516, whether to modify: No.2.[7:0] no need to modify the speed loop sampling frequency ratio, range: 1~255, [15:8] position loop sampling frequency ratio, range: 1~255.3. Description: speed loop sampling frequency (Hz) = current loop position loop sampling frequency /SpdLpRate; sampling frequency (Hz) = speed loop sampling frequency /PosLpRate.")},
    {"name":qsTr("ModScl"),             "addr":3,"wVal":3000,   "decs":qsTr("1.parameter initial value: 3000, whether to modify: No.2.[15:0] SVPWM calibration factor, value range: 0~4095.3.: ModScl=3 * (PwmPeriod+1) /2.")},
    {"name":qsTr("PwmDeadTm"),          "addr":4,"wVal":119,    "decs":qsTr("1.parameter initial value: 119, whether to modify: No,.2.[15:0] value range: 0~255.3.: IGBT dead time (NS) = system master clock cycle (NS) * (PwmDeadTm+1) cycle(ns)×(PwmDeadTm+1)")},
    {"name":qsTr("SystemConfig"),       "addr":5,"wVal":24,     "decs":qsTr("1.parameter initial value: 24,whether to modify: No.2.[0]: the main power supply is off monitoring enable, range: 0~1 [1]; DC bus voltage compensation enable, range: 0~1; [2] radiator over temperature protection effective level, range: 0~1; [3] regenerative braking effective level, range: 0~1; [4]PWM mode limit range: 0~1; [15:5] is not defined, the range of.3.: any value: MPwrOffMonEnbl, DcBusCompEnbl:0- from this function, 1- allows the function; OvrTempSns, RegenBrkSns:0- active low 1-, high effective; asymmetric PwmMode:0- type, 1- type symmetry.")},
    {"name":qsTr("LvAlmMonEnbl"),       "addr":6,"wVal":0,      "decs":qsTr("1.parameter initial value: 0, whether to modify: No.2.[15:0] undervoltage alarm enable, value range: 0~1.3. Description: 0- prohibit undervoltage alarm function, 1- allows undervoltage alarm function")},
    {"name":qsTr("DcBusOffset"),        "addr":7,"wVal":0,      "decs":qsTr("1.parameter initial value: 0, whether to modify: No.2.[15:0] DcBusOffset, value range: 0~4095.3.: DcBusOffset= DC bus voltage is equal to zero, corresponding to the A/D conversion data")},
    {"name":qsTr("BusConfig"),          "addr":8,"wVal":4864,   "decs":qsTr("1.parameter initial value: 4864,whether to modify: No.2.[7:0] the local node number ID, range: 0~255; [10:8] communication baud rate selection, range: 0~7, [12:11]; parity range: 0~3; [15:13] is not defined, range:.3. Description: any value node ID number of current LocalId: system; ParitySelect:0/3- no parity, parity BuadSelect:0-9.6kHz, 1-19.2kHz 1-; 2-57.6kHz, 3-115.2kHz, 4-250kHz, 5-500kHz, 6-800kHz, 7-1MHz..")},
/**/
    {"name":qsTr("DriverCtrl"),         "addr":16,"wVal":7,     "decs":qsTr("1.parameter initial value: 7,whether to modify: No.2.[0] the relay driver effective level, range: 0~1; [1] arm IGBT gate drive effective level, range: 0~1; [2] arm IGBT gate drive effective level, range: 0~1; [3]IGBT fault clearing level, range: 0~1; [4]IGBT overcurrent protection effective level, range: 0~1; [5]IGBT over temperature protection effective level, range: 0~1; [6]U phase current polarity inversion, range: 0~1; [7]W phase current polarity inversion, range: 0~1 [8]; current phase inverted, range: 0~1; [15:9] is not defined range:.3., any value: Sns:0- active low 1- high effective; Inv:0- does not take anti 1-, anti.")},
    {"name":qsTr("DBCtrl"),             "addr":17,"wVal":2916,  "decs":qsTr("1.parameter initial value: 2916,whether to modify: No.2.[7:0]: the dynamic brake delay range: 0~255; no dynamic brake, [8] main power shutdown range: 0~1; no dynamic brake, [9] servo OFF range: 0~1; [10] fault alarm when the prohibition of dynamic brake, range: 0~1; no dynamic brake, [11] process range: 0~1; [15:12] is not defined, any value value range:.3. Description: dynamic brake delay -DBRlyDelayx1ms, Inh:0- allows DB action, 1- banned DB action.")},
    {"name":qsTr("BrkCtrl"),            "addr":18,"wVal":25700, "decs":qsTr("1.parameter initial value: 25700,whether to modify: No.2.[7:0] the brake open delay, range: 0~255; [15:8] brake delay, range: 0~255.3. Description: brake open delay brake delay =SOffToBOnDelayx1ms. =BrkRlyDelayx1ms;")},
    {"name":qsTr("InPortCtrl"),         "addr":19,"wVal":2194,  "decs":qsTr("1.parameter initial value: 2194,whether to modify: No.2.[0] the servo ON effective level, range: 0~1; [1] alarm clearing level range: 0~1; [3:2] alarm clear reuse range: 0~3; [4] ultra positive effective level, range: 0~1; [6:5] positive super port reuse range: [7], 0~3; reverse overtravel effective level, range: 0~1; [9:8] reverse overtravel port multiplexing, range: 0~3; range of [10] travel direction: 0~1; the [11] command cleared effective level range: 0~1; [13:12] command cleared port multiplexing, range: 0~3; [15:14] is not defined that range: any value. Note: Sns:0- active low 1-, high effective; TrvIDir:0- motor counter clockwise when the stroke is the right direction, 1- motor rotates clockwise travel to a positive direction; AlmRstFunc:0- alarm Clear, 1~2- is not defined, 3- pulse position commands are prohibited; POTFunc:0- is super, 1~2 is not defined, 3- pulse position commands are prohibited; reverse NOTFunc:0- over range, 1~2 is not defined, 3- pulse position command prohibition; CmdRstFunc:0- position deviation counter reset, 1- zero speed clamp, 2- is not defined, 3- pulse the position command is prohibited.")},
    {"name":qsTr("OutPortConfig"),      "addr":20,"wVal":521,   "decs":qsTr("1.parameter initial value: 521,whether to modify: No.2.[0] the servo ready effective level, range: 0~1; [2:1] servo ready port multiplexing, range: 0~3; [3] brake open effective level, range: 0~1; [5:4] brake open port multiplexing, range: 0~3; [6] alarm output level range: [8:7], 0~1; alarm output port multiplexing, range: 0~3; [9] complete the effective level, range: 0~1; [11:10] completion port reuse, range: 0~3; [15:12] is not defined, the range of any value; note: Sns:0- low level; RdyFunc:0- servo ready, 1- torque limit in 2-, the speed limit in 3- software; HldBrkFunc:0- brake open, 1~3- is not defined; AlmFunc:0- alarm output, 1~3- is not defined; the CoinFunc:0- definition, 1- zero speed, 2~3- Definition.")},
    {"name":qsTr("SystemCtrl"),         "addr":21,"wVal":7,     "decs":qsTr("1.parameter initial value: 7,whether to modify: No.2.[0] the ON servo control source, range: 0~1; [1] encoder enable control range: 0~1; [2] axis enable control range: 0~1; [3] type motor, range: 0~1; [15:4] is not defined, the range of arbitrary values:.3. Description: ExtCtrl:0- ON RS422 1- by servo control, servo control by PLC ON; EncEnbl:0- 1- encoder encoder is prohibited, normal work; AxisEnbl:0- axis current is prohibited, the current 1- axis normal work; MtrType:0-PMSM, 1-IM.")},
    {"name":qsTr("ModelControl"),       "addr":22,"wVal":0,     "decs":qsTr("1.parameter initial value: 0,whether to modify: No.2.[1:0] the torque command source, range: 0~3; [3:2] speed command source, range: 0~3; [4] speed ramp command source, range: 0~1; [5] position command source, range: 0~1; [6] position feedback source, the value range: 0~1; [15:7] is not defined, the range of values: any.3. Description: IqRefSel:0- speed loop output, 1- digital given, 2- analog voltage, 3-0; SpdRefSel:0- position loop output, 1- slope is given, 2- digital given, 3- analog voltage; RampRefSel:0- digital given, 1- analog voltage; PosRefSel:0- pulse is given, 1- digital given PosFbkSel:0- rotation; 1- linear encoder, grating.")},
    {"name":qsTr("CmdControl"),         "addr":23,"wVal":7,     "decs":qsTr("1.parameter initial value: 7,whether to modify: No.2.[1] the position command enable, range: 0~1; [1] command pulse mode, range: 0~1; [2] command pulse edge selection, range: 0~1; [3] command pulse logic inversion, range: 0~1; [4] simulation command polarity inversion, range: 0~1; [15:5] is not defined, range:.3. Description: PosCmdEnbl:0- arbitrary value position command pulse is invalid, 1- position command pulse; PosCmdMode:0-Quadrature mode, and pulse is X4,1-Pulse/sign mode and pulse is X1; PosCmdEdge: the falling edge effectively, the rising edge of 1-; PosCmdInv:0- position command pulse not inverted, 1- position take the command pulse; AnlgRefInv:0- not inverted, 1- inverted")},
    {"name":qsTr("VCmdOffset"),         "addr":24,"wVal":0,     "decs":qsTr("1.parameter initial value: 0, whether to modify: No.2.[15:0] simulation command offset, value range: -32767~32767.3.: VCmd_Offset= analog command voltage equal to zero, corresponding to the A/D conversion data")},
    {"name":qsTr("RotEnControl"),       "addr":25,"wVal":33,    "decs":qsTr("1.parameter initial value: 33, whether to modify: No.2.[0] Z encoder pulse enable, range: 0~1; [1] velocity pulse selection, range: 0~1; [3:2] velocity pulse edge selection, range: 0~1; [4] reverse rotation, range: 0~3; polarity, Z pulse [5] rotary encoding device range: 0~1; [6] line type incremental encoder, range: 0~1; [15:7] is not defined, the range of.3. value: any description: ZPulsEnbl:0- ban, 1- allows the EncPhsMux:0-A phase, 1-B phase;")},
    {"name":qsTr("RotEncMaxCnt"),       "addr":26,"wVal":16383, "decs":qsTr("1.parameter initial value: 16383, whether to modify: No.2.[15:0] incremental encoder line number, value range: 0~65535.3.: RotEnc_MaxCnt=4 * PPR-1, where PPR is the encoder, each phase of each turn of the pulse")},
    {"name":qsTr("RotEncZCnt"),         "addr":27,"wVal":1250,  "decs":qsTr("1.parameter initial value: 1250, whether to modify: No,.2.[15:0] incremental encoder line number, value range: 0~65535.3.: Z pulse relative to U opposite potential, negative to zero point of electric angle")},
    {"name":qsTr("LnrEncCtrl"),         "addr":28,"wVal":2,     "decs":qsTr("1.parameter initial value: 2, whether to modify: No.2.[0] the linear encoder RP, range: 0~1; polarity, Z pulse [1] linear encoder range: 0~1; [15:2] is not defined, range:.3. Description: LnrEncInv:0- is not an arbitrary value counter, 1- counter; LnrEncZPol:0- negative, 1- positive.")},
    {"name":qsTr("EncDivCtrl"),         "addr":29,"wVal":9,     "decs":qsTr("1.parameter initial value: 9, whether to modify: No.2.[0] encoder output enable frequency, range: 0~1; [1] output pulse source, range: 0~1; [2] output pulse inversion, range: 0~1; polarity [3] Z pulse output range: 0~1; [15:4] is not defined, the range: 0~1.3. Description: EncDivEnbl:0- ban, 1- allows EncDivSrc:0-; rotary encoder, 1- linear grating; EncDivInv:0-A phase advance in the B phase, 1-A phase lag in B phase; EncDivZPol:0- negative, 1- positive.")},
    {"name":qsTr("EncDivNum"),          "addr":30,"wVal":1,     "decs":qsTr("1.parameter initial value: 1, whether to modify: No.2.[15:0] encoder output pulse frequency than the range of molecules: 1~65535.3. Description: EncDiv_Num/EncDiv_Den = 1; otherwise, the output pulse is uncertain.")},
    {"name":qsTr("EncDivDen"),          "addr":31,"wVal":1,     "decs":qsTr("1.parameter initial value: 1, whether to modify: No.2.[15:0] encoder output pulse frequency than the denominator, range: 1~65535.3. EncDiv_Num/EncDiv_Den = 1; otherwise, the output pulse is uncertain.")},
/*current loop*/
    {"name":qsTr("IfbU_Offset"),        "addr":48,"wVal":0,     "decs":qsTr("1.parameter initial value: 0, whether to modify: No.2.[15:0] U phase current offset, value range: -2047~2047.3.: IfbU_Offset=U phase current equal to zero, corresponding to the A/D conversion data")},
    {"name":qsTr("IfbW_Offset"),        "addr":49,"wVal":0,     "decs":qsTr("1.parameter initial value: 0, whether to modify: No.2.[15:0] W phase current offset, value range: -2047~2047.3.: IfbW_Offset=W phase current equal to zero, corresponding to the A/D conversion data")},
    {"name":qsTr("IdScl"),              "addr":50,"wVal":5148,  "decs":qsTr("1.parameter initial value: 5148, whether to modify: Yes, suggestion: calculated according to the description of the formula, where MHC is the maximum range of the current sensor, a circle, MHC=24, the two time round, MHC=12, the three time round, MHC=8.2.[15:0]D axis current calibration factor, range: 0~65535.3. Description: for PMSM, IdScl=MHC (2048 * 4096 * 2^10/ * SQRT * Irated * 1.64676 (2)), where MHC is the maximum range of ideal current sensor, Irated rated current value.")},
    {"name":qsTr("Iqscl"),              "addr":51,"wVal":5148,  "decs":qsTr("1.parameter initial value: 5148, whether to modify: Yes, suggestion: calculated according to the description of the formula, where MHC is the maximum range of the current sensor, a circle, MHC=24, the two time round, MHC=12, the three time round, MHC=8.2.[15:0]Q axis current calibration factor, range: 0~65535.3. Description: for PMSM, IqScl=MHC (2048 * 4096 * 2^10/ * SQRT * Irated * 1.64676 (2)), where MHC is the maximum range of ideal current sensor, Irated rated current value.")},
    {"name":qsTr("ElecAngScl"),         "addr":52,"wVal":4096,  "decs":qsTr("1.parameter initial value: 4096, whether to modify: Yes, suggestion: PPR=4096.2.[15:0] electric angle calibration factor, range: 0~65535.3. Description: ElecAngScl=P * 4096 * 2^12/ (4 * PPR), where P is the pole number, PPR for each phase of each turn from the encoder pulse number.")},
    {"name":qsTr("SlipGain"),           "addr":53,"wVal":0,     "decs":qsTr("1.parameter initial value: 0,whether to modify: No.2.[15:0] the motor slip gain range: 0~65535.3. Description: for IM, SlipGain=RatedSlipSpeed/RatedIqRef=2^24 * RatedSlipFreq (Hz) /CurrentLoopUpdateRate.")},
    {"name":qsTr("K1Notch"),            "addr":54,"wVal":65535, "decs":qsTr("1.parameter initial value: 65535,whether to modify: No.2.[15:0] the torque command notch filter constant 1, range: 32768~65535.3. Description: K1_Notch=k1 * 2^15, k1=1+a, a= (1-tan (Bw/2) (1+tan) / (Bw/2) Bw=2), pi * fb/fs, where FS is the current loop frequency, FB -3dB notch width; 1 = k1<2, K1, and when the 2 notch filter has no effect.")},
    {"name":qsTr("K2Notch"),            "addr":55,"wVal":0,     "decs":qsTr("1.parameter initial value: 0,whether to modify: No.2.[15:0] the torque command notch filter constant 2, range: 0~65535.3. Description: K2_Notch=k2 * 2^15, k2=b * (1+a), a= (1-tan (Bw/2) (1+tan) / (Bw/2) b=cos), Omega 0, Omega PI Bw=2 * fb/fs, 0=2 pi * f0/fs, where FS is the current loop sampling frequency, F0 notch center frequency, FB -3dB notch width; 0 = k2<2.")},
    {"name":qsTr("Ktf"),                "addr":56,"wVal":0,     "decs":qsTr("1.parameter initial value: 0,whether to modify: No.2.[15:0] the torque command low-pass filter constant, range: 0~65535.3. Description: Ktf=2^16 * (1-tan (c/2) (1+tan) / (omega Omega PI, c/2)) c=2 * fc/fs, where FS is the current loop sampling frequency, FC -3dB shear frequency.")},
    {"name":qsTr("OvrLdLim"),           "addr":57,"wVal":21845, "decs":qsTr("1.parameter initial value: 21845, whether to modify: No.2.[15:0] overload protection threshold, value range: 0~65535.3.: OvrLdLim=32768/coeff, coeff is overload factor, e.g. is set to 1.5 times the rated value, OvrLdLim=21845.")},
    {"name":qsTr("TrqLimp"),            "addr":58,"wVal":12288, "decs":qsTr("1.parameter initial value: 12288, whether to modify: No.2.[15:0] positive torque limit, range: 0~32767.3. Description: TrqLimP=4096 * MLC/ (SQRT (2) * Irated), where MLC is the maximum linear range of current sensor, Irated rated current value.")},
    {"name":qsTr("TrqLimN"),            "addr":59,"wVal":-12288,"decs":qsTr("1.parameter initial value: -12288, whether to modify: No.2.[15:0] reverse torque limit, range: -32767~-1.3. Description: TrqLimN=-4096 * MLC/ (SQRT (2) * Irated), where MLC is the maximum linear range of current sensor, Irated rated current value.")},
    {"name":qsTr("IErrLim"),            "addr":60,"wVal":1024,  "decs":qsTr("1.parameter initial value: 1024, whether to modify: No.2.[15:0] current loop controller, integral error limit, value range: 0~16383.3.: big deviation, small gain, small deviation, big gain")},
    {"name":qsTr("Kpid"),               "addr":61,"wVal":2000,  "decs":qsTr("1.parameter initial value: 2000, whether to modify: Yes, suggestion: according to the experience, the range of Kpid 100~1000, suggested the use of the initial value of.2.[15:0]D axis current loop controller proportional gain range: 0~65535.3. Description: 11 decimal places.")},
    {"name":qsTr("Kiid"),               "addr":62,"wVal":1500,  "decs":qsTr("1.parameter initial value: 1500, whether to modify: Yes, suggestion: according to the experience, the range of Kiid 100~1000, suggested the use of the initial value of integral gain,.2.[15:0]D axis current loop controller range: 0~65535.3. Description: 16 decimal places.")},
    {"name":qsTr("Kpiq"),               "addr":63,"wVal":2000,  "decs":qsTr("1.parameter initial value: 2000, whether to modify: Yes, suggestion: according to the experience, the range of Kpiq to 100~1000, and numerical Kpid, recommend the use of the initial value of.2.[15:0]Q axis current loop controller proportional gain range: 0~65535.3. Description: 11 decimal digits.")},
    {"name":qsTr("Kiiq"),               "addr":64,"wVal":1500,  "decs":qsTr("1.parameter initial value: 1500, whether to modify: Yes, suggestion: according to the experience, the range of Kpiq to 100~1000, and numerical Kiid, recommend the use of the initial value of integral gain,.2.[15:0]Q axis current loop controller range: 0~65535.3. Description: 16 decimal digits.")},
    {"name":qsTr("Ked"),                "addr":65,"wVal":0,     "decs":qsTr("1.parameter initial value: 0,whether to modify: No.2.[15:0] D axis: whether the back EMF constant, range: 0~65535.3. Description: for PMSM, Ked=8192 * P * MaxRPM * pi * Ls * SQRT (2) * Irated/ (15 x 1.64676 x 310), where P is the pole number, MaxRPM is the highest speed, Ls the motor winding inductance, Irated rated current value.")},
    {"name":qsTr("Keq"),                "addr":66,"wVal":0,     "decs":qsTr("1.parameter initial value: 0,whether to modify: No.2.[15:0] Q axis: whether the back EMF constant, range: 0~65535.3. Description: for PMSM, Ked=8192 * P * MaxRPM * * pi / psi (15 x 1.64676 x 310), where P is the pole number, MaxRPM is the highest speed, psi for permanent magnet motor rotor chain.")},
    {"name":qsTr("Ktg"),                "addr":67,"wVal":0,     "decs":qsTr("1.parameter initial value: 0, whether to modify: No.2.[15:0] torque simulation command weighting factor, value range: 0~65535.3. Description: Ktg=2^14 * (0~400%)")},
    {"name":qsTr("Krt"),                "addr":68,"wVal":0,     "decs":qsTr("1.parameter initial value: 0,whether to modify: No.2.[15:0] the induction motor rotor constant, range: 0~65535.3. Description: Krt=2^22/ (tr*fs), where FS is the current loop sampling frequency (Hz), TR for induction motor rotor time constant.")},
    {"name":qsTr("RatedFreq"),          "addr":69,"wVal":0,     "decs":qsTr("1.parameter initial value: 0, whether to modify: No.2.[15:0] induction motor rated frequency, value range: 0~65535.3.: RatedFreq=2^15*RatedRPM/MaxRPM.")},
    {"name":qsTr("VdLim"),              "addr":70,"wVal":6632,  "decs":qsTr("1.parameter initial value: 6632, whether to modify: No.2.[15:0] D axis, voltage modulation, system limits, value range: 0~6632.3.: VdLim=2^14 * D axis, maximum voltage regulation system /1.64676")},
    {"name":qsTr("VqLim"),              "addr":71,"wVal":6632,  "decs":qsTr("1.parameter initial value: 6632, whether to modify: No.2.[15:0] Q axis, voltage modulation, system limits, value range: 0~6632.3.: VqLim=2^14 * Q axis, maximum voltage regulation system /1.64676")},
    {"name":qsTr("OvrCrnt"),            "addr":72,"wVal":16384, "decs":qsTr("1.parameter initial value: 16384, whether to modify: No.2.[15:0] over-current protection threshold, value range: 0~65535.3. Description: maximum current setting, motor rated =4096.")},
/*speed loop*/
    {"name":qsTr("SpdScl"),             "addr":80,"wVal":3200,  "decs":qsTr("1.parameter initial value: 3200,whether to modify: No.2.[15:0] the speed of the scaling factor, range: 0~65535.3. Description: SpdScl=2^15 (4 x 60 x fclk/ x PPR x MaxRPM x 256), where fclk is the main system clock frequency, PPR encoder line number, MaxRPM is the highest speed.")},
    {"name":qsTr("NilMtrSpdDly"),       "addr":81,"wVal":30,    "decs":qsTr("1.parameter initial value: 30,whether to modify: No.2.[15:0] the motor zero velocity detection delay, range: 0~65535.3. Description: NilMtrSpdDly= speed loop sampling frequency (4 * 60/ * PPR * MinRPM), where PPR is the number of MinRPM encoder line, the minimum speed.")},
    {"name":qsTr("NilCmdSpdDly"),       "addr":82,"wVal":30,    "decs":qsTr("1.parameter initial value: 30, whether to modify: No.2.[15:0] DC pulse zero speed detection delay, value range: 0~65535.3.: NilCmdSpdDly=NilMtrSpdDly * electronic gear ratio")},
    {"name":qsTr("SpdCmp"),             "addr":83,"wVal":300,   "decs":qsTr("1.parameter initial value: 300, whether to modify: No.2.[15:0] speed measurement comparison of internal and the switching threshold value range: 0~32767.3. Description: SpdCmp=2^15 x 60 x speed loop sampling frequency / (PPR * MaxRPM), where PPR is the number of MaxRPM is the highest line encoder, speed.")},
    {"name":qsTr("ZeroSpeed"),          "addr":84,"wVal":1,     "decs":qsTr("1.parameter initial value: 1, whether to modify: No.2.[15:0] zero speed approval range, value range: 0~65535.3. Description: when the actual speed is less than MaxRPM * ZeroSpeed/2^15, considered at the speed of zero state")},
    {"name":qsTr("SpdAccRate"),         "addr":85,"wVal":256,   "decs":qsTr("1.parameter initial value: 256, whether to modify: No.2.[15:0] acceleration, value range: 0~65535.3. Description: 8 decimal places")},
    {"name":qsTr("SpdDecRate"),         "addr":86,"wVal":256,   "decs":qsTr("1.parameter initial value: 256, whether to modify: No.2.[15:0] deceleration, value range: 0~65535.3. Description: 8 decimal places")},
    {"name":qsTr("Kfg"),                "addr":87,"wVal":0,     "decs":qsTr("1.parameter initial value: 0, whether to modify: No.2.[15:0] speed feed-forward / analog command weighting factor, value range: 0~65535.3.: Kfg=2^14 * (0~400%)")},
    {"name":qsTr("Kff"),                "addr":88,"wVal":0,     "decs":qsTr("1.parameter initial value: 0, whether to modify: No.2.[15:0] the speed feedforward / analog low-pass filter command constant, range: 0~65535.3. Description: Kff=2^16 * (1-tan (c/2) (1+tan) / (omega Omega PI, c/2)) c=2 * fc/fs, where FS is the speed loop sampling frequency, FC -3dB shear frequency.")},
    {"name":qsTr("SpdLimP"),            "addr":89,"wVal":25000, "decs":qsTr("1.parameter initial value: 25000, whether to modify: No.2.[15:0] forward rev limit amplitude, value range: 0~32767.3.: SpdLimP=2^15 * (0~100%)")},
    {"name":qsTr("SpdLimN"),            "addr":90,"wVal":-25000,"decs":qsTr("1.parameter initial value: -25000, whether to modify: No.2.[15:0] reverse rev limit amplitude, value range: -32767~-1.3.: SpdLimN=-2^15 * (0~100%)")},
    {"name":qsTr("SpdErrLim"),          "addr":91,"wVal":25000, "decs":qsTr("1.parameter initial value: 25000, whether to modify: No.2.[15:0] speed loop controller, integral error limit, value range: 0~32767.3.: big deviation, small gain, small deviation, big gain")},
    {"name":qsTr("KpV"),                "addr":92,"wVal":100,   "decs":qsTr("1.parameter initial value: 100, whether to modify: Yes, suggestion: according to the experience, 10 < KpV < = 1000, the need to modify the.2.[15:0] speed loop controller proportional gain range according to the actual situation: 0~65535.3. Description: 5 decimal places.")},
    {"name":qsTr("KiV"),                "addr":93,"wVal":200,   "decs":qsTr("1.parameter initial value: 200, whether to modify: Yes, suggestion: according to the experience, 10 < KiV < = 1000, the need to modify the.2.[15:0] speed loop integral gain controller, according to the actual situation of the range: 0~65535.3. Description: 13 decimal places.")},
    {"name":qsTr("KfV"),                "addr":94,"wVal":65535, "decs":qsTr("1.parameter initial value: 65535, whether to modify: No.2.[15:0] speed loop controller, PDFF gain, value range: 0~65535.3.KfV=2^16 * (0~100%), which: 0-IP control, 100%-PI control, 0~100%-PDFF control")},
    {"name":qsTr("BrkZeroSpd"),         "addr":95,"wVal":100,   "decs":qsTr("1.parameter initial value: 100,whether to modify: No.2.[15:0] the brake zero speed range: 0~65535.3. Description: when the actual speed is less than MaxRPM * ZeroSpeed/2^15, turn off the brake signal.")},
/*position loop*/
    {"name":qsTr("PulsSclNum"),         "addr":112,"wVal":1,    "decs":qsTr("1.parameter initial value: 1, whether to modify: No.2.[15:0] electronic gear of the molecule: 0~65535.3.: 1/32768<PulsScl_Num/PulsScl_Den<1024.")},
    {"name":qsTr("PulsSclDen"),         "addr":113,"wVal":1,    "decs":qsTr("1.parameter initial value: 1, whether to modify: No.2.[15:0] electronic gear of the denominator: 0~65535.3.: 1/32768<PulsScl_Num/PulsScl_Den<1024.")},
    {"name":qsTr("PosErrOvrLim"),       "addr":114,"wVal":256,  "decs":qsTr("1.parameter initial value: 256, whether to modify: No.2.[15:0] position deviation is too large: 0~65535.3.: PosErrOvrLim limit of 256 * pulse equivalent")},
    {"name":qsTr("CoinLim"),            "addr":115,"wVal":10,   "decs":qsTr("1.parameter initial value: 10, whether to modify: No.2.[15:0] positioning completion range: 0~65535.3. Description: when the actual position deviation is less than CoinLim pulse equivalent, that position is completed")},
    {"name":qsTr("POvrTrvLimL"),        "addr":116,"wVal":65535,"decs":qsTr("1.parameter initial value: 65535, whether to modifyy: No.2.[15:0] forward stroke limit (high 16 bits):0~65535.3. Description: when the actual position exceeds [POvrTrvLimH, POvrTrvLimL] pulse equivalent, the positive forward process will occur")},
    {"name":qsTr("POvrTrvLimH"),        "addr":117,"wVal":32767,"decs":qsTr("1.parameter initial value: 32767, whether to modify: No.2.[15:0] forward stroke limit (low 16 bits):0~32767.3. Description: when the actual position exceeds [POvrTrvLimH, POvrTrvLimL] pulse equivalent, the positive forward process will occur")},
    {"name":qsTr("NOvrTrvLimL"),        "addr":118,"wVal":1,    "decs":qsTr("1.parameter initial value: 1, whether to modify: No.2.[15:0] reverse travel limit (high 16 bits):0~65535.3. Description: when the actual position exceeds [NOvrTrvLimH, NOvrTrvLimL] pulse equivalent, reverse reverse process will occur")},
    {"name":qsTr("NOvrTrvLimH"),        "addr":119,"wVal":32768,"decs":qsTr("1.parameter initial value: 32768, whether to modify: No.2.[15:0] reverse travel limit (low 16 bits):-32768~0.3. Description: when the actual position exceeds [NOvrTrvLimH, NOvrTrvLimL] pulse equivalent, reverse reverse process will occur")},
    {"name":qsTr("Ksf"),                "addr":120,"wVal":-32768,"decs":qsTr("1.parameter initial value: -32768,whether to modify: No.2.[15:0] the filter constants: 0~65535.3. Description: Ksf=2^16 * T/ (T+1), including T= /Ts, which is the filter time constant Ts for the position loop sampling period.")},
    {"name":qsTr("KpP"),                "addr":121,"wVal":10,   "decs":qsTr("1.parameter initial value: 10, whether to modify: Yes, suggestion: according to the experience, 2 < KpP < = 100, can be adjusted according to the actual situation in general, recommend the use of the initial value of.2.[15:0] controller of position loop proportional gain: 0~65535.3. Description: 5 decimal places.")},
/*init angle*/
    {"name":qsTr("InitElecAng001"),     "addr":177,"wVal":1024, "decs":qsTr("1.parameter initial value: 1024, whether to modify: No.2.[15:0] rotor initial angle 1:0~65535.3.indicating: motor encoder U, V, W equal to 001 when the corresponding rotor position; only stored in the EEPROM")},
    {"name":qsTr("InitElecAng010"),     "addr":178,"wVal":208,  "decs":qsTr("1.parameter initial value: 208, whether to modify: No.2.[15:0] rotor initial angle 2:0~65535.3.indicating: motor encoder U, V, W equal to 010 when the corresponding rotor position; only stored in the EEPROM")},
    {"name":qsTr("InitElecAng011"),     "addr":179,"wVal":1625, "decs":qsTr("1.parameter initial value: 625, whether to modify: No.2.[15:0] rotor initial angle 3:0~65535.3.indicating: motor encoder U, V, W equal to 011 when the corresponding rotor position; only stored in the EEPROM")},
    {"name":qsTr("InitElecAng100"),     "addr":180,"wVal":1875, "decs":qsTr("1.parameter initial value: 1875, whether to modify: No.2.[15:0] rotor initial angle 4:0~65535.3.indicating: motor encoder U, V, W equal to 100 when the corresponding rotor position; only stored in the EEPROM")},
    {"name":qsTr("InitElecAng101"),     "addr":181,"wVal":1458, "decs":qsTr("1.parameter initial value: 1458, whether to modify: No.2.[15:0] rotor initial angle 5:0~65535.3.indicating: motor encoder U, V, W equal to 101 when the corresponding rotor position; only stored in the EEPROM")},
    {"name":qsTr("InitElecAng110"),     "addr":182,"wVal":2292, "decs":qsTr("1.parameter initial value: 2292, whether to modify: No.2.[15:0] rotor initial angle 6:0~65535.3.indicating: motor encoder U, V, W equal to 110 when the corresponding rotor position; only stored in the EEPROM")},
];

var qkStatusInfo =
[
    {"name":qsTr("SystemStatus"),"addr":0,"decs":qsTr("describe")},
    {"name":qsTr("FaultStatus"),"addr":1,"decs":qsTr("(0 - no fault, 1 - fault) bit0: power on initialization failure, bit1:EEPROM fault, bit2:A/D converter fault, bit3:operation engine system timeout, bit4: radiator overheated, bit5: main power supply overvoltage, undervoltage  bit6: main power supply, bit7:the main power supply is off, bit8:IGBT overcurrent, bit9: IGBT overheating, bit10:overload, bit11:overspeed, bit12: position command pulse frequency is too high, bit13: the position error is too large, bit14:DSP synchronous fault,bit15:  overcurrent fault.")},
    {"name":qsTr("WorkingStatus"),"addr":2,"decs":qsTr("Bit3: servo control enable status(0 - servo off, 1 - servo on)")},
];
