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


.module practice_manager

.include "man/practice.h.s"
.include "cpctelera.h.s"
.include "common.h.s"

;;-----------------------------------------------------------------
;;
;; Start of _DATA area 
;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
;;  right after _CODE area contents.
;;
.area _DATA


;;
;; Start of _CODE area
;; 
.area _CODE

;;-----------------------------------------------------------------
;;
;; man_practice_init
;;  
;;  Input: hl: address to the icon  
;;  Output: 
;;  Destroyed: af, bc,de, hl
;;

man_practice_init::

    ;;cpct_etm_setTileset2x4(tile_tileset);
    ;;initPlayer1(&player1);
    ;;initAIPlayer(&player2);
    ;;initBallMachine();
    ;;initBall(&ball);
    ;;initDustList();
    ;;initSpriteList();
    ;;addSprite(&player1.e);
    ;;cpct_etm_drawTilemap2x4_f(MAP_WIDTH, MAP_HEIGHT, g_scrbuffers[0], court);
    ;;createBallMachine(36,6);

    ret