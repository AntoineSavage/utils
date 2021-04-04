#! /bin/bash

# copy/paste the following line
# wget -q https://raw.githubusercontent.com/AntoineSavage/utils/main/init-haskell.sh && bash init-haskell.sh

rm -rf temp
stack new temp
cd temp
stack install aeson async doctest hspec parsec postgresql-typed QuickCheck sensei servant stm text wai wai-websockets warp websockets
stack build

cd ..
rm -rf temp
