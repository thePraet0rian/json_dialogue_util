class_name Npc
extends Control


signal close_npc

@onready var NpcNameLabel: Label = $NameLabel
@onready var NpcPageMangerInstance: NpcPageManger = $NpcPageManager

var npc_data: Dictionary
var npc_name: String
var can_input: bool = false


func setup(_npc_name: String, _npc_data: Dictionary) -> void:
	self.npc_name = _npc_name
	self.npc_data = _npc_data


func set_selected(selection: bool) -> void:
	if selection:
		self.modulate = Color8(255, 0, 0, 255)
		NpcPageMangerInstance.visible = true
	else:
		self.modulate = Color8(255, 255, 255, 255)
		NpcPageMangerInstance.visible = false


func open() -> void:
	can_input = true
	self.modulate = Color8(255, 255, 255, 255)
	NpcPageMangerInstance.set_selected(true)


func _ready() -> void:
	NpcNameLabel.text = npc_name
	NpcPageMangerInstance.setup(npc_data)


func _input(event: InputEvent) -> void:
	if can_input:
		_npc_input(event)	


func _npc_input(event: InputEvent) -> void:
	if event.is_action_pressed("shift"):
		_close()


func _close() -> void:
	close_npc.emit()
