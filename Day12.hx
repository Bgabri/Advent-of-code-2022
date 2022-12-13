using StringTools;
// haxe --interp --main Day12.hx

class Day12 {
    var start = {x:0, y:0};
    var end   = {x:0, y:0};

    public function new() {
        trace("solution to part 1: " + part1(loadFile("inputs/12.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/12.txt")));    

    }

    function part1(input:Array<Array<Int>>):Int {
        var current = start;
        var weights = [for (i in input) [for (j in i) 123546]];
        var visited = [for (i in input) [for (j in i) false]];
        weights[start.y][start.x] = 0;

        while (current.x != end.x || current.y != end.y) {
            current = shortestNode(weights, visited);
            var ns = neighbours(current, input, visited);

            var cVal = weights[current.y][current.x];

            for (n in ns) weights[n.y][n.x] = cVal+ 1;

            visited[current.y][current.x] = true;
        }

        return weights[end.y][end.x];
    }


    function neighbours(node:{x:Int, y:Int}, graph:Array<Array<Int>>, visited:Array<Array<Bool>>) {
        var ns:Array<{x:Int, y:Int}> = [];
        var nodeVal = graph[node.y][node.x];
        //           top          bottom      left         right
        var nMap = [{x:0, y:-1}, {x:0, y:1}, {x:-1, y:0}, {x:1, y:0}];
        for (n in nMap) {
            var nx = node.x - n.x;
            var ny = node.y - n.y;
            if (ny >= 0 && ny < graph.length && nx >= 0 && nx < graph[ny].length) {
                if (!visited[ny][nx] && graph[ny][nx] <= nodeVal + 1) ns.push({x:nx, y:ny});
            }
        }

        return ns;
    }

    function shortestNode(weights:Array<Array<Int>>, visited:Array<Array<Bool>>) {
        var smallest = {x:-1, y:-1};
        var smallestVal = 123457;
        for (y=>row in weights) for (x=>weight in row) {
            if (!visited[y][x] && weight < smallestVal) {
                smallestVal = weight;
                smallest = {x: x, y: y};
            }
        }
        return smallest;
    }

    function part2(input:Array<Array<Int>>):Int {
        var current = end;
        var weights = [for (i in input) [for (j in i) 123546] ];
        var visited = [for (i in input) [for (j in i) false] ];
        weights[current.y][current.x] = 0;

        while (current.x != start.x || current.y != start.y) {
            current = shortestNode(weights, visited);
            var ns = neighboursP2(current, input, visited);

            var cVal = weights[current.y][current.x];

            for (n in ns) weights[n.y][n.x] =  cVal+ 1;

            visited[current.y][current.x] = true;
        }

        var smallest = 10000;
        for (y=>row in input) for (x=>code in row) {
            if(code == 0 && weights[y][x] < smallest) smallest = weights[y][x];
        }

        return smallest;
    }


    function neighboursP2(node:{x:Int, y:Int}, graph:Array<Array<Int>>, visited:Array<Array<Bool>>) {
        var ns:Array<{x:Int, y:Int}> = [];
        var nodeVal = graph[node.y][node.x];
        //           top          bottom      left         right
        var nMap = [{x:0, y:-1}, {x:0, y:1}, {x:-1, y:0}, {x:1, y:0}];
        for (n in nMap) {
            var nx = node.x - n.x;
            var ny = node.y - n.y;
            if (ny >= 0 && ny < graph.length && nx >= 0 && nx < graph[ny].length) {
                if (!visited[ny][nx] && graph[ny][nx] + 1 >= nodeVal) ns.push({x:nx, y:ny});
            }
        }

        return ns;
    }

    function loadFile(file:String):Array<Array<Int>> {
        var input:Array<String> = ["abaaaaaccccccccccccccccccaaaaaaaaaaaaaccccaaaaaaaccccccccccccccccccccccccccccaaaaaa",
        "abaaaaaaccaaaacccccccccccaaaaaaaaacaaaacaaaaaaaaaacccccccccccccccccccccccccccaaaaaa",
        "abaaaaaacaaaaaccccccccccaaaaaaaaaaaaaaacaaaaaaaaaacccccccccccccaacccccccccccccaaaaa",
        "abaaaaaacaaaaaacccccccccaaaaaaaaaaaaaaccaaacaaaccccccccccccccccaacccccccccccccccaaa",
        "abccaaaccaaaaaacccaaaaccaaaaaaaaaaaaaccccaacaaacccccccccaacaccccacccccccccccccccaaa",
        "abcccccccaaaaaccccaaaacccccaaaaacccaaaccaaaaaaccccccccccaaaaccccccccccccccccccccaac",
        "abcccccccccaaaccccaaaacccccaaaaacccccccccaaaaaccccccccccklllllccccccccccccccccccccc",
        "abcccccccccccccccccaaccccccccaaccccccccaaaaaaaccccccccckklllllllcccccddccccaacccccc",
        "abaccccccccccccccccccccccccccaaccccccccaaaaaaaaccccccckkkklslllllcccddddddaaacccccc",
        "abacccccccccccccccccccccccccccccccaaaccaaaaaaaaccccccckkkssssslllllcddddddddacccccc",
        "abaccccccccccccccccccccccccccccccccaaaaccaaacaccccccckkksssssssslllmmmmmdddddaacccc",
        "abcccccccccccccccaaacccccccccccccaaaaaaccaacccccccccckkkssssusssslmmmmmmmdddddacccc",
        "abcccccccaaccccaaaaacccccccccccccaaaaaccccccaaaaaccckkkrssuuuussssqmmmmmmmmdddccccc",
        "abcccccccaaccccaaaaaacccccccaaccccaaaaacccccaaaaacckkkkrruuuuuussqqqqqqmmmmdddccccc",
        "abccccaaaaaaaacaaaaaacccccccaaaaccaaccaccccaaaaaacjkkkrrruuuxuuusqqqqqqqmmmmeeccccc",
        "abcaaaaaaaaaaacaaaaaccccccaaaaaacccccaaccccaaaaajjjjrrrrruuuxxuvvvvvvvqqqmmmeeccccc",
        "abcaacccaaaaccccaaaaaaacccaaaaacccacaaaccccaaaajjjjrrrrruuuxxxxvvvvvvvqqqmmeeeccccc",
        "abaaaaccaaaaacccccccaaaccccaaaaacaaaaaaaacccaajjjjrrrrtuuuuxxxyvyyyvvvqqqnneeeccccc",
        "abaaaaaaaaaaacccaaaaaaaccccaacaacaaaaaaaacccccjjjrrrttttuxxxxxyyyyyvvvqqnnneeeccccc",
        "abaaaaaaaccaacccaaaaaaaaacccccccccaaaaaaccccccjjjrrrtttxxxxxxxyyyyyvvvqqnnneeeccccc",
        "SbaaaaaacccccccccaaaaaaaaaccccccccaaaaacccccccjjjrrrtttxxxEzzzzyyyvvrrrnnneeecccccc",
        "abaaaaacccccccccccaaaaaaacccccccccaaaaaaccccccjjjqqqtttxxxxxyyyyyvvvrrrnnneeecccccc",
        "abaaacccccccccccaaaaaaaccaaccccccccccaaccaaaaajjjqqqttttxxxxyyyyyyvvrrrnnneeecccccc",
        "abaaacccccccccccaaaaaaaccaaacaaacccccccccaaaaajjjjqqqtttttxxyywyyyywvrrnnnfeecccccc",
        "abcaaacccccccaaaaaaaaaaacaaaaaaaccccccccaaaaaaciiiiqqqqtttxwyywwyywwwrrrnnfffcccccc",
        "abcccccccccccaaaaaaaaaaccaaaaaacccccccccaaaaaacciiiiqqqqttwwywwwwwwwwrrrnnfffcccccc",
        "abccccccccccccaaaaaacccaaaaaaaacccccccccaaaaaaccciiiiqqqttwwwwwswwwwrrrrnnfffcccccc",
        "abccccccccccccaaaaaacccaaaaaaaaacccccccccaaacccccciiiqqqtswwwwssssrrrrrroofffcccccc",
        "abccccccaaaaacaaaaaacccaaaaaaaaaaccccccccccccccccciiiqqqssswsssssssrrrrooofffaccccc",
        "abccccccaaaaacaaccaaccccccaaacaaacccccccccccccccccciiiqqssssssspoorrrooooofffaacccc",
        "abcccccaaaaaacccccccccccccaaacccccccccccccccccccccciiiqppssssspppooooooooffffaacccc",
        "abcccccaaaaaacccccccccccccaacccccccccccccccccccccccciipppppppppppoooooooffffaaccccc",
        "abcccccaaaaaaccccccccccccccccccccccccccccccccccccccciihppppppppgggggggggfffaaaccccc",
        "abccccccaaacccccccccccccccccccccccaccccccccccccccccchhhhpppppphggggggggggfaaaaccccc",
        "abaaaccccccccccccccccccccccaccccaaacccccccccccccccccchhhhhhhhhhgggggggggcaacccccccc",
        "abaaccaaaccaccccccccccccccaaacccaaacaacccaaaaacccccccchhhhhhhhhgaaccccccccccccccccc",
        "abaaacaaacaacccccccccaaaccaaaacaaaaaaaaccaaaaaccccccccchhhhhhaaaaacccccccccccccccca",
        "abaaaccaaaaaccccccccccaaacaaaaaaaacaaaaccaaaaaaccccccccccaaacccaaaacccccccccccaccca",
        "abcccaaaaaaccccccccccaaaaaaaaaaaaacaaaaccaaaaaaccccccccccaaaccccaaaccccccccccaaaaaa",
        "abcccaaaaaaaacccccccaaaaaaaaaaaaaaaaaccccaaaaaacccccccccccccccccccccccccccccccaaaaa",
        "abcccaacaaaaaccccccaaaaaaaaaaaaaaaaaaacccccaacccccccccccccccccccccccccccccccccaaaaa",];
        
        var out:Array<Array<Int>> = [];
        for (y=>row in input) {
            var rowCode:Array<Int> = [];
            for (x=>code in row) {
                switch(code) {
                    case(83): // S
                        code = 0;
                        start = {x:x, y:y};
                    case(69): // E
                        code = 25;
                        end = {x:x, y:y};
                    case(_): code -= 97;
                }
                rowCode.push(code);
            }
            out.push(rowCode);
        }
        return out;
    }

    static function main() new Test();
}
