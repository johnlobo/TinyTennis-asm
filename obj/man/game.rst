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
                             19 ;;-----------------------------------------------------------------
                             20 ;;
                             21 ;; man_game_init
                             22 ;;
                             23 ;;   gets a random number between 0 and 18
                             24 ;;  Input: 
                             25 ;;  Output: a random piece
                             26 ;;  Modified: AF, BC, DE, HL
                             27 ;;
   4608                      28 man_game_init::
   4608 C9            [10]   29     ret
                             30 
                             31 ;;-----------------------------------------------------------------
                             32 ;;
                             33 ;; man_game_update
                             34 ;;
                             35 ;;   gets a random number between 0 and 18
                             36 ;;  Input: 
                             37 ;;  Output: a random piece
                             38 ;;  Modified: AF, BC, DE, HL
                             39 ;;
   4609                      40 man_game_update::
                             41 ;;
                             42 ;; Turn structure
                             43 ;; 1) Show foes intentions
                             44 ;; 2) hero play cards
                             45 ;; 3) Foes execute intention
                             46 ;; 4) Upate effects
                             47 ;; 5) Check end of combat
                             48 ;;
   4609 C9            [10]   49     ret
