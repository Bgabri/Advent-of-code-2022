
// haxe --interp --main Dayxx.hx

class DayXX {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/XX.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/XX.txt")));    
    }

    static function part1(input:Array<Array<Int>>):Int {
        trace(input);
        return 0;
    }
    static function part2(input:Array<Array<Int>>):Int {
        trace(input);
        return 0;
    }

    static function loadFile(file:String):Array<Array<Int>> {
        var input:Array<Array<Int>> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            var inp = line.split("");
            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            input.push(inp2);
        }
        iterator.close();
        return input;
    }
}
