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
        name: "x_res"
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
    Group{
        name:"gui"
        prefix:"src/gui/"
        files:["*.h","*.hpp","*.cpp", "*.ui"]
    }

    cpp.commonCompilerFlags: {
        var flags = base;
        if(cpp.compilerName.contains("g++"))
            flags = flags.concat(["-fdata-sections","-ffunction-sections","-flto"])
        if(cpp.compilerName.contains("g++") && (qbs.buildVariant == "release"))
            flags = flags.concat(["-flto"])
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
        if(cpp.compilerName.contains("g++") ){
            flags = flags.concat(["-Wl,--gc-sections"])
        }
        if(cpp.compilerName.contains("g++") && (qbs.buildVariant == "release"))
            flags = flags.concat(["-flto"])
        return flags
    }

    cpp.includePaths:{
        var inc_paths = base.concat(["src","src/gui"])
        return inc_paths
    }
}
