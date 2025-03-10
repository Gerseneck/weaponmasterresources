#!/bin/bash

WM_RESOURCES_VERSION="1.0.0" # TODO: Make this tag compatible

mkdir -p out/
mkdir -p .temp/

function cp_common() {
    mkdir -p .temp/assets/

    cp -n CREDITS.txt .temp/
    cp -n LICENSE .temp/
    cp -n pack.png .temp/
    cp -n README.md .temp/

    cp -rn assets/minecraft/ .temp/assets/
    cp -rn assets/wm/ .temp/assets/
    cp -rn assets/common/* .temp/assets/wm/

    for item in $(find assets/common/textures/* -depth -maxdepth 0 -type d -printf "%f\n")
    do
        cp assets/common/textures/$item/* .temp/assets/minecraft/optifine/cit/$item/
    done
}

for version in $(find src/* -depth -maxdepth 0 -type d -printf "%f\n")
do
    echo -e "\033[0;33mBuilding Version \033[1;37m$version\033[0;33m!\033[0;0m"

    cp -rn src/$version/* .temp/

    cp_common

    filename="out/WM-Resources-$WM_RESOURCES_VERSION-$version.zip"

    cd .temp/
    zip -r "../$filename" .
    cd ../

    echo -e "\033[0;32mVersion \033[1;37m$version\033[0;32m successfully built! zip file at \033[1;37m$filename\033[0;32m.\033[0;0m"

    echo -e "\033[0;33mCleaning up build files for \033[1;37m$version\033[0;33m!\033[0;0m"
    rm -r .temp/*
    echo -e "\033[0;32mAuxiliary files for \033[1;37m$version\033[0;32m successfully cleaned!.\033[0;0m"
    
    echo "---------------------------------------------------------------------------------------------------------------------------------------------------"
done
