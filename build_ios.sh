# Requires CMake 4.4.3+

mkdir -p .build

IPHONEOS_DEPLOYMENT_TARGET=16.0 python3 platforms/apple/build_xcframework.py --out .build/opencv2.xcframework --framework_name opencv2 --iphoneos_archs arm64 --iphonesimulator_archs x86_64,arm64 --build_only_specified_archs --disable-bitcode