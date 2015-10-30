#!/bin/bash
CC=mxmlc
CCFLAGS=' /home/lot/workspace/pv3d/src/Main.as'
#CCFLAGS+=' -debug=true'
CCFLAGS+=' -static-link-runtime-shared-libraries=true'
CCFLAGS+=' -sp+=/home/lot/sf/tweener-read-only/as3/'
CCFLAGS+=' -sp+=/home/lot/sf/papervision3d/trunk/src/'

#CCFLAGS+=' -library-path+=/home/lot/share/flex4sdk/frameworks/libs/flex.swc'
#CCFLAGS+=' -library-path+=/home/lot/sf/alcon/as3/alcon.swc'
#CCFLAGS+=' -sp+=/home/lot/sf/flashdevelop-read-only/FD3/FlashDevelop/Bin/Debug/Library/AS3/classes/'
CCFLAGS+=' -o /home/lot/workspace/pv3d/bin-debug/main.swf'
(
    echo $CC $CCFLAGS

    while : 
    do read n 
        case $n in 
            r)  # 重新编译
                echo compile 1
                ;; 
            q)  # 退出
                exit
                ;; 
        esac 
    done
) | fcsh
