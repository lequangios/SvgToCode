#git clone https://github.com/lequangios/skia.git
#python2 tools/git-sync-deps
#gn gen out/Clang    --args='cc="clang" cxx="clang++"' --ide=xcode

rm -r SVGPaser/skia/
mkdir SVGPaser/skia
mkdir SVGPaser/skia/src
mkdir SVGPaser/skia/src/core
mkdir SVGPaser/skia/src/xml
mkdir SVGPaser/skia/src/svg

mkdir SVGPaser/skia/experimental
mkdir SVGPaser/skia/experimental/svg

mkdir SVGPaser/skia/include
mkdir SVGPaser/skia/include/utils
mkdir SVGPaser/skia/include/private
mkdir SVGPaser/skia/include/third_party
mkdir SVGPaser/skia/include/core
mkdir SVGPaser/skia/include/svg
mkdir SVGPaser/skia/include/config

mkdir SVGPaser/skia/lib

cp -r skia/src/core/ SVGPaser/skia/src/core/
cp -r skia/src/xml/ SVGPaser/skia/src/xml/
cp -r skia/src/svg/ SVGPaser/skia/src/svg/
cp -r skia/experimental/svg/ SVGPaser/skia/experimental/svg/
cp -r skia/include/private/ SVGPaser/skia/include/private/
cp -r skia/include/core/ SVGPaser/skia/include/utils/
cp -r skia/include/core/ SVGPaser/skia/include/core/
cp -r skia/include/svg/ SVGPaser/skia/include/svg/
cp -r skia/include/third_party/ SVGPaser/skia/include/third_party/
cp -r skia/include/config/ SVGPaser/skia/include/config/

cp -r skia/out/Clang/obj/src/core/ SVGPaser/skia/src/core/
cp -r skia/out/Clang/obj/src/xml/ SVGPaser/skia/src/xml/
cp -r skia/out/Clang/obj/src/svg/ SVGPaser/skia/src/svg/
cp -r skia/out/Clang/obj/experimental/svg/ SVGPaser/skia/experimental/svg/
cp -r skia/out/Clang/obj/include/private/ SVGPaser/skia/include/private/
cp -r skia/out/Clang/obj/include/core/ SVGPaser/skia/include/utils/
cp -r skia/out/Clang/obj/include/core/ SVGPaser/skia/include/core/
cp -r skia/out/Clang/obj/include/svg/ SVGPaser/skia/include/svg/
cp -r skia/out/Clang/obj/include/third_party/ SVGPaser/skia/include/third_party/
cp -r skia/out/Clang/obj/include/config/ SVGPaser/skia/include/config/

