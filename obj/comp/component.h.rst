ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of 1to1 Soccer: An Amstrad CPC Game
                              3 ;;  Copyright (C) 2020 Utopia (@UtopiaRetroDev)
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
                             16 ;;  along with this program.  If not, see http://www.gnu.org/licenses/.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 .module Component
                             20 
                             21 ;; COMPONENT DEFINITION MACRO
                             22 
                             23 .macro DefineComponentArrayStructure_Size _Tname, _N, _ComponentSize
                             24       _Tname'_num::     .db 0
                             25       _Tname'_pend::    .dw _Tname'_array 
                             26       _Tname'_array::
                             27             .ds _N * _ComponentSize
                             28 .endm
