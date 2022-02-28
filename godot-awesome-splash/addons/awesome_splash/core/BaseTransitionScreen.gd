extends Node2D

enum TrainsitionType {NONE, FADE, DIAMOND}
enum TransitionStatus {NONE, APPEAR, DISSAPPEAR}

export(TrainsitionType) var trainsition_type = TrainsitionType.FADE \
	setget _set_transition_type

var fade_value: float setget _set_fade_value
var current_time: float = 0.0
var animation_time: float = 0.0
var status: int = TransitionStatus.NONE


var diamond_size: float = 32.0
var transition_time: float = 1.0
var fade_color: Color = Color.white


var viewport_container: ViewportContainer
var viewport: Viewport
var transition_shader = preload("res://addons/awesome_splash/assets/shader/transition.shader")
var shader_meterial: ShaderMaterial


### BUILD IN ENGINE METHODS ====================================================

func _process(delta):
	if status == TransitionStatus.NONE or animation_time <= 0:
		set_process(false)
		return
	
	current_time += delta
	var value = current_time / animation_time
	value = min(value, 1.0)
	
	if status == TransitionStatus.APPEAR:
		self.fade_value = 1 - value
		if current_time >= animation_time:
			set_process(false)
			_on_finished_animation_screen_appear()
	
	if status == TransitionStatus.DISSAPPEAR:
		self.fade_value = value
		if current_time >= animation_time:
			set_process(false)
			_on_finished_animation_screen_disappear()


#func _get(property): # overridden
#	if property == "trainsition_type":
#		return trainsition_type
#	if property == "transition_time":
#		return transition_time
#	if property == "fade_color":
#		return fade_color
#
#func _set(property, value): # overridden
#	if property == "trainsition_type":
#		trainsition_type = value
#
#	if property == "transition_time":
#		transition_time = value
#
#	if property == "fade_color":
#		fade_color = value
#
#	property_list_changed_notify() # update inspect
#	return true


# call once when node selected. Added to ordinary export
func _get_property_list():
	# overridden function
	if not Engine.editor_hint or not is_inside_tree():
		return []
	
	var property_list = []
	
	if trainsition_type == TrainsitionType.FADE:
		property_list.append({
			"name": "transition_time",
			"type": TYPE_REAL,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_NONE,
			})
		
		property_list.append({
			"name": "fade_color",
			"type": TYPE_COLOR ,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_NONE,
		})
	
	if trainsition_type == TrainsitionType.DIAMOND:
		property_list.append({
			"name": "diamond_size",
			"type": TYPE_REAL,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_NONE,
			})
	
		property_list.append({
			"name": "transition_time",
			"type": TYPE_REAL,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_NONE,
			})
		
		property_list.append({
			"name": "fade_color",
			"type": TYPE_COLOR ,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_NONE,
		})
	return property_list


### PRIVATE METHODS ============================================================

func _setup_transition():
	shader_meterial = ShaderMaterial.new()
	shader_meterial.shader = transition_shader
	shader_meterial.set_shader_param("color", fade_color)
	shader_meterial.set_shader_param("diamond_size", diamond_size)
	shader_meterial.set_shader_param("transition_type", trainsition_type)
	
	viewport = Viewport.new()
	viewport_container = ViewportContainer.new()
	add_child(viewport_container)
	viewport_container.material = shader_meterial
	viewport_container.add_child(viewport)
	viewport.transparent_bg = true
	viewport.own_world = true
	
	get_viewport().connect("size_changed", self, "_update_screen_size_changed")


func _update_screen_size_changed():
	var viewport_size = get_viewport_rect().size
	viewport.size = viewport_size
	viewport_container.rect_min_size = viewport_size
	viewport_container.rect_size = viewport_size


func _start_animation_screen_will_appear():
	if trainsition_type == TrainsitionType.NONE:
		_on_finished_animation_screen_appear()
	else:
		status = TransitionStatus.APPEAR
		animation_time = transition_time
		current_time = 0.0
		set_process(true)


func _start_animation_screen_will_disappear():
	if trainsition_type == TrainsitionType.NONE:
		_on_finished_animation_screen_disappear()
	else:
		status = TransitionStatus.DISSAPPEAR
		animation_time = transition_time
		current_time = 0.0
		set_process(true)


func _on_finished_animation_screen_appear():
	status = TransitionStatus.NONE


func _on_finished_animation_screen_disappear():
	status = TransitionStatus.NONE


### SETGET METHODS =============================================================
func _set_transition_type(value: int):
	trainsition_type = value
	property_list_changed_notify() # Call to update UI inspector

func _set_fade_value(value: float):
	fade_value = value
	self.shader_meterial.set_shader_param("process_value", value)