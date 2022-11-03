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

.globl _g_palette0
.globl _g_palette1
.globl _s_font_0
.globl _s_font_1
.globl _s_small_numbers_00
.globl _s_small_numbers_01
.globl _s_small_numbers_02
.globl _s_small_numbers_03
.globl _s_small_numbers_04
.globl _s_small_numbers_05
.globl _s_small_numbers_06
.globl _s_small_numbers_07
.globl _s_small_numbers_08
.globl _s_small_numbers_09
.globl _sp_ball_0
.globl _sp_ball_1

;;===============================================================================
;; CPCTELERA FUNCTIONS
;;===============================================================================
.globl cpct_disableFirmware_asm
.globl cpct_getScreenPtr_asm
.globl cpct_drawSprite_asm
.globl cpct_setVideoMode_asm
.globl cpct_setPalette_asm
.globl cpct_setPALColour_asm
.globl cpct_memset_asm
.globl cpct_getScreenToSprite_asm
.globl cpct_scanKeyboard_asm
.globl cpct_scanKeyboard_if_asm
.globl cpct_isKeyPressed_asm
.globl cpct_waitHalts_asm
.globl cpct_drawSolidBox_asm
.globl cpct_getRandom_xsp40_u8_asm
.globl cpct_setSeed_xsp40_u8_asm
.globl cpct_isAnyKeyPressed_asm
.globl cpct_setInterruptHandler_asm
.globl cpct_waitVSYNC_asm
.globl cpct_drawSpriteBlended_asm
.globl _cpct_keyboardStatusBuffer
.globl cpct_memset_f64_asm
.globl cpct_getRandom_mxor_u8_asm
.globl cpct_waitVSYNCStart_asm
.globl cpct_setSeed_mxor_asm

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

;;tipos de entidades
e_type_invalid              = 0x00
e_type_card_in_hand         = 0x01
e_type_card_in_cemetery     = 0x02
e_type_card_in_sacrifice    = 0x04

;;tipos de componentes
e_cmp_render = 0x01     ;;entidad renderizable
e_cmp_movable = 0x02    ;;entidad que se puede mover
e_cmp_input = 0x04      ;;entidad controlable por input  
e_cmp_ia = 0x08         ;;entidad controlable con ia
e_cmp_animated = 0x10   ;;entidad animada
e_cmp_collider = 0x20   ;;entidad que puede colisionar
e_cmp_default = e_cmp_render | e_cmp_movable | e_cmp_collider  ;;componente por defecto


;; Keyboard constants
BUFFER_SIZE = 10
ZERO_KEYS_ACTIVATED = #0xFF

;; Score constants
SCORE_NUM_BYTES = 4

;; SMALL NUMBERS CONSTANTS
S_SMALL_NUMBERS_WIDTH = 2
S_SMALL_NUMBERS_HEIGHT = 5
;; Font constants
FONT_WIDTH = 2
FONT_HEIGHT = 9


;;===============================================================================
;; DEFINED MACROS
;;===============================================================================
.mdelete BeginStruct
.macro BeginStruct struct
    struct'_offset = 0
.endm

.mdelete Field
.macro Field struct, field, size
    struct'_'field = struct'_offset
    struct'_offset = struct'_offset + size
.endm

.mdelete EndStruct
.macro EndStruct struct
    sizeof_'struct = struct'_offset
.endm

;;===============================================================================
;; Macro
;;
;; Macro modified from cpctelera cpctm_screenPtr_asm
;;===============================================================================

.mdelete m_center_screen_ptr 
.macro m_center_screen_ptr REG16, VMEM, Y, WIDTH
   ld REG16, #VMEM + 80 * (Y / 8) + 2048 * (Y & 7) + ((80 - WIDTH)/2)   ;; [3] REG16 = screenPtr
.endm

