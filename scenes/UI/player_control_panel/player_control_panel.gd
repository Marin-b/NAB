extends Control
class_name PlayerControlPanel

const deadzone = 0.5
var device : int = -1

const RIGHT = 0
const LEFT = 1
const TOP = 2
const BOTTOM = 3

var directions = [RIGHT, LEFT, TOP, BOTTOM]

var last_input_at: int = 0

@onready var selectables : Array[SelectableItem] = get_selectables()

var focus : SelectableItem = null

var neighbors_built = false

func _ready():
	focus = selectables.front()
	if focus:
		highlight_focused()
		
func set_device(d : int):
	device = d

func _input(event : InputEvent):
	if (event.device != device):
		return
	
	var just_inputed = Engine.get_frames_drawn() - last_input_at < (Engine.get_frames_per_second() / 8)
	
	if just_inputed:
		return
	
	last_input_at = Engine.get_frames_drawn()
	
	if !neighbors_built:
		build_neighbours()
		neighbors_built = true

	
	if event.is_action('ui_right'):
		move_to(RIGHT)
	if event.is_action('ui_left'):			
		move_to(LEFT)
	if event.is_action('ui_up'):			
		move_to(TOP)
	if event.is_action('ui_down'):			
		move_to(BOTTOM)
	if event.is_action('ui_accept') && is_instance_valid(focus):
		focus.selectable_pressed()

func change_focus(new_focus):
	focus.deselect()
	focus = new_focus
	highlight_focused()
	
func highlight_focused():
	focus.select()
	
func reselect():
	for dir in directions:
		if move_to(dir):
			return

func remove_from_selectables(target : SelectableItem):
	selectables.erase(target)
	build_neighbours()
	
func move_to(direction : int) -> bool:
	var new_focus = focus.neighbors[direction]
	print(new_focus)
	if new_focus && is_instance_valid(new_focus):
		change_focus(new_focus)
		return true
	return false
	
func get_selectables(parent = self) -> Array:
	var res = []
	for child in parent.get_children():
		if !child is SelectableItem:
			var nested = get_selectables(child)
			if nested.size() != 0:
				res.append_array(nested)
					
		elif is_instance_valid(child):
			res.append(child)
	
	return res
	
	
func build_neighbours():
	for selectable in selectables:
		var pos = selectable.position
		selectable.neighbors[RIGHT] = find_neighbour_right(selectable)
		selectable.neighbors[LEFT] = find_neighbour_left(selectable)
		selectable.neighbors[TOP] = find_neighbour_top(selectable)
		selectable.neighbors[BOTTOM] = find_neighbour_bottom(selectable)

func find_neighbour_right(selectable):
	return find_neighbour(selectable, func(current, candidate) : return  current.global_position.x >= candidate.global_position.x)

func find_neighbour_top(selectable):
	return find_neighbour(selectable, func(current, candidate) : return  current.global_position.y <= candidate.global_position.y)

func find_neighbour_left(selectable):
	return find_neighbour(selectable, func(current, candidate) : return  current.global_position.x <= candidate.global_position.x)

func find_neighbour_bottom(selectable):
	return find_neighbour(selectable, func(current, candidate) : return  current.global_position.y >= candidate.global_position.y)
	
func find_neighbour(current : SelectableItem , exclude_condition):
	var chosen = null
	
	for candidate in selectables:
		if exclude_condition.call(current, candidate):
			continue
			
		if chosen == null:
			chosen = candidate
			continue
		if current.global_position.distance_to(candidate.global_position) < current.global_position.distance_to(chosen.global_position):
			chosen = candidate
	return chosen
