.pragma library

var MAX_UINT_16 = 65536;
var MAX_UINT_32 = 2147483647;
var MAX_INT_16 = 32767;
var MIN_INT_16 = -32767;
var MAX_INT_32 = 2147483647;
var MIN_INT_32 = -2147483647;

var configRanges = {
    "m_rw_0_16_0_0":[-100, 100],
    "m_rw_0_16_0_1":[2, 200],
    "m_rw_0_16_0_2":["m_rw_0_16_0_0", "m_rw_0_16_0_1"],
    "m_rw_0_16_0_16":[0, MAX_UINT_16],
    "s_rw_0_16_1_265":[0, 100], //manual speed
    "s_rw_0_16_1_265":[0, 100], //auto speed
    "s_rw_0_16_0_102":[MIN_INT_16, MAX_INT_16],
    "s_rw_16_16_0_102":[MIN_INT_16, MAX_INT_16],
    "s_rw_0_16_0_109":[MIN_INT_16, MAX_INT_16],
    "s_rw_16_16_0_109":[MIN_INT_16, MAX_INT_16],
    "s_rw_0_16_0_116":[MIN_INT_16, MAX_INT_16],
    "s_rw_16_16_0_116":[MIN_INT_16, MAX_INT_16],
    "s_rw_0_16_0_123":[MIN_INT_16, MAX_INT_16],
    "s_rw_16_16_0_123":[MIN_INT_16, MAX_INT_16],
    "s_rw_0_16_0_130":[MIN_INT_16, MAX_INT_16],
    "s_rw_16_16_0_130":[MIN_INT_16, MAX_INT_16],
    "s_rw_0_16_0_137":[MIN_INT_16, MAX_INT_16],
    "s_rw_16_16_0_137":[MIN_INT_16, MAX_INT_16],
    "s_rw_0_16_0_107":[MIN_INT_16, MAX_INT_16],
    "s_rw_16_16_0_107":[MIN_INT_16, MAX_INT_16],
    "s_rw_0_16_0_114":[MIN_INT_16, MAX_INT_16],
    "s_rw_16_16_0_114":[MIN_INT_16, MAX_INT_16],
    "s_rw_0_16_0_121":[MIN_INT_16, MAX_INT_16],
    "s_rw_16_16_0_121":[MIN_INT_16, MAX_INT_16],
    "s_rw_0_16_0_128":[MIN_INT_16, MAX_INT_16],
    "s_rw_16_16_0_128":[MIN_INT_16, MAX_INT_16],
    "s_rw_0_16_0_135":[MIN_INT_16, MAX_INT_16],
    "s_rw_16_16_0_135":[MIN_INT_16, MAX_INT_16],
    "s_rw_0_32_0_181":[0, MAX_UINT_16],
    "s_rw_0_32_3_1000":["s_rw_16_16_0_102", "s_rw_0_16_0_102"],
    "s_rw_0_32_3_1001":["s_rw_16_16_0_109", "s_rw_0_16_0_109"],
    "s_rw_0_32_3_1002":["s_rw_16_16_0_116", "s_rw_0_16_0_116"],
    "s_rw_0_32_3_1003":["s_rw_16_16_0_123", "s_rw_0_16_0_123"],
    "s_rw_0_32_3_1004":["s_rw_16_16_0_130", "s_rw_0_16_0_130"],
    "s_rw_0_32_3_1005":["s_rw_16_16_0_137", "s_rw_0_16_0_137"],
    "s_rw_0_32_2_1100":[0, 600],
    "s_rw_0_32_1_1200":[0, 100],
    "s_rw_0_32_1_1201":[0, 600000], //IO Teach delay
    "s_rw_0_32_3_1300":[MIN_INT_32, MAX_INT_32], //Path limit
    "s_rw_0_32_0_1400":[0, MAX_UINT_32] // count

};

var getConfigRange = function(config){
    var r = configRanges[config];
    var items = config.split("_");
    if(r === undefined){
        return {"min":0, "max":MAX_INT_32, "decimal":parseInt(items[4])};
    }
    return {"min":r[0], "max":r[1], "decimal":parseInt(items[4])};
};

var fncDefaultValues = {
    "m_rw_0_1_0_357": 1,
    "m_rw_1_1_0_357": 1,
    "m_rw_2_1_0_357": 1,
    "m_rw_3_1_0_357": 1,
    "m_rw_4_1_0_357": 1,
    "m_rw_5_1_0_357": 1,
    "m_rw_6_1_0_357": 1,
    "m_rw_7_1_0_357": 1,
    "m_rw_8_1_0_357": 1,
    "m_rw_9_23_0_357": 0
};
