using StringTools;
// haxe --interp --main Day11.hx



@:structInit class Monkey {
    public var items:Array<Float> = [];
    public var op:(x:Float) -> Float;
    public var test:Float;
    public var testTrue:Int;
    public var testFalse:Int;
}

class Day11 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/11.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/11.txt")));    
    }

    static function part1(input:Array<Monkey>):Int {
        var inspections = [for (i in 0...input.length) 0];

        for (r in 0...20) {
            for (i=>monkey in input) {

                while (monkey.items.length != 0) {
                    inspections[i]++;
                    var item = monkey.items.shift();
                    var newItem = monkey.op(item);

                    newItem = Math.floor(newItem/3);

                    if (newItem % monkey.test == 0) input[monkey.testTrue].items.push(newItem);
                    else input[monkey.testFalse].items.push(newItem);
                }
            }
        }

        inspections.sort((a,b)-> b-a);
        
        return inspections[0]*inspections[1];
    }

    static function part2(input:Array<Monkey>):Float {
        var inspections = [for (i in 0...input.length) 0.];

        var lcm = 1.;
        for (monkey in input) lcm*= monkey.test;
        
        for (r in 0...10000) {
            for (i=>monkey in input) {

                while (monkey.items.length != 0) {
                    inspections[i]++;
                    var item = monkey.items.shift();
                    
                    var newItem = monkey.op(item);

                    newItem %= lcm;

                    if (newItem % monkey.test == 0) input[monkey.testTrue].items.push(newItem);
                    else input[monkey.testFalse].items.push(newItem);
                }
            }
        }

        var max0:Float = .0;
        var max1:Float = .0;
        
        for (val in inspections) {
            if (max0 < val) {
                max1 = max0;
                max0 = val;
            } else if (max1 < val) {
                max1 = val;
            }
        }
 
        return max0*max1;
    }

    static function loadFile(file:String):Array<Monkey> {
        var input:Array<Monkey> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (true){
            var monkey    = iterator.readLine();
            var items     = iterator.readLine();
            var op        = iterator.readLine();
            var test      = iterator.readLine();
            var testTrue  = iterator.readLine();
            var testFalse = iterator.readLine();

                                       //  Monkey xx:
            items     =     items.replace("  Starting items: ", "");
            op        =        op.replace("  Operation: new = ", "");
            test      =      test.replace("  Test: divisible by ", "");
            testTrue  =  testTrue.replace("    If true: throw to monkey ", "");
            testFalse = testFalse.replace("    If false: throw to monkey ", "");
            
            var items     = items.split(", ");

            var items:Array<Float> = items.map(v -> Std.parseFloat(v));

            var op        = op.split(" ");
            var opF:(x:Float) -> Float = x -> x;
            switch (op) {
                case(["old", "+", "old"]): opF = x -> x + x;
                case(["old", "+",  val ]): opF = x -> x + Std.parseInt(val);
                case(["old", "*", "old"]): opF = x -> x * x;
                case(["old", "*",  val ]): opF = x -> x * Std.parseInt(val);
                case(_):
            }
            // opF = old -> parse(op);

            var test      = Std.parseInt(test);
            var testTrue  = Std.parseInt(testTrue);
            var testFalse = Std.parseInt(testFalse);

          
            
            input.push({items:items, op:opF, test:test, testTrue:testTrue, testFalse:testFalse});
            
            if (iterator.eof()) break;
            iterator.readLine();
        }

        iterator.close();
        return input;
    }
}