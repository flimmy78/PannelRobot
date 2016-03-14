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
    "s_rw_0_16_1_294":[0, 100], //manual speed
//    "s_rw_0_16_1_265":[0, 100], //auto speed
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

var configStr = {};

function getConfigDescr (addr){
    if(addr in configStr)
        return configStr[addr];
    return addr;
}

var machineStructConfigs = [
            "s_rw_0_32_3_100",
            "s_rw_0_16_0_101",
            "s_rw_16_16_0_101",
            "s_rw_0_16_0_102",
            "s_rw_16_16_0_102",
            "s_rw_0_4_0_103",
            "s_rw_4_4_0_103",
            "s_rw_8_4_0_103",
            "s_rw_12_20_0_103",
            "s_rw_0_8_0_104",
            "s_rw_8_8_0_104",
            "s_rw_16_8_0_104",
            "s_rw_24_4_0_104",
            "s_rw_28_4_0_104",
            "s_rw_0_16_0_105",
            "s_rw_16_16_1_105",
            "s_rw_0_16_3_106",
            "s_rw_16_16_3_106",
            "s_rw_0_32_3_107",
            "s_rw_0_16_0_108",
            "s_rw_16_16_0_108",
            "s_rw_0_16_0_109",
            "s_rw_16_16_0_109",
            "s_rw_0_4_0_110",
            "s_rw_4_4_0_110",
            "s_rw_8_4_0_110",
            "s_rw_12_20_0_110",
            "s_rw_0_8_0_111",
            "s_rw_8_8_0_111",
            "s_rw_16_8_0_111",
            "s_rw_24_4_0_111",
            "s_rw_28_4_0_111",
            "s_rw_0_16_0_112",
            "s_rw_16_16_1_112",
            "s_rw_0_16_3_113",
            "s_rw_16_16_3_113",
            "s_rw_0_32_3_114",
            "s_rw_0_16_0_115",
            "s_rw_16_16_0_115",
            "s_rw_0_16_0_116",
            "s_rw_16_16_0_116",
            "s_rw_0_4_0_117",
            "s_rw_4_4_0_117",
            "s_rw_8_4_0_117",
            "s_rw_12_20_0_117",
            "s_rw_0_8_0_118",
            "s_rw_8_8_0_118",
            "s_rw_16_8_0_118",
            "s_rw_24_4_0_118",
            "s_rw_28_4_0_118",
            "s_rw_0_16_0_119",
            "s_rw_16_16_1_119",
            "s_rw_0_16_3_120",
            "s_rw_16_16_3_120",
            "s_rw_0_32_3_121",
            "s_rw_0_16_0_122",
            "s_rw_16_16_0_122",
            "s_rw_0_16_0_123",
            "s_rw_16_16_0_123",
            "s_rw_0_4_0_124",
            "s_rw_4_4_0_124",
            "s_rw_8_4_0_124",
            "s_rw_12_20_0_124",
            "s_rw_0_8_0_125",
            "s_rw_8_8_0_125",
            "s_rw_16_8_0_125",
            "s_rw_24_4_0_125",
            "s_rw_28_4_0_125",
            "s_rw_0_16_0_126",
            "s_rw_16_16_1_126",
            "s_rw_0_16_3_127",
            "s_rw_16_16_3_127",
            "s_rw_0_32_3_128",
            "s_rw_0_16_0_129",
            "s_rw_16_16_0_129",
            "s_rw_0_16_0_130",
            "s_rw_16_16_0_130",
            "s_rw_0_4_0_131",
            "s_rw_4_4_0_131",
            "s_rw_8_4_0_131",
            "s_rw_12_20_0_131",
            "s_rw_0_8_0_132",
            "s_rw_8_8_0_132",
            "s_rw_16_8_0_132",
            "s_rw_24_4_0_132",
            "s_rw_28_4_0_132",
            "s_rw_0_16_0_133",
            "s_rw_16_16_1_133",
            "s_rw_0_16_3_134",
            "s_rw_16_16_3_134",
            "s_rw_0_32_3_135",
            "s_rw_0_16_0_136",
            "s_rw_16_16_0_136",
            "s_rw_0_16_0_137",
            "s_rw_16_16_0_137",
            "s_rw_0_4_0_138",
            "s_rw_4_4_0_138",
            "s_rw_8_4_0_138",
            "s_rw_12_20_0_138",
            "s_rw_0_8_0_139",
            "s_rw_8_8_0_139",
            "s_rw_16_8_0_139",
            "s_rw_24_4_0_139",
            "s_rw_28_4_0_139",
            "s_rw_0_16_0_140",
            "s_rw_16_16_1_140",
            "s_rw_0_16_3_141",
            "s_rw_16_16_3_141",
            "s_rw_0_32_3_142",
            "s_rw_0_16_0_143",
            "s_rw_16_16_0_143",
            "s_rw_0_16_0_144",
            "s_rw_16_16_0_144",
            "s_rw_0_4_0_145",
            "s_rw_4_4_0_145",
            "s_rw_8_4_0_145",
            "s_rw_12_20_0_145",
            "s_rw_0_8_0_146",
            "s_rw_8_8_0_146",
            "s_rw_16_8_0_146",
            "s_rw_24_4_0_146",
            "s_rw_28_4_0_146",
            "s_rw_0_16_0_147",
            "s_rw_16_16_1_147",
            "s_rw_0_16_3_148",
            "s_rw_16_16_3_148",
            "s_rw_0_32_3_149",
            "s_rw_0_16_0_150",
            "s_rw_16_16_0_150",
            "s_rw_0_16_0_151",
            "s_rw_16_16_0_151",
            "s_rw_0_4_0_152",
            "s_rw_4_4_0_152",
            "s_rw_8_4_0_152",
            "s_rw_12_20_0_152",
            "s_rw_0_8_0_153",
            "s_rw_8_8_0_153",
            "s_rw_16_8_0_153",
            "s_rw_24_4_0_153",
            "s_rw_28_4_0_153",
            "s_rw_0_16_0_154",
            "s_rw_16_16_1_154",
            "s_rw_0_16_3_155",
            "s_rw_16_16_3_155",
            "s_rw_0_32_3_156",
            "s_rw_0_32_3_157",
            "s_rw_0_32_3_158",
            "s_rw_0_32_3_159",
            "s_rw_0_32_3_160",
            "s_rw_0_32_3_161",
            "s_rw_0_32_3_162",
            "s_rw_0_32_3_163",
            "s_rw_0_32_3_164",
            "s_rw_0_8_0_165",
            "s_rw_8_8_0_165",
            "s_rw_16_8_0_165",
            "s_rw_24_8_0_165",
            "s_rw_0_16_3_166",
            "s_rw_16_16_3_166",
            "s_rw_0_16_0_167",
            "s_rw_16_16_0_167",
            "s_rw_0_32_0_168",
            "s_rw_0_32_0_169",
            "s_rw_0_32_0_170",
            "s_rw_0_32_0_171",
            "s_rw_0_32_0_172",
            "s_rw_0_32_0_173",
            "s_rw_0_32_0_174",
            "s_rw_0_32_0_175",
            "s_rw_0_32_0_176",
            "s_rw_0_32_0_177",
            "s_rw_0_32_0_178",
            "s_rw_0_32_0_179",
            "s_rw_0_32_0_180",
            "s_rw_0_32_0_181",
            "s_rw_0_32_0_182",
            "s_rw_0_32_0_183",
            "s_rw_0_32_0_184",
        ];
var machineStructConfigsJSON = JSON.stringify(machineStructConfigs);
