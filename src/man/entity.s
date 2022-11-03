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
.include "man/entity.h.s"
.include "comp/component.h.s"

DefineComponentArrayStructure_Size _entity, MAX_ENTITIES, ENTITY_SIZE     
.db 0   ;;ponemos este aqui como trampita para que siempre haya un tipo invalido al final

;;
;; Definition of model deck
;;
model_entity:
;;         _status,             _class  _sprite     _name   _rarity _type   _energy _description,       _damage _block, _vulnerable _weak   _strengh    _exhaust    _add_card
DefineEntity e_type_card_in_hand, 1,      0x0000, STRIKE, 1,      1,      1,      ^/SINGLE ATTACK/,   3,      0,      0,          0,      0,          0,          0
DefineEntity e_type_card_in_hand, 2,      0x0000, DEFEND, 1,      1,      1,      ^/SIMPLE DEFENCE/,  0,      3,      0,          0,      0,          0,          0


;;-----------------------------------------------------------------
;;
;; man_entity_init
;;
;;   gets a random number between 0 and 18
;;  Input: 
;;  Output: a random piece
;;  Modified: AF, BC, DE, HL
;;
man_entity_init::
    xor a
    ld  (_entity_num), a

    ld  hl, #_entity_array      ;;ponemos el puntero de la ultima entidad a la primera posicion del array
    ld  (_entity_pend), hl

    ld  (hl), #e_type_invalid   ;;ponemos el primer elemento del array con tipo invalido
ret


;;-----------------------------------------------------------------
;;
;; man_entity_getArrayHL
;;
;;   gets a random number between 0 and 18
;;  Input: 
;;  Output: a random piece
;;  Modified: AF, BC, DE, HL
;;
man_entity_getArrayHL::
    ld  hl, #_entity_array
ret

;;-----------------------------------------------------------------
;;
;; man_entity_create_card
;;
;;   gets a random number between 0 and 18
;;  Input: HL: puntero al array con los datos de inicializacion
;;  Output: a random piece
;;  Modified: AF, BC, DE, HL
;;
man_entity_create::

    ld  de, (_entity_pend)
    ld  bc, #ENTITY_SIZE
    ldir

    ;;PASAMOS A LA SIGUIENTE ENTIDAD
    ld  a, (_entity_num)    ;;aumentamos el numero de entidades
    inc a
    ld  (_entity_num), a

    ld   hl, (_entity_pend) ;;pasamos el puntero a la siguiente entidad
    ld   bc, #ENTITY_SIZE
    add  hl, bc
    ld   (_entity_pend), hl
ret

