import "config" as $CONFIG {search: "~/.config/jqp"};

def defaultConfig: {
    "priority": {
        "@timestamp": 1,
        "level": 2,
        "message": 3
    },
    "colour": {
        "@timestamp": "cyan",
        "level": "magenta",
        "message": "green"
    },
    "fieldKeyColour": "blue"
};

def getConfig($key):
    $CONFIG::CONFIG[] // {}
    | if has($key) then
        .[$key]
    else
        defaultConfig[$key]
    end;

def noPriority: 999999;
def noColour: "";

def escape: "\u001b";

def colours: {
    "black": "[30m",
    "red": "[31m",
    "green": "[32m",
    "yellow": "[33m",
    "blue": "[34m",
    "magenta": "[35m",
    "cyan": "[36m",
    "lightgray": "[37m",
    "darkgray": "[90m",
    "lightred": "[91m",
    "lightgreen": "[92m",
    "lightyellow": "[93m",
    "lightblue": "[94m",
    "lightmagenta": "[95m",
    "lightcyan": "[96m",
    "white": "[97m",
    "reset": "[0m",
};

def coloured($text; $colour):
    if $colour == noColour then
        $text
    else
        escape + colours[colour] + text + escape + colours.reset
    end;

def addColourField: . + {colour: (getConfig("colour")[.key] // noColour)};

def addPriorityField: . + {priority: (getConfig("priority")[.key] // noPriority)};

def processEntries: map(addColourField) | map(addPriorityField) | sort_by(.priority);

def buildKey:
    if .priority != noPriority then
        empty
    else
        coloured(.key; getConfig("fieldKeyColour"))
    end;

def buildValue: coloured(.value | tostring; .colour);

def buildKVPair: [buildKey, buildValue];

def formatKVPair: join("=");

def buildLogLine: map(buildKVPair | formatKVPair) | join(" ");

def main: . as $in | try (fromjson | to_entries | processEntries | buildLogLine) catch $in;
