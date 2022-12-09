using StringTools;
// haxe --interp --main Day09.hx

class Day09 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/09.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/09.txt")));    
    }

    static function part1(input:Array<Array<String>>):Int {
        var head = {x:1000, y:1000};
        var tail = {x:1000, y:1000};

        var traceingPaper :Array<Array<Int>> = [[]];
        
        for (step in input) {
            var steps = Std.parseInt(step[1]);
            var op = step[0];

            for (i in 0...steps) {
                switch (op) {
                    case "L": head.x --;
                    case "R": head.x ++;
                    case "U": head.y ++;
                    case "D": head.y --;
                    case _:
                }
                
                follow(head, tail);

                if (traceingPaper[tail.y] == null) traceingPaper[tail.y] = [];
                traceingPaper[tail.y][tail.x] = 1;
            }
        }
        var total = 0;
        for (line in traceingPaper) if (line != null) for (val in line) if(val == 1) total ++;
        return total;
    }

    
    static function part2(input:Array<Array<String>>):Int {

        var rope:Array<{x:Int, y:Int}> = [for (i in 0...10) {x:1000, y:1000}];
    
        var traceingPaper:Array<Array<Bool>> = [];



        for (step in input) {
            var op:String = step[0];
            var steps:Int = Std.parseInt(step[1]);
    
            for (j in 0...steps) {
                switch (op) {
                    case "L": rope[0].x --;
                    case "R": rope[0].x ++;
                    case "U": rope[0].y ++;
                    case "D": rope[0].y --;
                    case _:
                }
                
                for (i in 1...rope.length) follow(rope[i-1], rope[i]);
                
                if (traceingPaper[rope[9].y] == null) traceingPaper[rope[9].y] = [];
                traceingPaper[rope[9].y][rope[9].x] = true;
            }
        }

        var total = 0;
        for (line in traceingPaper) if (line != null) for (val in line) if(val) total ++;
        return total;
    }

    static function follow (knot0:{x:Int, y:Int}, knot1:{x:Int, y:Int}) {

        var dx = knot0.x - knot1.x;
        var dy = knot0.y - knot1.y;

        if (dx > 1 || dx < -1 || dy > 1 || dy < -1) {
            // knot0 and knot1 are not neighbours
            if (knot0.x > knot1.x) knot1.x ++;
            else if (knot0.x < knot1.x) knot1.x --;

            if (knot0.y > knot1.y) knot1.y ++;
            else if (knot0.y < knot1.y) knot1.y --;
        }
        
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