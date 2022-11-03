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

.include "man/menu.h.s"
.include "cpctelera.h.s"
.include "common.h.s"
.include "sys/text.h.s"
.include "sys/messages.h.s"


;;-----------------------------------------------------------------
;;
;; Start of _DATA area 
;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
;;  right after _CODE area contents.
;;
.area _DATA

jumpTable: .db #4, #2, #1, #1, #0, #0, #-1, #-1, #-2, #-4

icon_template: .db #1, #0, #-1, #_sp_ball_0, _sp_ball_1       ;; Icon Template
icon:: .ds #sizeof_TIcon                                     ;; Icon variable

;; Strings
_menu_string_01: .asciz "TINY TENNIS"             ;;11 chars, 22 bytes
_menu_string_02: .asciz "1 REDEFINE KEYS"         ;;15 chars, 30 bytes
_menu_string_03: .asciz "2 PRACTICE     "         ;;15 chars, 30 bytes
_menu_string_04: .asciz "3 PLAY         "         ;;15 chars, 30 bytes
_menu_string_05: .asciz "CODE GRAPHICS AND MUSIC" ;;23 chars, 46 bytes
_menu_string_06: .asciz "JOHN LOBO"               ;;10 chars, 20 bytes
_menu_string_07: .asciz "@2017 GLASNOST CORP."    ;;22 chars, 44 bytes

;;
;; Start of _CODE area
;; 
.area _CODE

;;-----------------------------------------------------------------
;;
;; man_menu_init_icon
;;  
;;  Input: hl: address to the icon  
;;  Output: 
;;  Destroyed: af, bc,de, hl
;;

man_menu_init_icon::
    ;; Initialization of the player
    ld de, #icon
    ld hl, #icon_template
    ld bc, #sizeof_TIcon
    ldir
    ret


;;void deleteIcon(TIcon *icon){
;;  u8 *pvideo;
;;
;;  //Shadow
;;  pvideo = cpct_getScreenPtr(SCR_VMEM, 19, 37 + (icon->selectedOption * 15));
;;  cpct_drawSolidBox(pvideo, 0, ICON_W, ICON_H);
;;  pvideo = cpct_getScreenPtr(SCR_VMEM, 59, 37 + (icon->selectedOption * 15));
;;  cpct_drawSolidBox(pvideo, 0, ICON_W, ICON_H);
;;
;;  pvideo = cpct_getScreenPtr(SCR_VMEM, 19, 37 + (icon->selectedOption * 15) - icon->height);
;;  cpct_drawSolidBox(pvideo, 0, ICON_W, ICON_H);
;;  pvideo = cpct_getScreenPtr(SCR_VMEM, 59, 37 + (icon->selectedOption * 15) - icon->height);
;;  cpct_drawSolidBox(pvideo, 0,ICON_W, ICON_H);
;;}
;;
;;void drawIcon(TIcon *icon) {
;;  u8 *pvideo;
;;  //Shadow
;;  pvideo = cpct_getScreenPtr(SCR_VMEM, 19, 37 + (icon->selectedOption * 15));
;;  cpct_drawSprite((u8*) icon->shadowSprite, pvideo, ICON_W, ICON_H);
;;  pvideo = cpct_getScreenPtr(SCR_VMEM, 59, 37 + (icon->selectedOption * 15));
;;  cpct_drawSprite((u8*) icon->shadowSprite, pvideo, ICON_W, ICON_H);
;;  //Ball
;;  pvideo = cpct_getScreenPtr(SCR_VMEM, 19, 37 + (icon->selectedOption * 15) - icon->height);
;;  cpct_drawSprite((u8*) icon->sprite, pvideo, ICON_W, ICON_H);
;;  pvideo = cpct_getScreenPtr(SCR_VMEM, 59, 37 + (icon->selectedOption * 15) - icon->height);
;;  cpct_drawSprite((u8*) icon->sprite, pvideo, ICON_W, ICON_H);
;;}
;;
;;void updateIcon(TIcon *icon){
;;	
;;	deleteIcon(icon);
;;	
;;	if (icon->vy == 9){
;;		icon->vy = 0;
;;	} else {
;;		icon->vy++;
;;	}
;;
;;	icon->height += jumpTable[icon->vy];
;;
;;	drawIcon(icon);
;;}
;;
;;

;;-----------------------------------------------------------------
;;
;; man_menu_drawMenu
;;  
;;  Input: 
;;  Output: 
;;  Destroyed: af, bc,de, hl
;;

man_menu_drawMenu::
  ;; "TINY TENNIS"
  ld hl, #_menu_string_01
  m_center_screen_ptr de, CPCT_VMEM_START_ASM, 0, 22
  ld c, #0
  call sys_text_draw_string

  ;; "1 REDEFINE KEYS"
  ld hl, #_menu_string_02
  m_center_screen_ptr de, CPCT_VMEM_START_ASM, 50, 30
  ld c, #0
  call sys_text_draw_string
  ;; "2 PRACTICE     "
  ld hl, #_menu_string_03
  m_center_screen_ptr de, CPCT_VMEM_START_ASM, 65, 30
  ld c, #0
  call sys_text_draw_string
  ;; "3 PLAY         "
  ld hl, #_menu_string_04
  m_center_screen_ptr de, CPCT_VMEM_START_ASM, 80, 30
  ld c, #0
  call sys_text_draw_string

  ;; "CODE GRAPHICS AND MUSIC"
  ld hl, #_menu_string_05
  m_center_screen_ptr de, CPCT_VMEM_START_ASM, 145, 46
  ld c, #0
  call sys_text_draw_string
  ;; "JOHN LOBO"
  ld hl, #_menu_string_06
  m_center_screen_ptr de, CPCT_VMEM_START_ASM, 160, 18
  ld c, #0
  call sys_text_draw_string
  ;; ""@2022 GLASNOST CORP.""
  ld hl, #_menu_string_07
  m_center_screen_ptr de, CPCT_VMEM_START_ASM, 175, 44
  ld c, #0
  call sys_text_draw_string

  ret
