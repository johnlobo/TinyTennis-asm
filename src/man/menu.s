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

jumpTable:: .db #4, #2, #1, #1, #0, #0, #-1, #-1, #-2, #-4

;; Icon Template .macro DefineTIconStructure _Tname, _selectedOption, _height, _vy, _sprite, _shadowSprite
icon_template:: 
  .db #1, #0, #-1 
  .dw #_sp_ball_0, #_sp_ball_1

icon:: .ds #sizeof_TIcon                                     ;; Icon variable

;; Strings
_menu_string_01: .asciz "TINY TENNIS"             ;;11 chars, 22 bytes
_menu_string_02: .asciz "1 REDEFINE KEYS"         ;;15 chars, 30 bytes
_menu_string_03: .asciz "2 PRACTICE     "         ;;15 chars, 30 bytes
_menu_string_04: .asciz "3 PLAY         "         ;;15 chars, 30 bytes
_menu_string_05: .asciz "CODE GRAPHICS AND MUSIC" ;;23 chars, 46 bytes
_menu_string_06: .asciz "JOHN LOBO"               ;;10 chars, 20 bytes
_menu_string_07: .asciz "2022 @ GLASNOST CORP."    ;;22 chars, 44 bytes

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

;;-----------------------------------------------------------------
;;
;; man_menu_eraseIcon
;;  
;;  Input:   c: xcoord
;;          ix: icon
;;  Output: 
;;  Destroyed: af, bc,de, hl
;;
man_menu_eraseIcon::

  ;; Shadow
  ld de, #CPCT_VMEM_START_ASM     ;; get screen address x=19, y=37 + (icon->selectedOption * 15)
  ;;ld c, #19                     ;; x coord
  push bc                         ;; store col in stack
  ld a, TIcon_selectedOption(ix)  ;; y = selected option *15
  ld b, a                         ;;
  sla a                           ;; x2
  sla a                           ;; x4
  sla a                           ;; x8
  sla a                           ;; 16
  sub b                           ;; 16-1= 15
  add a, #37                      ;; +37
  ld b, a
  call cpct_getScreenPtr_asm   
  
  ex de, hl                       ;; move scree address to de
  xor a                           ;; color pattern = 0
  ld c, #ICON_W                   ;; width
  ld b, #ICON_H                   ;; height
  call cpct_drawSolidBox_asm      ;; erase shadow
  
  ;; Icon
  ld de, #CPCT_VMEM_START_ASM     ;; get screen address x=19, y=37 + (icon->selectedOption * 15) - icon->height
  ;;ld c, #19                     ;; x coord
  pop bc                          ;; retrieve col from stack
  ld a, TIcon_selectedOption(ix)  ;; y = selected option *15
  ld b, a                         ;;
  sla a                           ;; x2
  sla a                           ;; x4
  sla a                           ;; x8
  sla a                           ;; 16
  sub b                           ;; 16-1= 15
  add a, #37                      ;; +37
  ld b, TIcon_height(ix)          ;; - height
  sub b                           ;;
  ld b, a
  call cpct_getScreenPtr_asm   
  
  ex de, hl                       ;; move scree address to de
  xor a                           ;; color pattern = 0
  ld c, #ICON_W                   ;; width
  ld b, #ICON_H                   ;; height
  call cpct_drawSolidBox_asm      ;; erase shadow
  ret


;;-----------------------------------------------------------------
;;
;; man_menu_drawMenu
;;  
;;  Input: 
;;  Output: 
;;  Destroyed: af, bc,de, hl
;;
man_menu_deleteIcon::
  ld ix, #icon
  ld c, #19                       ;; x coord
  call man_menu_eraseIcon
  ld c, #59                       ;; x coord
  call man_menu_eraseIcon
  
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


;;-----------------------------------------------------------------
;;
;; man_menu_paintIcon
;;  
;;  Input:   c: xcoord
;;          ix: icon
;;  Output: 
;;  Destroyed: af, bc,de, hl
;;
man_menu_paintIcon::

  ;; Shadow
  ld de, #CPCT_VMEM_START_ASM     ;; get screen address x=19, y=37 + (icon->selectedOption * 15)
  push bc                         ;; store col in stack
  ld a, TIcon_selectedOption(ix)  ;; y = selected option *15
  ld b, a                         ;;
  sla a                           ;; x2
  sla a                           ;; x4
  sla a                           ;; x8
  sla a                           ;; 16
  sub b                           ;; 16-1= 15
  add a, #37                      ;; +37
  ld b, a
  call cpct_getScreenPtr_asm   

  ex de, hl                       ;; move scree address to de
  ld l, TIcon_shadowSprite(ix)    ;; hl=icon.shadowSprite
  ld h, TIcon_shadowSprite+1(ix)  ;;
  ld c, #ICON_W                   ;; width
  ld b, #ICON_H                   ;; height
  call cpct_drawSprite_asm      ;; erase shadow
  
  ;; Icon
  ld de, #CPCT_VMEM_START_ASM      ;; get screen address x=19, y=37 + (icon->selectedOption * 15) - icon->height
  pop bc                          ;; retrieve col from stack
  ld a, TIcon_selectedOption(ix)  ;; y = selected option *15
  ld b, a                         ;;
  sla a                           ;; x2
  sla a                           ;; x4
  sla a                           ;; x8
  sla a                           ;; 16
  sub b                           ;; 16-1= 15
  add a, #37                      ;; +37
  ld b, TIcon_height(ix)          ;; - height
  sub b                           ;;
  ld b, a
  call cpct_getScreenPtr_asm   
  
  ex de, hl                       ;; move scree address to de
  ld l, TIcon_sprite(ix)    ;; hl=icon.shadowSprite
  ld h, TIcon_sprite+1(ix)  ;;
  ld c, #ICON_W                   ;; width
  ld b, #ICON_H                   ;; height
  call cpct_drawSprite_asm      ;; erase shadow
  ret

;;-----------------------------------------------------------------
;;
;; man_menu_drawMenu
;;  
;;  Input: 
;;  Output: 
;;  Destroyed: af, bc,de, hl
;;
man_menu_drawIcon::
  ld ix, #icon
  ld c, #19                       ;; x coord
  call man_menu_paintIcon
  ld c, #59                       ;; x coord
  call man_menu_paintIcon
  
  ret


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

;;-----------------------------------------------------------------
;;
;; man_menu_drawMenu
;;  
;;  Input: 
;;  Output: 
;;  Destroyed: ix, a
;;
man_menu_updateIcon::
  ld ix,#icon

  call man_menu_deleteIcon  ;; Delete icon

  ld a, TIcon_vy(ix)        ;; Check if vy==9
  cp #9                     ;;
  jr z, _icon_not_zero      ;;
  inc TIcon_vy(ix)          ;; if not 9 inc vy
  jr _icon_comp_exit
_icon_not_zero:
  ld TIcon_vy(ix), #0       ;; if 9 vy=0
_icon_comp_exit:

  ld hl, #jumpTable         ;; hl point to jumptable
  ld b, TIcon_vy(ix)        ;; b=vy
  ld a, b                   ;; if vy==0 jump to draw icon
  or a                      ;;
  jr z, _ui_draw_icon       ;;
_jumptable_loop:
  inc hl                    ;; inc hl while b>0
  djnz _jumptable_loop

_ui_draw_icon:
  ld a, (hl)                ;; retrieve jumptable[vy] to TIcon_height
  ld b, TIcon_height(ix)    ;;
  add b
  ld TIcon_height(ix), a    ;;

  call man_menu_drawIcon    ;; draw icon

  ret

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
  ld c, #1
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
  ld c, #2
  call sys_text_draw_string
  ;; "JOHN LOBO"
  ld hl, #_menu_string_06
  m_center_screen_ptr de, CPCT_VMEM_START_ASM, 160, 18
  ld c, #0
  call sys_text_draw_string
  ;; "2022 @ GLASNOST CORP."
  ld hl, #_menu_string_07
  m_center_screen_ptr de, CPCT_VMEM_START_ASM, 175, 42
  ld c, #2
  call sys_text_draw_string

  ret
