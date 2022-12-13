using StringTools;
// haxe --interp --main Day10.hx

class Day10 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/10.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/10.txt")));    
    }

    static function part1(input:Array<Array<String>>):Int {
        input = reOder(input);
        var register = 1;
        var strength = 0;
        for (i=>instruction in input) {
            switch(i) {
                case( 20): strength +=  20*register;
                case( 60): strength +=  60*register;
                case(100): strength += 100*register;
                case(140): strength += 140*register;
                case(180): strength += 180*register;
                case(220): strength += 220*register;
                case( _ ):
            }
            if (instruction[0] == "addx") register += Std.parseInt(instruction[1]);
        }
        
        return strength;
    }

    static function reOder(input:Array<Array<String>>) {
	  var newInp:Array<Array<String>> = [["noop"]];
        for (i=>instruction in input) {
	      
            if (instruction[0] == "addx") newInp.push(["noop"]);
            newInp.push(instruction);
        }
        return newInp;
    }

    static function part2(input:Array<Array<String>>):Int {
         input = reOder(input);
        var register = 1;
        var crt:Array<Array<String>> = [for(i in 0...6) [for (j in 0...40) "."]];
        var pixelPos = 0;
        var row = 0;
        for (i=>instruction in input) {
          
            if (pixelPos > 39) {
                pixelPos = 0;
                row ++;
            }
            var px = pixelPos - register-1;
            if (-1 == px || px == 1 ||px == 0) crt[row][pixelPos] = "#";
            pixelPos++;
            
            if (instruction[0] == "addx") register += Std.parseInt(instruction[1]);
        }
        for (line in crt) trace(line.join(""));
        
        return null;
    }

    static function loadFile(file:String):Array<Array<String>> {
        var input:Array<Array<String>> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            var inp = line.split(" ");
            input.push(inp);
        }
        iterator.close();
        return input;
    }
}