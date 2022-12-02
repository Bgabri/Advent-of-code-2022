
// haxe --interp --main Day02.hx

class Day02 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/02.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/02.txt")));    
    }

    static function part1(input:Array<Array<String>>):Int {
        var score = 0;
        for (round in input) {
            switch round {
                case ["A", "X"]: score += 1 + 3;
                case ["A", "Y"]: score += 2 + 6;
                case ["A", "Z"]: score += 3 + 0;

                case ["B", "X"]: score += 1 + 0;
                case ["B", "Y"]: score += 2 + 3;
                case ["B", "Z"]: score += 3 + 6;

                case ["C", "X"]: score += 1 + 6;
                case ["C", "Y"]: score += 2 + 0;
                case ["C", "Z"]: score += 3 + 3;
                case _: score += 0;
            }

        }

        return score;
    }
    static function part2(input:Array<Array<String>>):Int {
        var score = 0;
        for (round in input) {
            switch round {
                case ["A", "X"]: score += 3 + 0;
                case ["A", "Y"]: score += 1 + 3;
                case ["A", "Z"]: score += 2 + 6;

                case ["B", "X"]: score += 1 + 0;
                case ["B", "Y"]: score += 2 + 3;
                case ["B", "Z"]: score += 3 + 6;

                case ["C", "X"]: score += 2 + 0;
                case ["C", "Y"]: score += 3 + 3;
                case ["C", "Z"]: score += 1 + 6;
                case _: score += 0;
            }

        }
        return score;
    }

    static function loadFile(file:String):Array<Array<String>> {
        var input:Array<Array<String>> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            var inp = line.split(" ");
            // var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            input.push(inp);
        }
        iterator.close();
        return input;
    }
}
