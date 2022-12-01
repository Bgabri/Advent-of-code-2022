
// haxe --interp --main Dayxx.hx

class Day01 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/01.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/01.txt")));    
    }

    static function part1(input:Array<Array<Int>>):Int {
        var totalCalories:Array<Int> = [];
        
        var max = 0;
        for (elfInv in input) {
            var totalCalories:Int = 0;

            for (food in elfInv) totalCalories += food;
            if (max < totalCalories) max = totalCalories;

        }

        return max;
    }
    static function part2(input:Array<Array<Int>>):Int {
        var totalCalories:Array<Int> = [];
        for (elfInv in input) {
            var total:Int = 0;
            for (food in elfInv) total += food;
            totalCalories.push(total);
        }

        totalCalories.sort((a, b) -> b - a);

        return totalCalories[0]+totalCalories[1]+totalCalories[2];

        // return max;
    }

    static function loadFile(file:String):Array<Array<Int>> {
        var input:Array<Array<Int>> = [];
        var iterator = sys.io.File.read(file, false);
        
        var inv:Array<Int> = [];

        while (!iterator.eof()){
            var line = iterator.readLine();
            if (line == "") {
                input.push(inv);
                inv = [];
            } else {
                inv.push(Std.parseInt(line));
            }
        }
        iterator.close();
        return input;
    }
}
