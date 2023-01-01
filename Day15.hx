using StringTools;
// haxe --interp --main Day15.hx

class Day15 {
    static function main() new Day15();

    public function new() {
        trace("solution to part 1: " + part1(loadFile("inputs/15.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/15.txt")));    
    }

    function part1(input:Array<Array<Int>>):Int {


        // for (y in 10...11) {

        var ranges:Array<Array<Int>> = [];

            var y = 10;
            // var row:haxe.ds.Vector<String> = new haxe.ds.Vector(12000000);
            var shift = 10000000;

            for (val in input) {
                var xRange  = getxRange(y, val);
                // for (x in xRange[0]...xRange[1]+1) row[x+shift] = "#";

                // var hasRange = false;
                for (i=>range in ranges) {
                    //  range      0     1                                                   0     1 
                    // xrange         0     1                                            0     1 

                    // if (range[0] <=  xRange[0] && xRange[0] <= range[1]) ranges[i] = [range[0], xRange[1]];
                    
                    // if (range[0] <=  xRange[1] && xRange[1] <= range[1]) ranges[i] = [xRange[0], range[1]];
                    
                    // if (range[0] <=  xRange[1] && xRange[1] <= range[1]) ranges[i] = [xRange[0], range[1]];



                    // switch [range[0] <=  xRange[0] && xRange[0] <= range[1], range[0] <=  xRange[1] && xRange[1] <= range[1]] {
                    //     case [true, true]:
                    //     case [false, false]: 
                    //         if (xRange[0] > range[1] && xRange[1] > range[1]) ranges.push(xRange);
                    //         else if (xRange[0] < range[0] && xRange[1] < range[0]) ranges.push(xRange);
                    //         else if (xRange[0] < range[0] && xRange[1] > range[1]) ranges[i] = xRange;
                    //         else trace("AAA");
                    //     case [true, false]: ranges[i] = [range[0], xRange[1]];
                    //     case [false, true]: ranges[i] = [xRange[0], range[1]];
                    //     case _:
                    // }
                }
                // if (ranges.length == 0) ranges.push(xRange);
            }
            // for (val in input) {
                // if (val[3] == y) row[val[2]+shift] = "B";
            // }

        // }
        trace(ranges);
        var total = 0;
        for (range in ranges) total += range[1]-range[0]+1;

        // var s = '$y';
        // for (val in row) if (val== null) s+="." else s+=val;
        // for (val in row) if (val== "#") total++;

        // trace(s);


        return total;
    }

    function clamp(min:Int, max:Int, x:Int) {
        if (x < min) return min;
        if (x > max) return max;
        return x;
    }

    function getxRange(y:Int, val:Array<Int>) {
        // manhattan distance
        var maxDist = Std.int(Math.abs(val[0]-val[2]) + Math.abs(val[1] - val[3]));

        var dy = Std.int(Math.abs(val[1]-y));
        var maxX = maxDist - dy;

        var x0 = val[0]-maxX;
        var x1 = val[0]+maxX;

        return [x0, x1];
    }

// 4424172 to low
// 8859168 to high
    function manhatten(x0:Int, y0:Int, x1:Int, y1:Int) return Math.abs(x0-x1) + Math.abs(y0 - y1);

    
    function part2(input:Array<Array<Int>>):Int {
        return 0;
    }

    function loadFile(file:String):Array<Array<Int>> {
        var input:Array<Array<Int>> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            line = line.replace("Sensor at x=", "");
            line = line.replace(": closest beacon is at x=", ",");
            line = line.replace(", y=", ",");

            var inp = line.split(",");
            var inp2:Array<Int> = inp.map(v -> Std.parseInt(v));
            input.push(inp2);
        }
        iterator.close();
        return input;
    }
}
