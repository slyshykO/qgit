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
        files: ["*.qrc", "*.rc"]
    }
    Group{
        name:"text"
        files:["../*.txt","*.txt"]
    }
    Group{
        name:"gui"
        prefix:"gui/"
        files:["*.h","*.hpp","*.cpp", "*.ui"]
    }
    Group{
        name:"git"
        prefix:"git/"
        files:["*.h","*.hpp","*.cpp", "*.ui"]
    }
    Group{
        name:"app"
        prefix:"app/"
        files:["*.h","*.hpp","*.cpp", "*.ui"]
    }

    cpp.minimumWindowsVersion:"6.1"
    cpp.enableExceptions:true
    cpp.cxxLanguageVersion:"c++14"

    cpp.commonCompilerFlags: {
        var flags = base;
        if(cpp.compilerName.contains("g++"))
            flags = flags.concat(["-fdata-sections","-ffunction-sections"])
        if(cpp.compilerName.contains("g++") && (qbs.buildVariant == "release"))
            flags = flags.concat(["-flto"])
        return flags
    }
    cpp.cxxFlags:{
        var flags = base
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
        var inc_paths = base.concat([".","gui","git","app"])
        return inc_paths
    }
}
