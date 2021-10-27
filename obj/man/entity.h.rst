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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             19 .include "common.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                     0002    55 e_type_card_in_cemetery     = 0x02
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             20 
                             21 .module entity
                             22 ;;===============================================================================
                             23 ;; CARD DEFINITION MACRO
                             24 ;;===============================================================================
                             25 .macro DefineEntity _status, _class, _sprite, _name, _rarity, _type, _energy, _description, _damage, _block, _vulnerable, _weak, _strengh, _exhaust, _add_card
                             26     .db _status
                             27     .db _class
                             28     .db _sprite
                             29     .asciz "_name"
                             30     .db _rarity
                             31     .db _type
                             32     .db _energy
                             33     .asciz "_description"
                             34     .db _damage
                             35     .db _block
                             36     .db _vulnerable
                             37     .db _weak
                             38     .db _strengh
                             39     .db _exhaust
                             40     .db _add_card
                             41 .endm
                             42 
                             43 ;;===============================================================================
                             44 ;; CARD SCTRUCTURE CREATION
                             45 ;;===============================================================================
   0000                      46 BeginStruct c
                     0000     1     c_offset = 0
   0000                      47 Field c, status , 1
                     0000     1     c_status = c_offset
                     0001     2     c_offset = c_offset + 1
   0000                      48 Field c, class , 1
                     0001     1     c_class = c_offset
                     0002     2     c_offset = c_offset + 1
   0000                      49 Field c, sprite , 1
                     0002     1     c_sprite = c_offset
                     0003     2     c_offset = c_offset + 1
   0000                      50 Field c, name , 1
                     0003     1     c_name = c_offset
                     0004     2     c_offset = c_offset + 1
   0000                      51 Field c, rarity , 1
                     0004     1     c_rarity = c_offset
                     0005     2     c_offset = c_offset + 1
   0000                      52 Field c, type , 1
                     0005     1     c_type = c_offset
                     0006     2     c_offset = c_offset + 1
   0000                      53 Field c, energy , 1
                     0006     1     c_energy = c_offset
                     0007     2     c_offset = c_offset + 1
   0000                      54 Field c, description , 1
                     0007     1     c_description = c_offset
                     0008     2     c_offset = c_offset + 1
   0000                      55 Field c, damage , 1
                     0008     1     c_damage = c_offset
                     0009     2     c_offset = c_offset + 1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   0000                      56 Field c, block , 1
                     0009     1     c_block = c_offset
                     000A     2     c_offset = c_offset + 1
   0000                      57 Field c, vulnerable , 1
                     000A     1     c_vulnerable = c_offset
                     000B     2     c_offset = c_offset + 1
   0000                      58 Field c, weak , 1
                     000B     1     c_weak = c_offset
                     000C     2     c_offset = c_offset + 1
   0000                      59 Field c, strengh , 1
                     000C     1     c_strengh = c_offset
                     000D     2     c_offset = c_offset + 1
   0000                      60 Field c, exhaust , 1
                     000D     1     c_exhaust = c_offset
                     000E     2     c_offset = c_offset + 1
   0000                      61 Field c, add_card , 1
                     000E     1     c_add_card = c_offset
                     000F     2     c_offset = c_offset + 1
   0000                      62 EndStruct c
                     000F     1     sizeof_c = c_offset
                             63 
                             64 ;;===============================================================================
                             65 ;; PUBLIC CONSTANTS
                             66 ;;===============================================================================
                     0016    67 ENTITY_SIZE = 22
                     000A    68 MAX_ENTITIES = 10
                             69 
                             70 ;;===============================================================================
                             71 ;; PUBLIC METHODS
                             72 ;;===============================================================================
                             73 .globl man_entity_init
                             74 .globl man_entity_create
