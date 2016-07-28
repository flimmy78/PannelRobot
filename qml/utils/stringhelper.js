.pragma library

var icStrformat = function() {
    // The string containing the format items (e.g. "{0}")
    // will and always has to be the first argument.
    var theString = arguments[0];

    // start with the second argument (i = 1)
    for (var i = 1; i < arguments.length; i++) {
        // "gm" = RegEx options for Global search (more than one instance)
        // and for Multiline search
        var regEx = new RegExp("\\{" + (i - 1) + "\\}", "gm");
        theString = theString.replace(regEx, arguments[i]);
    }

    return theString;
}

function upperFirst(str){
    return str[0].toUpperCase() + str.slice(1);
}

function utf8ToUtf16(s){
    if(!s){
        return;
    }

    var i, codes, bytes, ret = [], len = s.length;
    for(i = 0; i < len; i++){
        codes = [];
        codes.push(s.charCodeAt(i));
        if(((codes[0] >> 7) & 0xff) == 0x0){
            //单字节  0xxxxxxx
            ret.push(s.charAt(i));
        }else if(((codes[0] >> 5) & 0xff) == 0x6){
            //双字节  110xxxxx 10xxxxxx
            codes.push(s.charCodeAt(++i));
            bytes = [];
            bytes.push(codes[0] & 0x1f);
            bytes.push(codes[1] & 0x3f);
            ret.push(String.fromCharCode((bytes[0] << 6) | bytes[1]));
        }else if(((codes[0] >> 4) & 0xff) == 0xe){
            //三字节  1110xxxx 10xxxxxx 10xxxxxx
            codes.push(s.charCodeAt(++i));
            codes.push(s.charCodeAt(++i));
            bytes = [];
            bytes.push((codes[0] << 4) | ((codes[1] >> 2) & 0xf));
            bytes.push(((codes[1] & 0x3) << 6) | (codes[2] & 0x3f));
            ret.push(String.fromCharCode((bytes[0] << 8) | bytes[1]));
        }
    }
    return ret.join('');
}
