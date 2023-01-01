using StringTools;
// haxe --interp --main Dayxx.hx

class DayXX {

    public function new() {
        trace("solution to part 1: " + part1(loadFile("inputs/XX.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/XX.txt")));    
    }

    function part1(input:Array<Array<Int>>):Int {
        trace(input);
        return 0;
    }
    function part2(input:Array<Array<Int>>):Int {
        return 0;
    }

    function loadFile(file:String):Array<Array<Int>> {
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

    static function main() new DayXX();
}