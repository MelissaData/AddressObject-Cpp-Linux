#!/bin/bash

# Name:    MelissaAddressObjectLinuxCpp
# Purpose: Use the MelissaUpdater to make the MelissaAddressObjectLinuxCpp code usable

######################### Constants ##########################

RED='\033[0;31m' #RED
NC='\033[0m' # No Color

######################### Parameters ##########################

address=""
city=""
state=""
zip=""
license=""
quiet="false"

while [ $# -gt 0 ] ; do
    case $1 in
        -a | --address) 
            address="$2"

            if [ "$address" == "-c" ] || [ "$address" == "--city" ] || [ "$address" == "-s" ] || [ "$address" == "--state" ] || [ "$address" == "-z" ] || [ "$address" == "--zip" ] || [ "$address" == "-l" ] || [ "$address" == "--license" ] || [ "$address" == "-q" ] || [ "$address" == "--quiet" ] || [ -z "$address" ];
            then
                printf "${RED}Error: Missing an argument for parameter \'address\'.${NC}\n"  
                exit 1
            fi  
            ;;
        -c | --city) 
            city="$2"

            if [ "$city" == "-a" ] || [ "$city" == "--address" ] || [ "$city" == "-s" ] || [ "$city" == "--state" ] || [ "$city" == "-z" ] || [ "$city" == "--zip" ] || [ "$city" == "-l" ] || [ "$city" == "--license" ] || [ "$city" == "-q" ] || [ "$city" == "--quiet" ] || [ -z "$city" ];
            then
                printf "${RED}Error: Missing an argument for parameter \'city\'.${NC}\n"  
                exit 1
            fi  
            ;;
        -s | --state) 
            state="$2"

            if [ "$state" == "-c" ] || [ "$state" == "--city" ] || [ "$state" == "-a" ] || [ "$state" == "--address" ] || [ "$state" == "-z" ] || [ "$state" == "--zip" ] || [ "$state" == "-l" ] || [ "$state" == "--license" ] || [ "$state" == "-q" ] || [ "$state" == "--quiet" ] || [ -z "$state" ];
            then
                printf "${RED}Error: Missing an argument for parameter \'state\'.${NC}\n"  
                exit 1
            fi   
            ;;
        -z | --zip) 
            zip="$2"

            if [ "$zip" == "-c" ] || [ "$zip" == "--city" ] || [ "$zip" == "-s" ] || [ "$zip" == "--state" ] || [ "$zip" == "-a" ] || [ "$zip" == "--address" ] || [ "$zip" == "-l" ] || [ "$zip" == "--license" ] || [ "$zip" == "-q" ] || [ "$zip" == "--quiet" ] || [ -z "$zip" ];
            then
                printf "${RED}Error: Missing an argument for parameter \'zip\'.${NC}\n"  
                exit 1
            fi   
            ;;		
        -l | --license) 
            license="$2"

            if [ "$license" == "-c" ] || [ "$license" == "--city" ] || [ "$license" == "-s" ] || [ "$license" == "--state" ] || [ "$license" == "-z" ] || [ "$license" == "--zip" ] || [ "$license" == "-a" ] || [ "$license" == "--address" ] || [ "$license" == "-q" ] || [ "$license" == "--quiet" ] || [ -z "$license" ];
            then
                printf "${RED}Error: Missing an argument for parameter \'license\'.${NC}\n"  
                exit 1
            fi    
            ;;
        -q | --quiet) 
            quiet="true" 
            ;;
    esac
    shift
done

######################### Config ###########################

RELEASE_VERSION='2024.03'
ProductName="DQ_ADDR_DATA"

# Uses the location of the .sh file 
CurrentPath=$(pwd)
ProjectPath="$CurrentPath/MelissaAddressObjectLinuxCpp"

BuildPath="$ProjectPath/Build"
if [ ! -d "$BuildPath" ]; 
then
  mkdir -p "$BuildPath"
fi

DataPath="$ProjectPath/Data" # To use your own data file(s), change to your DQS release data file(s) directory
if [ ! -d "$DataPath" ] && [ "$DataPath" = "$ProjectPath/Data" ]; 
then
  mkdir -p "$DataPath"
fi

# Config variables for download file(s)
Config_FileName1="libmdAddr.so"
Config_ReleaseVersion1=$RELEASE_VERSION
Config_OS1="LINUX"
Config_Compiler1="GCC48"
Config_Architecture1="64BIT"
Config_Type1="BINARY"

Config_FileName2="mdEnums.h"
Config_ReleaseVersion2=$RELEASE_VERSION
Config_OS2="ANY"
Config_Compiler2="C"
Config_Architecture2="ANY"
Config_Type2="INTERFACE"

Config_FileName3="mdAddr.h"
Config_ReleaseVersion3=$RELEASE_VERSION
Config_OS3="ANY"
Config_Compiler3="C"
Config_Architecture3="ANY"
Config_Type3="INTERFACE"


######################## Functions #########################

DownloadDataFiles()
{
    printf "========================== MELISSA UPDATER =========================\n"
    printf "MELISSA UPDATER IS DOWNLOADING DATA FILE(S)...\n"

    ./MelissaUpdater/MelissaUpdater manifest -p $ProductName -r $RELEASE_VERSION -l $1 -t $DataPath 

    if [ $? -ne 0 ];
    then
        printf "\nCannot run Melissa Updater. Please check your license string!\n"
        exit 1
    fi     
    
    printf "Melissa Updater finished downloading data file(s)!\n"
}

DownloadSO() 
{
    printf "\nMELISSA UPDATER IS DOWNLOADING SO(S)...\n"
    
    # Check for quiet mode
    if [ $quiet == "true" ];
    then
        ./MelissaUpdater/MelissaUpdater file --filename $Config_FileName1 --release_version $Config_ReleaseVersion1 --license $1 --os $Config_OS1 --compiler $Config_Compiler1 --architecture $Config_Architecture1 --type $Config_Type1 --target_directory $BuildPath  &> /dev/null
        
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi        
        
        printf "Melissa Updater finished downloading $Config_FileName1!\n"

        ./MelissaUpdater/MelissaUpdater file --filename $Config_FileName2 --release_version $Config_ReleaseVersion2 --license $1 --os $Config_OS2 --compiler $Config_Compiler2 --architecture $Config_Architecture2 --type $Config_Type2 --target_directory $ProjectPath  &> /dev/null
        
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi        
        
        printf "Melissa Updater finished downloading $Config_FileName2!\n"

        ./MelissaUpdater/MelissaUpdater file --filename $Config_FileName3 --release_version $Config_ReleaseVersion3 --license $1 --os $Config_OS3 --compiler $Config_Compiler3 --architecture $Config_Architecture3 --type $Config_Type3 --target_directory $ProjectPath  &> /dev/null
        
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi        
        
        printf "Melissa Updater finished downloading $Config_FileName3!\n"
    else
        ./MelissaUpdater/MelissaUpdater file --filename $Config_FileName1 --release_version $Config_ReleaseVersion1 --license $1 --os $Config_OS1 --compiler $Config_Compiler1 --architecture $Config_Architecture1 --type $Config_Type1 --target_directory $BuildPath  
        
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi        
        
        printf "Melissa Updater finished downloading $Config_FileName1!\n"
        
        ./MelissaUpdater/MelissaUpdater file --filename $Config_FileName2 --release_version $Config_ReleaseVersion2 --license $1 --os $Config_OS2 --compiler $Config_Compiler2 --architecture $Config_Architecture2 --type $Config_Type2 --target_directory $ProjectPath  
        
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi        
        
        printf "Melissa Updater finished downloading $Config_FileName2!\n"
        
        ./MelissaUpdater/MelissaUpdater file --filename $Config_FileName3 --release_version $Config_ReleaseVersion3 --license $1 --os $Config_OS3 --compiler $Config_Compiler3 --architecture $Config_Architecture3 --type $Config_Type3 --target_directory $ProjectPath  

        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi

        printf "Melissa Updater finished downloading $Config_FileName3!\n"
    fi
}

CheckSOs() 
{
    printf "\nDouble checking SO file(s) were downloaded...\n"
    FileMissing=0
    if [ ! -f $BuildPath/$Config_FileName1 ];
    then
        printf "\n$Config_FileName1 not found\n"
        FileMissing=1
    fi
    if [ ! -f $ProjectPath/$Config_FileName2 ];
    then
        printf "\n$Config_FileName2 not found\n"
        FileMissing=1
    fi
    if [ ! -f $ProjectPath/$Config_FileName3 ];
    then
        printf "\n$Config_FileName3 not found\n"
        FileMissing=1
    fi

    if [ $FileMissing -eq 1 ];
    then
        printf "\nMissing the above data file(s).  Please check that your license string and directory are correct."
        echo 0
    else
        echo 1
    fi
}

########################## Main ############################

printf "\n====================== Melissa Address Object ======================\n                      [ C++ | Linux | 64BIT ]\n"
# Get license (either from parameters or user input)
if [ -z "$license" ];
then
    printf "Please enter your license string: "
    read license
fi

# Check for License from Environment Variables 
if [ -z "$license" ];
then
    license=`echo $MD_LICENSE` 
fi

if [ -z "$license" ];
then
    printf "\nLicense String is invalid!\n"
    exit 1
fi

# Use Melissa Updater to download data file(s) 
# Download data file(s) 
DownloadDataFiles $license # Comment out this line if using own DQS release

# Download SO(s)
DownloadSO $license 

# Check if all SO(s) have been downloaded. Exit script if missing
SOsAreDownloaded=$(CheckSOs)

if echo "$SOsAreDownloaded" | grep -q "0";
then
    echo "$SOsAreDownloaded" | sed 's/0$//'
    printf "\nAborting program, see above.\n"
    exit 1
fi

printf "\nAll file(s) have been downloaded/updated!\n"

# Start program
# Build project
printf "\n=========================== BUILD PROJECT ==========================\n"

# Setting the path to the lib in the makefile
LibPath=`grep 'LDFLAGS = ' $ProjectPath/makefile`
NewLibPath="LDFLAGS = -L$ProjectPath/Build"

sed -i -e "s|$LibPath|$NewLibPath|g" $ProjectPath/makefile

# Generate the executable file
cd MelissaAddressObjectLinuxCpp
make &> /dev/null
cd ..

# Export the path to the lib so that the executable knows where to look
export LD_LIBRARY_PATH=$BuildPath

# Run Project
if [ -z "$address" ] && [ -z "$city" ] && [ -z "$state" ] && [ -z "$zip" ];
then
    $BuildPath/MelissaAddressObjectLinuxCpp --license $license --dataPath $DataPath
else
    $BuildPath/MelissaAddressObjectLinuxCpp --license $license --dataPath $DataPath --address "$address" --city "$city" --state "$state" --zip "$zip"
fi
