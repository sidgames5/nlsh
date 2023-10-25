class Main {
    static var prefix = "$user/$host $cwd $ ";

    static function load() {
        final config = File.getContent("~/.config/nlsh/nlsh.config").split("\n");
        for (entry in config) {
            if (entry.startsWith("prompt-prefix")) {
                prefix = entry.split("=")[1];
            }
        }
    }

    static function startup() {
        Sys.command("~/.config/nlsh/startup.sh");
    }

    static function exec(command:String) {
        Sys.command(command);
        var log = File.getContent("~/.config/nlsh/history");
        log += command + "\n";
        File.saveContent("~/.config/nlsh/history", log);
    }
    
    static function main() {
        while (true) {
            try {
                prompt();
            } catch (e:Eof) {
                prompt();
            }
        }
    }

    static function prompt() {
        Sys.print(prefix);
        final input = Sys.stdin().readLine();
        exec(input);
    }
}
