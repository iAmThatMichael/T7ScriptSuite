# T7ScriptSuite
A community version of interesting/useful functions for T7 CoDScript.
It's to expand scripting capabilities for every user, as well as, understand newer features involved with the T7 scripting syntax.

## GSC - Scripts
### Shared

#### Array
1. ``` m_array::search( <array>, <value>, [as_index] ) ```

* Returns: array/int

* Parameters: array, int, bool

2. ``` m_array::select_random( <array> ) ```

* Returns: array

* Parameters: array

3. ``` m_array::create_from( <array>, <n_s_index>, [n_e_index], [reversed] ) ```

* Returns: array

* Parameter: array, int, int, bool

#### LUI
1. ``` m_lui::show_text( <text>, [alignment], [x], [y], [color], [alpha], [auto_clear], [height] ) ```

* Returns: struct

* Parameters: string, string, int, int, vec, int, bool, int

2. ``` m_lui::show_text_for_time( <text>, [time], [fadein], [fadeout], [alignment], [x], [y], [color], [alpha], [auto_clear], [height] ) ```

* Returns: undefined

* Parameters: string, int, int, , int, string, int, int, vec, int, bool, int

3. ``` m_lui::show_shader( <shader>, [alignment], [x], [y], [width], [height], [alpha], [auto_clear] ) ```

* Returns: struct

* Parameters: string, string, int, int, int, int, int, bool

4. ``` m_lui::show_shader_for_time( <shader>, [time], [fadein], [fadeout], [alignment], [x], [y], [width], [height], [alpha], [auto_clear] ) ```

* Returns: undefined

* Parameters: string, int, int, int, string, int, int, int, int, int, bool

#### Player
1. ``` m_player::lock( [stance] ) ```

* Returns: undefined

* Parameters: string

* Call on: player

2. ``` m_player::release() ```

* Returns: undefined

* Parameters:

* Call on: player

#### Trigger
1. ``` m_trigger::create_trigger( <type>, <origin>, <radius>, <height>, [spawnflags] ) ```

* Returns: trigger

* Parameters: string, vec, int, int, int

2. ``` m_trigger::exec_trigger_loop( <validation>, <callback> ) ```

* Returns: undefined

* Parameters: function pointer, function pointer

#### Util
1. ``` m_util::to_string( <convert>, [append_str] ) ```

* Returns: string

* Parameters: any, string

2. ``` m_util::get_team_count( [team] ) ```

* Returns: int

* Parameters: string

3. ``` m_util::get_players_in_team( [team] ) ```

* Returns: int

* Parameters: string

4. ``` m_util::in_between( <lowest>, <greatest>, <comparison> ) ```

* Returns: bool

* Parameters: int, int, int

### Zombiemode

#### Perks
1. ``` m_zm_perks::get_perk_alias( <str_perk> ) ```

* Returns: string

* Parameters: string

2. ``` m_zm_perks::get_perk_hash_id( <str_perk> ) ```

* Returns: int

* Parameters: string

3. ``` m_zm_perks::get_perk_cost( <str_perk> ) ```

* Returns: int

* Parameters: string

4. ``` m_zm_perks::get_perk_hint_string( <str_perk> ) ```

* Returns: string

* Parameters: string

5. ``` m_zm_perks::get_perk_bottle_weapon( <str_perk> ) ```

* Returns: weapon

* Parameters: string

6. ``` m_zm_perks::include_perk_in_random_rotation( <str_perk> ) ```

* Returns: undefined

* Parameters: string

7. ``` m_zm_perks::remove_perk_from_random_rotation( <str_perk> ) ```

* Returns: undefined

* Parameters: string

8. ``` m_zm_perks::get_weighted_random_perk( <player> ) ```

* Returns: string

* Parameters: player