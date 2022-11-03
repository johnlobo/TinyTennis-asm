;;-----------------------------LICENSE NOTICE------------------------------------
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;-------------------------------------------------------------------------------

;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"
.include "common.h.s"
.include "sys/system.h.s"
.include "sys/render.h.s"
.include "sys/text.h.s"
.include "sys/messages.h.s"
.include "man/menu.h.s"
;;.include "sys/board.h.s"
;;.include "sys/input.h.s"
;;.include "man/entity.h.s"
;;.include "man/game.h.s"
;;.include "sys/audio.h.s"
;;.include "sys/score.h.s"
;;.include "sys/files.h.s"

.module main

;;-----------------------------------------------------------------
;;
;; Start of _DATA area 
;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
;;  right after _CODE area contents.
;;
.area _DATA

_game_loaded_string: .asciz " GAME LOADED "      ;;27 chars, 54 bytes


;;
;; Start of _CODE area
;; 
.area _CODE


;;-----------------------------------------------------------------
;;
;; main_init
;;   Draw player1
;;  Input:  
;;  Output: 
;;  Destroyed: af, bc,de, hl
;;
_main_init::

      call sys_render_init

      ld e, #6                            ;; x
      ld d, #78                           ;; y
      ld b, #44                           ;; h
      ld c, #60                           ;; w
      ld hl, #_game_loaded_string         ;; message
      ld a, #1                            ;; wait for a key
      call sys_messages_show

      ;; set random seed using hl form message show

      call cpct_setSeed_mxor_asm

      cpctm_clearScreen_asm 0

      ;;call sys_input_init

      ret
;;-----------------------------------------------------------------
;;
;; MAIN function. This is the entry point of the application.
;;    _main:: global symbol is required for correctly compiling and linking
;;
_main::

   ld sp, #0x8000                               ;; Move the stack to 0x8000

   call sys_system_disable_firmware

   call _main_init

start:
   call man_menu_drawMenu

   ;; Loop forever
loop:
;;   call man_game_update

   jr    loop