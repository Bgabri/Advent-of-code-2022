using StringTools;
// haxe --interp --main Day07.hx



@:structInit class Directory extends File {
    // public var files:Array<File> = [];
    public var files:Array<File> = [];

    public function dir(name:String) {
        var newDir:Directory = null;
        for (file in files) if (file.name == name) newDir = cast(file, Directory);
        return newDir;
    }

    public function getDirs() {
        var newDirs:Array<Directory> = [];
        for (file in files) {
            if (file.type == "dir") {
                var dir = cast(file, Directory);
                newDirs.push(dir);
                newDirs = newDirs.concat(dir.getDirs());
            }
        }
        return newDirs;
    }



    public function addDir(dir:Directory) {
        files.push(dir);
    }

    public function addFile(file:File) {
        files.push(file);
    }

    public function calcSize() {
        size = 0;
        for (file in files) {
            if (file.type == "dir") {
                var dir = cast(file, Directory);
                dir.calcSize();
                size += dir.size;
            } else size += file.size;
        }
    }

    override public function get_type() {
        return "dir";
    }
}

@:structInit class File {
    public var size:Int = 0;
    public var name:String = "";
    public var parent:Directory;
    public var type(get, null) = "";
    public function get_type() {
        return "file";
    }
}



class Day07 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/07.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/07.txt")));    
    }

    static function part1(input:Directory):Int {
        input.calcSize();
        
        var total = 0;

        var dirs = input.getDirs();
        for (dir in dirs) if (dir.size < 100000) total += dir.size;

        return total;
    }

    static function part2(input:Directory):Int {
        input.calcSize();
        var deleteSize:Int = 30000000-(70000000-input.size);


        var minSize:Int = 70000000;

        var dirs = input.getDirs();
        for (dir in dirs) {
            if (dir.size < minSize && dir.size > deleteSize) 
                minSize = dir.size;
        }

        return minSize;
    }

    static function loadFile(file:String):Directory {
        var input:Directory = {name:"/", parent: null};

        var iterator = sys.io.File.read(file, false);
        

        var currentDir:Directory = input;
        while (!iterator.eof()){
            var line = iterator.readLine();
            var inp = line.split(" ");
            switch inp {
                case ["$","cd","/"]: currentDir = input;
                case ["$","cd",".."]: currentDir = currentDir.parent;
                case ["$","cd",dir]: currentDir = currentDir.dir(dir);
                case ["$","ls"]: 
                case ["dir",dir]: currentDir.addDir({name: dir, parent: currentDir});
                case [size,file]: currentDir.addFile({name: file, size: Std.parseInt(size), parent: currentDir});
                case _:
            }
        }

        iterator.close();

        return input;
    }
}
