#!/bin/bash
 
export INSTALL_ROOT=$HOME/dev
mkdir $INSTALL_ROOT
mkdir $INSTALL_ROOT/b
mkdir $INSTALL_ROOT/d
mkdir $INSTALL_ROOT/i
cd $INSTALL_ROOT
 
export PATH=$INSTALL_ROOT/i/bin:$PATH
 
wget http://download.qt.io/snapshots/qt/5.6/5.6.0-beta/latest_src/qt-everywhere-opensource-src-5.6.0-beta.tar.gz
 
tar -xvf qt-everywhere-opensource-src-5.6.0-beta.tar.gz -C $INSTALL_ROOT
 
cd qt-everywhere-opensource-src-5.6.0-beta
    
sudo apt-get -y build-dep qt5-defauklt
#sudo apt-get install libxcb1 libxcb1-dev libx11-xcb1 libx11-xcb-dev libxcb-keysyms1 libxcb-keysyms1-dev libxcb-image0 libxcb-image0-dev libxcb-shm0 libxcb-shm0-dev libxcb-icccm4 libxcb-icccm4-dev libxcb-sync1 libxcb-sync-dev libxcb-xfixes0-dev libxrender-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0 libxcb-render-util0-dev libxcb-glx0-dev
 
./configure -prefix $INSTALL_ROOT/i \
    -skip qt3d \
    -skip qtactiveqt \
    -skip qtcanvas3d \
    -skip qtconnectivity \
    -skip qtdeclarative \
    -skip qtdoc \
    -skip qtenginio \
    -skip qtgraphicaleffects \
    -skip qtlocation \
    -skip qtmultimedia \
    -skip qtsensors \
    -skip qtserialport \
    -skip qtwayland \
    -skip qtwebchannel \
    -skip qtwebengine \
    -skip qtwebsockets \
    -skip qtxmlpatterns \
    -opensource -confirm-license \
    -qt-xkbcommon-x11 -qt-xcb -xcb-xlib

make

cd qtbase
$INSTALL_ROOT/i/bin/qmake
make
make install

cd ../qtdeclarative
$INSTALL_ROOT/i/bin/qmake
make
make install

cd ../qtscript
$INSTALL_ROOT/i/bin/qmake
make
make install

cd ../qtsvg
$INSTALL_ROOT/i/bin/qmake
make
make install

cd ../qttools
$INSTALL_ROOT/i/bin/qmake
make
make install

cd ../qtx11extras
$INSTALL_ROOT/i/bin/qmake
make
make install


cd $INSTALL_ROOT

sudo apt-get install git

git clone git://anongit.kde.org/krita.git

cd b

sudo apt-get install cmake

cmake ../krita/3rdparty -DINSTALL_ROOT=$INSTALL_ROOT/i -DEXTERNALS_DOWNLOAD_DIR=$INSTALL_ROOT/d -DCMAKE_INSTALL_PREFIX=$INSTALL_ROOT/i

sudo apt-get install zlib1g-dev
sudo apt-get install bzip2
sudo apt-get install liblzma-dev

cmake --build . --config RelWithDebInfo --target ext_kcrash
