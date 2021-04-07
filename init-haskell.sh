#! /bin/bash

rm -rf temp
stack new temp
cd temp
stack install aeson async containers doctest hspec parsec postgresql-typed QuickCheck sensei servant stm text time utf8-string wai wai-websockets warp websockets
stack build

cd ..
rm -rf temp
rm init-haskell.sh
