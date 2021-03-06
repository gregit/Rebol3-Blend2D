// auto-generated file, do not modify! //

#include "reb-host.h"
#include "host-lib.h"
#include <blend2d.h>
#include <math.h> // floor

#ifndef BL_BUILD_STATIC
#pragma comment(lib,"blend2d.lib")
#endif

RL_LIB *RL; // Link back to reb-lib from embedded extensions

enum b2d_commands {
	CMD_B2D_INIT_WORDS,
	CMD_B2D_DRAW_TEST,
	CMD_B2D_DRAW,
	CMD_B2D_TEXT,
	CMD_B2D_INFO,
	CMD_B2D_FILL_PEN,
	CMD_B2D_BOX,
};
enum b2d_cmd_words {W_B2D_CMD_0,
	W_B2D_CMD_LINE,
	W_B2D_CMD_CUBIC,
	W_B2D_CMD_QUAD,
	W_B2D_CMD_POLYGON,
	W_B2D_CMD_SHAPE,
	W_B2D_CMD_BOX,
	W_B2D_CMD_CIRCLE,
	W_B2D_CMD_ELLIPSE,
	W_B2D_CMD_ARC,
	W_B2D_CMD_IMAGE,
	W_B2D_CMD_TEXT,
	W_B2D_CMD_FILL_ALL,
	W_B2D_CMD_PEN,
	W_B2D_CMD_FILL,
	W_B2D_CMD_LINE_WIDTH,
	W_B2D_CMD_LINE_CAP,
	W_B2D_CMD_LINE_JOIN,
	W_B2D_CMD_ALPHA,
	W_B2D_CMD_BLEND,
	W_B2D_CMD_COMPOSITE,
	W_B2D_CMD_RESET_MATRIX,
	W_B2D_CMD_ROTATE,
	W_B2D_CMD_SCALE,
	W_B2D_CMD_TRANSLATE,
	W_B2D_CMD_FONT,
	W_B2D_CMD_FILL_PEN,
};
enum b2d_arg_words {W_B2D_ARG_0,
	W_B2D_ARG_PAD,
	W_B2D_ARG_TILE,
	W_B2D_ARG_FLIP,
	W_B2D_ARG_TILE_Y,
	W_B2D_ARG_FLIP_Y,
	W_B2D_ARG_TILE_X,
	W_B2D_ARG_TILE_X_FLIP_Y,
	W_B2D_ARG_FLIP_X,
	W_B2D_ARG_FLIP_X_TILE_Y,
	W_B2D_ARG_LINEAR,
	W_B2D_ARG_RADIAL,
	W_B2D_ARG_CONICAL,
	W_B2D_ARG_SOURCE_OVER,
	W_B2D_ARG_SOURCE_COPY,
	W_B2D_ARG_SOURCE_IN,
	W_B2D_ARG_SOURCE_OUT,
	W_B2D_ARG_SOURCE_ATOP,
	W_B2D_ARG_DESTINATION_OVER,
	W_B2D_ARG_DESTINATION_COPY,
	W_B2D_ARG_DESTINATION_IN,
	W_B2D_ARG_DESTINATION_OUT,
	W_B2D_ARG_DESTINATION_ATOP,
	W_B2D_ARG_XOR,
	W_B2D_ARG_CLEAR,
	W_B2D_ARG_PLUS,
	W_B2D_ARG_MINUS,
	W_B2D_ARG_MULTIPLY,
	W_B2D_ARG_SCREEN,
	W_B2D_ARG_OVERLAY,
	W_B2D_ARG_DARKEN,
	W_B2D_ARG_LIGHTEN,
	W_B2D_ARG_COLOR_DODGE,
	W_B2D_ARG_COLOR_BURN,
	W_B2D_ARG_LINEAR_BURN,
	W_B2D_ARG_LINEAR_LIGHT,
	W_B2D_ARG_PIN_LIGHT,
	W_B2D_ARG_HARD_LIGHT,
	W_B2D_ARG_SOFT_LIGHT,
	W_B2D_ARG_DIFFERENCE,
	W_B2D_ARG_EXCLUSION,
	W_B2D_ARG_MITER,
	W_B2D_ARG_BEVEL,
	W_B2D_ARG_ROUND,
	W_B2D_ARG_PIE,
	W_B2D_ARG_CLOSED,
	W_B2D_ARG_CHORD,
};
const char *init_block =
	"REBOL [Title: {Blend2D} Type: module Exports: [draw]]\n"
	"init-words: command [cmd-words [block!] arg-words [block!]]\n"
	"draw-test: command [\"Draws test\" image [image! pair!]]\n"
	"draw: command [\"Draws scalable vector graphics to an image\" image [image! pair!] commands [block!]]\n"
	"text: command [str [string!]]\n"
	"info: command [\"Prints info about Blend2D library\"]\n"
	"fill-pen: command [\"Sets the area fill pen color\" pen [tuple! image! logic!] \"Set to OFF to disable fill pen\"]\n"
	"box: command [\"Draws a rectangular box.\" origin [pair!] \"Corner of box\" end [pair!] \"End of box\" corner-radius [number!] \"Rounds corners\"]\n"
	"init-words words: [line cubic quad polygon shape box circle ellipse arc image text fill-all pen fill line-width line-cap line-join alpha blend composite reset-matrix rotate scale translate font fill-pen] [pad tile flip tile-y flip-y tile-x tile-x-flip-y flip-x flip-x-tile-y linear radial conical source-over source-copy source-in source-out source-atop destination-over destination-copy destination-in destination-out destination-atop xor clear plus minus multiply screen overlay darken lighten color-dodge color-burn linear-burn linear-light pin-light hard-light soft-light difference exclusion miter bevel round pie closed chord]\n"
	"system/dialects/draw:\n"
	"dial-draw: context [\n"
	"	type-spec:		[block!]\n"
	"	fill-pen:       [tuple! image! logic!]\n"
	"	box:            [pair! pair! decimal!]\n"
	"	line:           [* pair!]\n"
	"]\n";