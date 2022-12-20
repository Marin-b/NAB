extends BoxContainer
class_name SplitScreen

# var screen_scene = preload("res://scenes/UI/split_screen/screen.gd")

var screens : Array 

func initialize(player_count):
	var splits = ceil(player_count / 2.0)
	self.vertical = true
	screens = rsplit(splits, self)
	
func rsplit(splits, parent):
	if splits == 0:
		return [parent]
	
	var c1 = create_box_container(parent)
	c1.size = parent.size / 2
	var c2 = create_box_container(parent)
	c2.vertical = !parent.vertical
	if !parent.vertical:
		c1.vertical = true
		c2.vertical = true
		
	c1.size_flags_horizontal = SIZE_EXPAND_FILL 
	c2.size_flags_horizontal = SIZE_EXPAND_FILL 
	c1.size_flags_vertical = SIZE_EXPAND_FILL 
	c2.size_flags_vertical = SIZE_EXPAND_FILL 
	
	if splits == 1:
		return [c1, c2]
	
	var c1_childrens = rsplit(splits - 1, c1)
	var c2_childrens = rsplit(splits - 1, c2)
	var res = []
	res.append_array(c1_childrens)
	res.append_array(c2_childrens)
	return res
	
func create_box_container(parent):
	var bc = BoxContainer.new()
	parent.add_child(bc)
	return bc
