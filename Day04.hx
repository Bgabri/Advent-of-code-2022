using StringTools;
// haxe --interp --main Day04.hx

class Day04 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/04.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/04.txt")));    
    }

    static function part1(input:Array<Array<Int>>):Int {

        var total = 0;
        for (pairs in input) {
            if ((pairs[0] <= pairs[2] && pairs[1] >= pairs[3]) || 
                (pairs[0] >= pairs[2] && pairs[1] <= pairs[3])) total ++;
        }

        return total;
    }
    static function part2(input:Array<Array<Int>>):Int {

        var total = 0;
        for (pairs in input) {
            if ((pairs[0] <= pairs[2] && pairs[2] <= pairs[1]) ||
                (pairs[0] <= pairs[3] && pairs[3] <= pairs[1])) total ++;
        }
        return total;
    }

    static function loadFile(file:String):Array<Array<Int>> {
        var input:Array<Array<Int>> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            line = line.replace("-", ",");
            var inp = line.split(",");

            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            input.push(inp2);
        }
        iterator.close();
        return input;
    }
}
