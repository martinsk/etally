#/usr/bin/bash
rm -rf etally_core
git clone https://github.com/martinsk/etally_core.git
cd etally_core
make
cd .. 
cp etally_core/etally_srv priv/
rm -rf etally_core
