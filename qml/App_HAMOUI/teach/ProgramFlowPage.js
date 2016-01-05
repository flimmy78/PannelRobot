var programs = [];
var stepAddrs =
        ["c_ro_0_16_0_933",
        "c_ro_16_16_0_933",
        "c_ro_0_16_0_934",
        "c_ro_16_16_0_934",
        "c_ro_0_16_0_935",
        "c_ro_16_16_0_935",
        "c_ro_0_16_0_936",
        "c_ro_16_16_0_936",
        "c_ro_0_16_0_937"];
var lastRunning = {"model": -1, "step":-1, "items":[]};

var isReadOnly = true;

function LinesInfo(){
    this.programsLines = [];
    this.clear = function(programIndex){
        var tmp = this.programsLines[programIndex];
        if(tmp != undefined){
            tmp.length = 0;
        }
    }
    this.add = function(programIndex, id, line){
        var tmp = this.programsLines[programIndex];
        if(tmp == undefined){
            this.programsLines[programIndex] = {};
        }
        tmp = this.programsLines[programIndex][id];
        if(tmp == undefined)
            tmp = []
        tmp.push(line);
        this.programsLines[programIndex][id] = tmp;
    }
    this.getLines = function(programIndex, id){
        var tmp = this.programsLines[programIndex][id];
        return tmp || [];
    }
}

var counterLinesInfo = new LinesInfo();

var stackLinesInfo = new LinesInfo();
