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

.include "cpctelera.h.s"
.include "common.h.s"

.module render

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sys_render_init
;;
;; INPUT
;; DESTROYS:
;;
sys_render_init::
   ld c, #0                      ;; Set mode 0
   call cpct_setVideoMode_asm    ;;

   ld hl, #8000                  ;; cpct_memset(g_scrbuffers[0], 0x00, 0x4000);
   ld de, #0                     ;;
   ld bc, #4000                  ;;
   call cpct_memset_f64_asm      ;;

   ld hl,#_g_palette0            ;; Set palette
   ld de,#16                     ;;
   call cpct_setPalette_asm      ;;
      
   cpctm_setBorder_asm HW_BLACK  ;; Set border to black

   cpctm_clearScreen_asm 255     ;; Clear screen
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sys_render_update
;; 
;; INPUT
;; DESTROYS:
;;
sys_render_update::
	
	ret

