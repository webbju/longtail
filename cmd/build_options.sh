#!/bin/bash

export TARGET=longtail

LIB_SRC="$BASE_DIR/lib/filestorage/*.c"
LIB_THIRDPARTY_SRC="$BASE_DIR/src/ext/*.c"

FILESTORAGE_SRC="$BASE_DIR/lib/*.c"

MEMSTORAGE_SRC="$BASE_DIR/lib/memstorage/*.c"

MEOWHASH_SRC="$BASE_DIR/lib/meowhash/*.c"

BIKESHED_SRC="$BASE_DIR/lib/bikeshed/*.c"

BLAKE2_SRC="$BASE_DIR/lib/blake2/*.c"
BLAKE2_THIRDPARTY_SRC="$BASE_DIR/lib/blake2/ext/*.c"

LIZARD_SRC="$BASE_DIR/lib/lizard/*.c"
LIZARD_THIRDPARTY_SRC="$BASE_DIR/lib/lizard/ext/*.c $BASE_DIR/lib/lizard/ext/entropy/*.c $BASE_DIR/lib/lizard/ext/xxhash/*.c"

BROTLI_SRC="$BASE_DIR/lib/brotli/*.c"
BROTLI_THIRDPARTY_SRC="$BASE_DIR/lib/brotli/ext/common/*.c $BASE_DIR/lib/brotli/ext/dec/*.c $BASE_DIR/lib/brotli/ext/enc/*.c $BASE_DIR/lib/brotli/ext/fuzz/*.c"

export SRC="$BASE_DIR/cmd/main.cpp $BASE_DIR/src/*.c $LIB_SRC $FILESTORAGE_SRC $MEMSTORAGE_SRC $MEOWHASH_SRC $BIKESHED_SRC $BLAKE2_SRC $LIZARD_SRC $BROTLI_SRC"
export TEST_SRC=""
export THIRDPARTY_SRC="$LIB_THIRDPARTY_SRC $BLAKE2_THIRDPARTY_SRC $LIZARD_THIRDPARTY_SRC $BROTLI_THIRDPARTY_SRC"
export CXXFLAGS="$CXXFLAGS -pthread"
export CXXFLAGS_DEBUG="$CXXFLAGS_DEBUG -DBIKESHED_ASSERTS"
