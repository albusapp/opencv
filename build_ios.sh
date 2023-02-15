mkdir -p .build/iphoneos
mkdir -p .build/iphonesimulator

python3 platforms/ios/build_framework.py .build/iphoneos --disable-bitcode --iphoneos_archs arm64 --iphonesimulator_archs=""
python3 platforms/ios/build_framework.py .build/iphonesimulator --disable-bitcode --iphonesimulator_archs x86_64,arm64 --iphoneos_archs=""
xcodebuild -create-xcframework -framework .build/iphoneos/opencv2.framework -framework .build/iphonesimulator/opencv2.framework -output .build/opencv2.xcframework

# Building requires cmake 3.24.0 (3.25 has a regression)
# The script will try to run `lipo` on all generated archives, however iphoneos.arm64 and iphonesimulator.arm64 are the same arch and can't be merged
# So the script has been modified to allow building only iphoneos or iphonesimulator at a time so that we can make one final universal xcframework without lipo

# Troubleshooting:
#   https://github.com/opencv/opencv/issues/22784
#   https://github.com/opencv/opencv/issues/23156
#   https://github.com/opencv/opencv/issues/21571
#   https://stackoverflow.com/questions/70360028/cannot-lipo-arm64-a-files-of-ios-device-with-ios-simulator-on-apple-silicon
#   https://developer.apple.com/forums/thread/666335