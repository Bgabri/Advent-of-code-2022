using StringTools;
// haxe --interp --main Day08.hx

class Day08 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/08.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/08.txt")));    
    }

    static function part1(input:Array<Array<Int>>):Int {

        var total = 0;
        for (y => row in input) {
            for (x => tree in row) {
                if(ray(x, y, input,  1,  0)) total++;
                else if(ray(x, y, input,  0,  1)) total++;
                else if(ray(x, y, input, -1,  0)) total++;
                else if(ray(x, y, input,  0, -1)) total++;
            }
        }
        return total;
    }

    static function ray(x:Int, y:Int, input:Array<Array<Int>>, ?xIt:Int = 0, ?yIt:Int = 0) {

        var visible = true;

        var val = input[y][x];
        x += xIt;
        y += yIt;
        while (visible) {
            if (y < 0 || y >= input.length) break;
            if (x < 0 || x >= input[y].length) break;
           
            var tree = input[y][x];
            if (tree >= val) visible = false;
            x += xIt;
            y += yIt;
        }

        return visible;

    }



    static function part2(input:Array<Array<Int>>):Int {

        var max = 0;
        for (y => row in input) {
            for (x => tree in row) {
                var score = 1;

                score *= ray2(x, y, input,  1,  0);
                score *= ray2(x, y, input,  0,  1);
                score *= ray2(x, y, input, -1,  0);
                score *= ray2(x, y, input,  0, -1);

                if (max < score) max = score;
            }
        }
        return max;
    }


    static function ray2(x:Int, y:Int, input:Array<Array<Int>>, ?xIt:Int = 0, ?yIt:Int = 0) {

        var distance = 0;

        var val = input[y][x];
        x += xIt;
        y += yIt;
        while (true) {
            if (y < 0 || y >= input.length) break;
            if (x < 0 || x >= input[y].length) break;
            
            distance++;

            var tree = input[y][x];
            if (tree >= val) break;

            x += xIt;
            y += yIt;
        }

        return distance;

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
