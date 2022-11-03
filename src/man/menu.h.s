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

.module menu_manager

.include "common.h.s"

;;===============================================================================
;; PUBLIC VARIABLES
;;===============================================================================
.globl icon

;;===============================================================================
;; PUBLIC METHODS
;;===============================================================================
.globl man_menu_init_icon
.globl man_menu_deleteIcon
.globl man_menu_drawIcon
.globl man_menu_updateIcon
.globl man_menu_drawMenu
;;===============================================================================
;; PUBLIC CONSTANTS
;;===============================================================================
MAX_VY = 9
ICON_W = 2
ICON_H = 4

;;typedef struct{
;;	u8 selectedOption;
;;	u8 height;
;;	u8 vy;
;;	u8 *sprite;
;;	u8 *shadowSprite;
;;} TIcon;

;;===============================================================================
;; COMPONENT DEFINITION MACRO
;;===============================================================================


.macro DefineTIconStructure _Tname, _selectedOption, _height, _vy, _sprite, _shadowSprite
      _Tname'_selectedOption::	.db _selectedOption
      _Tname'_height::              .db _height
      _Tname'_vy::      		.db _vy
      _Tname'_sprite::              .dw _sprite
      _Tname'_shadowSprite::        .dw _shadowSprite
.endm

;;===============================================================================
;; DATA ARRAY STRUCTURE CREATION
;;===============================================================================
BeginStruct TIcon
Field TIcon, selectedOption , 1
Field TIcon, height , 1
Field TIcon, vy , 1
Field TIcon, sprite , 2
Field TIcon, shadowSprite , 2
EndStruct TIcon
