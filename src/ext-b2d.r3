REBOL [
	title: "Blen2D module builder"
	type: module
]

cmd-words: [
	;@@ order of these is important!
	line
	cubic
	quad

	polygon
	shape
	box
	circle
	ellipse
	arc
	image
	text
	fill-all ; fills all context area

	pen
	fill
	line-width
	line-cap
	line-join
	alpha
	blend     ; blend-mode?
	composite ; composite-mode?

	reset-matrix
	rotate
	scale
	translate

	font
	;- aliases (for compatibility)
	fill-pen ; alias for `fill` 
]
arg-words: [
	;@@ order of these is important!
	;- pattern/gradient modes
	pad              ; BL_EXTEND_MODE_PAD = 0,
	tile             ; BL_EXTEND_MODE_REPEAT = 1,
	flip             ; BL_EXTEND_MODE_REFLECT = 2,
	tile-y           ; BL_EXTEND_MODE_PAD_X_REPEAT_Y = 3,
	flip-y           ; BL_EXTEND_MODE_PAD_X_REFLECT_Y = 4,
	tile-x           ; BL_EXTEND_MODE_REPEAT_X_PAD_Y = 5,
	tile-x-flip-y    ; BL_EXTEND_MODE_REPEAT_X_REFLECT_Y = 6,
	flip-x           ; BL_EXTEND_MODE_REFLECT_X_PAD_Y = 7,
	flip-x-tile-y    ; BL_EXTEND_MODE_REFLECT_X_REPEAT_Y = 8,
	;- gradient types:
	linear
	radial
	conical
	;- blend modes:
	source-over      ; BL_COMP_OP_SRC_OVER = 0,
 	source-copy      ; BL_COMP_OP_SRC_COPY = 1,
  	source-in        ; BL_COMP_OP_SRC_IN = 2,
	source-out       ; BL_COMP_OP_SRC_OUT = 3,
	source-atop      ; BL_COMP_OP_SRC_ATOP = 4,
	destination-over ; BL_COMP_OP_DST_OVER = 5,
	destination-copy ; BL_COMP_OP_DST_COPY = 6,
	destination-in   ; BL_COMP_OP_DST_IN = 7,
	destination-out  ; BL_COMP_OP_DST_OUT = 8,
	destination-atop ; BL_COMP_OP_DST_ATOP = 9,
	xor              ; BL_COMP_OP_XOR = 10,
	clear            ; BL_COMP_OP_CLEAR = 11,
	plus             ; BL_COMP_OP_PLUS = 12,
	minus            ; BL_COMP_OP_MINUS = 13,
	multiply         ; BL_COMP_OP_MULTIPLY = 14,
	screen           ; BL_COMP_OP_SCREEN = 15,
	overlay          ; BL_COMP_OP_OVERLAY = 16,
	darken           ; BL_COMP_OP_DARKEN = 17,
	lighten          ; BL_COMP_OP_LIGHTEN = 18,
	color-dodge      ; BL_COMP_OP_COLOR_DODGE = 19,
	color-burn       ; BL_COMP_OP_COLOR_BURN = 20,
	linear-burn      ; BL_COMP_OP_LINEAR_BURN = 21,
	linear-light     ; BL_COMP_OP_LINEAR_LIGHT = 22,
	pin-light        ; BL_COMP_OP_PIN_LIGHT = 23,
	hard-light       ; BL_COMP_OP_HARD_LIGHT = 24,
	soft-light       ; BL_COMP_OP_SOFT_LIGHT = 25,
	difference       ; BL_COMP_OP_DIFFERENCE = 26,
	exclusion        ; BL_COMP_OP_EXCLUSION = 27,
	;- line-cap:
	miter
	bevel
	round
	;- arc types:
	pie
	closed ; same as pie
	chord
	;------------------------------



;	stroke-alignment
;	center
;	inner
;	outer


]

commands: [
	init-words: [cmd-words [block!] arg-words [block!]]
	;--------------------------

	draw-test: [
		{Draws test}
		image [image! pair!]
	]
	draw: [
		{Draws scalable vector graphics to an image}
		image [image! pair!]
		commands [block!]
	]
	text: [str [string!]]
	info: ["Prints info about Blend2D library"]

	;--------------------------
	fill-pen: [
		"Sets the area fill pen color"
		pen [tuple! image! logic!] "Set to OFF to disable fill pen"
	]
	box: [
		"Draws a rectangular box."
		origin [pair!] "Corner of box"
		end [pair!] "End of box"
		corner-radius [number!] "Rounds corners"
	]
]



header: {REBOL [Title: {Blend2D} Type: module Exports: [draw]]}
enum-commands: {enum b2d_commands ^{}
enum-cmd-words: {enum b2d_cmd_words ^{W_B2D_CMD_0,}
enum-arg-words: {enum b2d_arg_words ^{W_B2D_ARG_0,}

foreach word cmd-words [
	word: uppercase form word
	replace/all word #"-" #"_"
	append enum-cmd-words ajoin ["^/^-W_B2D_CMD_" word #","]
]
foreach word arg-words [
	word: uppercase form word
	replace/all word #"-" #"_"
	append enum-arg-words ajoin ["^/^-W_B2D_ARG_" word #","]
]



foreach [name spec] commands [
	append header ajoin [lf name ": command "]
	new-line/all spec false
	append/only header mold spec

	name: uppercase form name
	replace/all name #"-" #"_"
	append enum-commands ajoin ["^/^-CMD_B2D_" name #","]
]

new-line/all cmd-words false
new-line/all arg-words false
append header rejoin [{^/init-words words: } mold cmd-words #" " mold arg-words]
append header {
system/dialects/draw:
dial-draw: context [
	type-spec:		[block!]
	fill-pen:       [tuple! image! logic!]
	box:            [pair! pair! decimal!]
	line:           [* pair!]
]}

print header

out: make string! 2000
append out {// auto-generated file, do not modify! //

#include "reb-host.h"
#include "host-lib.h"
#include <blend2d.h>
#include <math.h> // floor

#ifndef BL_BUILD_STATIC
#pragma comment(lib,"blend2d.lib")
#endif

RL_LIB *RL; // Link back to reb-lib from embedded extensions

}
append out join enum-commands "^/};^/"
append out join enum-cmd-words "^/};^/"
append out join enum-arg-words "^/};^/"
append out {const char *init_block =}


foreach line split header lf [
	replace/all line #"^"" {\"}
	append out ajoin [{^/^-"} line {\n"}] 
]
append out ";"

print out

write %ext-b2d.h out
