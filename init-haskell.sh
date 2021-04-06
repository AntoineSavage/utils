#! /bin/bash

# copy/paste the following line
# wget -O init-haskell.sh https://raw.githubusercontent.com/AntoineSavage/utils/main/init-haskell.sh && bash init-haskell.sh

rm -rf temp
stack new temp
cd temp
stack install aeson async doctest hspec parsec postgresql-typed QuickCheck sensei servant stm text time utf8-string wai wai-websockets warp websockets
stack build

cd ..
rm -rf temp
rm init-haskell.sh
