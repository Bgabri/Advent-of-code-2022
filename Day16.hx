using StringTools;
// haxe --interp --main Day16.hx

class Day16 {

    public function new() {
        trace("solution to part 1: " + part1(loadFile("inputs/16.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/16.txt")));    
    }

    function part1(input:Array<Array<String>>):Int {
        trace(input);
        return 0;
    }
    function part2(input:Array<Array<String>>):Int {
        return 0;
    }

    function loadFile(file:String):Array<Array<String>> {
        var input:Array<Array<String>> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            line = line.replace(", ", ",");
            line = line.replace("Valve ", "");
            line = line.replace(" has flow rate=", ",");
            line = line.replace("; tunnel leads to valve ", ",");
            line = line.replace("; tunnels lead to valves ", ",");
            var inp = line.split(",");
            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            input.push(inp2);
        }
        iterator.close();
        return input;
    }

    static function main() new Day16();
}