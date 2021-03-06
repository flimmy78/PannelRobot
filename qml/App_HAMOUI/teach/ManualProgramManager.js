.pragma library

Qt.include("../../utils/Storage.js")
Qt.include("../../utils/stringhelper.js")
Qt.include("../../utils/utils.js")

function ManualProgramManager(){
    this.programs = [];
    this.monitors = [];
    var db = getDatabase();
    var programs = this.programs;
    var manager = this;
    db.transaction(function(tx){
        tx.executeSql('CREATE TABLE IF NOT EXISTS manualprogram(id PK INTEGER NOT NULL, name TEXT  NOT NULL, program TEXT  NOT NULL)');
//        tx.executeSql('DELETE FROM manualprogram');
    }
    );
    db.transaction(function(tx){
        var rs = tx.executeSql('SELECT * FROM manualprogram ORDER BY id ASC');
        var prog;
        for(var i = 0; i < rs.rows.length; ++i){
            prog = rs.rows.item(i);
            prog.program = JSON.parse(prog.program);
            programs[prog.id] = prog;

        }
    }
    );

    this.clear = function(){
        db.transaction(function(tx){
//            tx.executeSql('CREATE TABLE IF NOT EXISTS manualprogram(id PK INTEGER NOT NULL, name TEXT  NOT NULL, program TEXT  NOT NULL)');
            tx.executeSql('DELETE FROM manualprogram');
        });
    }

    this.findUsableID = function(){
        for(var i = 0 ; i < programs.length; ++i){
            if(programs[i] === undefined)
                return i;
        }
        return programs.length;
    }

    this.getProgram = function(id){
        return programs[id];
    }

    this.getProgramByName = function(name){
        var toGetID = getValueFromBrackets(name);
        return this.getProgram(toGetID);
    }

    this.programsNameList = function(){
        var ret = [];
        var p;
        for(var i = 0; i < programs.length; ++i){
            p = programs[i];
            if(p !== undefined)
                ret.push(icStrformat(qsTr("M CMD[{0}]:{1}"), p.id, p.name));
        }
        return ret;
    }

    this.programList = function(){
        var ret = [];
        var p;
        for(var i = 0; i < programs.length; ++i){
            p = programs[i];
            if(p !== undefined)
                ret.push(p);
        }
        return ret;
    }

    this.addProgram = function(name, program){
        var id = this.findUsableID();
        var toRet = icStrformat(qsTr("M CMD[{0}]:{1}"), id, name);

        db.transaction(function(tx){
            var rs = tx.executeSql(icStrformat("INSERT INTO manualprogram VALUES({0}, '{1}', '{2}')",
                                     id , name, JSON.stringify(program)));
            if(rs.rowsAffected > 0){
                programs[id] = {"id":id, "name":name, "program":program};
                manager.informMonitor("onProgramAdded", programs[id]);
             }
        });
        return toRet;
    }
    this.removeProgram = function(id){
        db.transaction(function(tx){
            var rs = tx.executeSql(icStrformat('DELETE FROM manualprogram WHERE id={0}',
                                     id));
            if(rs.rowsAffected > 0){
                programs[id] = undefined;
                manager.informMonitor("onProgramRemoved", id);
            }
        });
    }
    this.removeProgramByName = function(name){
        var toDelID = getValueFromBrackets(name);
        this.removeProgram(toDelID);
    }

    this.updateProgram = function(id, name, program){
        db.transaction(function(tx){
            var rs = tx.executeSql(icStrformat("UPDATE manualprogram SET name='{0}', program='{1}' WHERE id={2}",
                                     name, JSON.stringify(program), id));
            if(rs.rowsAffected > 0){
                programs[id] = {"id":id, "name":name, "program":program};
                manager.informMonitor("onProgramChanged", programs[id]);
            }
        });
    }

    this.updateProgramByName = function(name, program){
        var toUpdateID = getValueFromBrackets(name);
        this.updateProgram(toUpdateID, programs[toUpdateID].name, program);
        return toUpdateID;
    }

    this.registerMonitor = function(obj){
        this.monitors.push(obj)
    }
    this.informMonitor = function(event, program){
        var m;
        for(var i = 0; i < this.monitors.length; ++i){
            m = this.monitors[i];
            if(m.hasOwnProperty(event))
                m[event](program);
        }
    }



    if(this.getProgram(0) === undefined){
        this.addProgram(qsTr("Custom Origin"),[{"action":60000}]);
    }
    if(this.getProgram(1) === undefined){
        this.addProgram(qsTr("Custom Return"),[{"action":60000}]);
    }
}

var manualProgramManager = new ManualProgramManager();
