#/usr/bin/bash
rm -rf etally_core
git clone https://github.com/martinsk/etally_core.git
cd etally_core
make
cd .. 
mkdir priv
cp etally_core/etally_srv priv/etally_srv
rm -rf etally_core
