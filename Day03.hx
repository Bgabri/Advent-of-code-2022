using StringTools;
// haxe --interp --main Day03.hx

class Day03 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/03.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/03.txt")));    
    }

    static function part1(input:Array<String>):Int {
        var total = 0;
        for (ruckSac in input) {
            var _1 = ruckSac.substr(0, Math.floor(ruckSac.length/2));
            var _2 = ruckSac.substr(Math.floor(ruckSac.length/2), ruckSac.length);

            var filtered:String = filter(_1, _2);
            
            var code = filtered.charCodeAt(0);
            if (64 < code && code < 91) total += code - 38;
            else if (96 < code && code < 123) total += code - 96;
        }

        return total;
    }

    static function filter(s1:String, s2:String) {
        var sOut = "";
        for (val in s1) for (val2 in s2) if (val == val2) sOut += String.fromCharCode(val);
        return sOut;
    }

    static function part2(input:Array<String>):Int {

        var total = 0;
        for (i in 0...Math.floor(input.length/3)) {

            var _1x2 = filter(input[i*3],input[i*3+1]);
            var _1x2x3 =  filter(_1x2, input[i*3+2]);
            
            var code = _1x2x3.charCodeAt(0);
            if (64 < code && code < 91) total += code - 38;
            else if (96 < code && code < 123) total += code - 96;
        }

        return total;
    }

    static function loadFile(file:String):Array<String> {
        var input:Array<String> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            input.push(line);
        }
        iterator.close();
        return input;
    }
}
