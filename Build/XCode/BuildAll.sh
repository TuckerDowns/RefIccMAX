#!/bin/sh
config="Release"

cd ../../IccProfLib
echo "Building IccProfLib..."
xcodebuild -target IccProfLib-macOS -configuration "$config"
cp build/$config/libIccProfLib.a ../Build/XCode/lib

cd ../IccXML/IccLibXML
echo "Building IccXML/IccLibXML..."
xcodebuild -target IccLibXML-macOS -configuration "$config"
cp build/$config/libIccLibXML.a ../../Build/XCode/lib

cd ../../Tools/CmdLine/IccApplyNamedCmm
echo "Building Tools/CmdLine/IccApplyNamedCmm..."
xcodebuild -target IccApplyNamedCMM -configuration "$config"
cp build/$config/IccApplyNamedCmm ../../../Testing

cd ../IccApplyProfiles
echo "Building Tools/CmdLine/IccApplyProfiles..."
xcodebuild -target iccApplyProfiles -configuration "$config"
cp build/$config/IccApplyProfiles ../../../Testing

cd ../IccDumpProfile
echo "Building Tools/CmdLine/IccDumpProfile..."
xcodebuild -target IccDumpProfile -configuration "$config"
cp build/$config/IccDumpProfile ../../../Testing

cd ../IccRoundTrip
echo "Building Tools/CmdLine/IccRoundTrip..."
xcodebuild -target IccRoundTrip -configuration "$config"
cp build/$config/IccRoundTrip ../../../Testing

cd ../IccSpecSepToTiff
echo "Building Tools/CmdLine/IccSpecSepToTiff..."
cp ../IccApplyProfiles/TiffImg.* .
xcodebuild -target IccSpecSepToTiff -configuration "$config"
cp build/$config/IccSpecSepToTiff ../../../Testing

cd ../IccTiffDump
echo "Building Tools/CmdLine/IccTiffDump..."
cp ../IccApplyProfiles/TiffImg.* .
xcodebuild -target IccTiffDump -configuration "$config"
cp build/$config/IccTiffDump ../../../Testing

cd ../../../IccXML/CmdLine/IccFromXml
echo "Building IccXML/CmdLine/IccFromXml..."
xcodebuild -target IccFromXml -configuration "$config"
cp build/$config/IccFromXml ../../../Testing

cd ../../../IccXML/CmdLine/IccToXml
echo "Building IccXML/CmdLine/IccToXml..."
xcodebuild -target IccToXML -configuration "$config"
cp build/$config/IccToXml ../../../Testing

# It would be better to make this condidtion into a positive instead of a 
# negative ("if REFICC_BUILD_GUI"), but that might cause breaking changes
# for other users build environments

if [ ! REFICC_NO_BUILD_GUI ]; then
    cd ../../../Tools/MacOS-X/RefIccMAXCmm
    echo "Building Tools/MacOS-X/RefIccMAXCmm..."
    xcodebuild -target RefIccMAXCmm -configuration "$config"

    cd ../../wxWidget/wxProfileDump/
    echo "Building wxWidget/wxProfileDump..."
    xcodebuild -target wxProfileDump -configuration "$config"
fi
