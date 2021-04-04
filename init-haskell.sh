#! /bin/bash
stack new temp
stack install aeson async doctest hspec parsec postgresql-typed QuickCheck sensei servant stm text wai wai-websockets warp websockets
stack build

cd ..
rm -rf temp
