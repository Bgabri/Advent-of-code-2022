using StringTools;
// haxe --interp --main Day06.hx

class Day06 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/06.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/06.txt")));    
    }

    static function part1(input:String):Int {

        var c1:Int = input.charCodeAt(3);
        var c2:Int = input.charCodeAt(2);
        var c3:Int = input.charCodeAt(1);
        var c4:Int = input.charCodeAt(0);
        // assume first 4 chars will be unique
        for (i in 4...input.length) {
            c4 = c3;
            c3 = c2;
            c2 = c1;
            c1 = input.charCodeAt(i);

            if (c1 != c2 && c1 != c3 && c1 != c4 && c2 != c3  && c2 != c4 && c3 != c4) return i+1;
        }

        return 0;
    }
    static function part2(input:String):Int {

        
        var msg:String = "";
        for (i in 0...14) {
            msg += input.charAt(i);
        }

        // assume first 14 chars will be unique

        for (i in 14...input.length) {
            msg = msg.substring(1);
            msg += input.charAt(i);


            var msgMask:Array<Int> = [];

            for (i in msg) if(msgMask[i] == null) msgMask[i] = 1 else msgMask[i] ++;

            var unique = true;
            for (h in msgMask) if (h != null && h > 1) unique = false;
            if (unique) return i+1;

        }

        return 0;
    }

    static function loadFile(file:String):String {
        var input:String = "";
        var iterator = sys.io.File.read(file, false);
        input = iterator.readLine();
        iterator.close();
        return input;
    }
}
