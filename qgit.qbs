import qbs

QtGuiApplication{
    Depends {name:"Qt.widgets"}
    name:"qgit"

    targetName:{
        if(qbs.buildVariant == "debug")
            return "qgitd"
        else
            return "qgit"
    }
    Group {
            name: "app install"
            fileTagsFilter: "application"
            qbs.install: true
            qbs.installDir: "bin"
        }

    Group{
        name: "res"
        prefix: "src/"
        files: ["*.qrc", "*.rc"]
    }
    Group{
        name:"text"
        files:["*.txt","src/*.txt"]
    }
    Group{
        name:"src"
        prefix:"src/"
        files:["*.h","*.hpp","*.cpp", "*.ui"]
    }

    cpp.commonCompilerFlags: {
        var flags = base;
        if(cpp.compilerName.contains("g++"))
            flags = flags.concat(["-fdata-sections","-ffunction-sections","-flto"])
        return flags
    }
    cpp.cxxFlags:{
        var flags = base
        if(cpp.compilerName.contains("g++"))
            flags = flags.concat(["-std=gnu++11","-flto"])
        return flags
    }
    cpp.linkerFlags:{
        var flags = base
        if(cpp.compilerName.contains("g++") && (qbs.buildVariant == "debug")){
            flags = flags.concat(["-Wl,--gc-sections","-flto"])
        }
        return flags
    }

    cpp.includePaths:{
        var inc_paths = base.concat(["src"])
        return inc_paths
    }
}
