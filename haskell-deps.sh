#!/bin/bash
if [ `whoami` = 'root' ]; then echo "This program must NOT be run using 'sudo'"; exit; fi

rm -rf temp
stack new temp
cd temp
stack install aeson async containers doctest hspec parsec postgresql-typed QuickCheck sensei servant stm text time utf8-string wai wai-cors wai-websockets warp websockets
cd ..
rm -rf temp
