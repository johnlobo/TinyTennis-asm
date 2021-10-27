ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 .globl _g_palette0
                             20 .globl _g_palette1
                             21 .globl _s_font_0
                             22 .globl _s_font_1
                             23 
                             24 ;;===============================================================================
                             25 ;; CPCTELERA FUNCTIONS
                             26 ;;===============================================================================
                             27 .globl cpct_disableFirmware_asm
                             28 .globl cpct_getScreenPtr_asm
                             29 .globl cpct_drawSprite_asm
                             30 .globl cpct_setVideoMode_asm
                             31 .globl cpct_setPalette_asm
                             32 .globl cpct_setPALColour_asm
                             33 .globl cpct_memset_asm
                             34 .globl cpct_getScreenToSprite_asm
                             35 .globl cpct_scanKeyboard_asm
                             36 .globl cpct_scanKeyboard_if_asm
                             37 .globl cpct_isKeyPressed_asm
                             38 .globl cpct_waitHalts_asm
                             39 .globl cpct_drawSolidBox_asm
                             40 .globl cpct_getRandom_xsp40_u8_asm
                             41 .globl cpct_setSeed_xsp40_u8_asm
                             42 .globl cpct_isAnyKeyPressed_asm
                             43 .globl cpct_setInterruptHandler_asm
                             44 .globl cpct_waitVSYNC_asm
                             45 .globl cpct_drawSpriteBlended_asm
                             46 .globl _cpct_keyboardStatusBuffer
                             47 
                             48 ;;===============================================================================
                             49 ;; DEFINED CONSTANTS
                             50 ;;===============================================================================
                             51 
                             52 ;;tipos de entidades
                     0000    53 e_type_invalid              = 0x00
                     0001    54 e_type_card_in_hand         = 0x01
                     0002    55 e_type_card_in_cemetery     = 0x02
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                     0004    56 e_type_card_in_sacrifice    = 0x04
                             57 
                             58 ;;tipos de componentes
                     0001    59 e_cmp_render = 0x01     ;;entidad renderizable
                     0002    60 e_cmp_movable = 0x02    ;;entidad que se puede mover
                     0004    61 e_cmp_input = 0x04      ;;entidad controlable por input  
                     0008    62 e_cmp_ia = 0x08         ;;entidad controlable con ia
                     0010    63 e_cmp_animated = 0x10   ;;entidad animada
                     0020    64 e_cmp_collider = 0x20   ;;entidad que puede colisionar
                     0023    65 e_cmp_default = e_cmp_render | e_cmp_movable | e_cmp_collider  ;;componente por defecto
                             66 
                             67 ;;===============================================================================
                             68 ;; DEFINED MACROS
                             69 ;;===============================================================================
                             70 .mdelete BeginStruct
                             71 .macro BeginStruct struct
                             72     struct'_offset = 0
                             73 .endm
                             74 
                             75 .mdelete Field
                             76 .macro Field struct, field, size
                             77     struct'_'field = struct'_offset
                             78     struct'_offset = struct'_offset + size
                             79 .endm
                             80 
                             81 .mdelete EndStruct
                             82 .macro EndStruct struct
                             83     sizeof_'struct = struct'_offset
                             84 .endm
                             85 
