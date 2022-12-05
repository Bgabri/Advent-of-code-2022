using StringTools;

// haxe --interp --main Day05.hx

class Day05 {

    static var crates:Array<Array<String>> = [];

    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/05.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/05.txt")));    
    }

    static function part1(input:Array<Array<Int>>) {

        for (instruction in input) {
            for (i in 0...instruction[0]) crates[instruction[2]-1].push(crates[instruction[1]-1].pop());
        }


        var sOut = "";
        for (stack in crates) sOut += stack[stack.length-1];
        return sOut;
    }
    static function part2(input:Array<Array<Int>>) {
        for (instruction in input) {
            var transfer = [];
            for (i in 0...instruction[0]) transfer.push(crates[instruction[1]-1].pop());
            for (i in 0...transfer.length) crates[instruction[2]-1].push(transfer.pop());
        }

        var sOut = "";
        for (stack in crates) sOut += stack[stack.length-1];
        return sOut;
    }

    static function loadFile(file:String):Array<Array<Int>> {
        var input:Array<Array<Int>> = [];
        var iterator = sys.io.File.read(file, false);

        crates = [];

        var stockPileHeight = 8;

        for (i in 0...stockPileHeight){
            var line = iterator.readLine();
            var stackLine:Array<String> = [];
            for (I=>char in line) if (I%4 == 1) stackLine.push(String.fromCharCode(char));
            crates.push(stackLine);
        }

        iterator.readLine();
        iterator.readLine();
        
        while (!iterator.eof()) {
            var line = iterator.readLine();
            line = line.replace("move ", "");
            line = line.replace(" from ", ",");
            line = line.replace(" to ", ",");
            var inp = line.split(",");
            input.push(inp.map(v -> Std.parseInt(v)));
        }

        var modifCrates:Array<Array<String>> = [];

        for (j in 0...crates[0].length) {
            var stack:Array<String> = [];
            for (i in 0...crates.length) {
                if (crates[i][j] != " ") stack.unshift(crates[i][j]);
            }
            modifCrates.push(stack);
        }

        crates = modifCrates;

        iterator.close();
        return input;
    }
}
