class_name NpcManager
extends Node2D


const NPC_SCENE: PackedScene = preload("res://scn/npc/npc.tscn")

@onready var NpcContainer: VBoxContainer = $Container/NpcContainer

var Npcs: Array[Npc]
var npc_index: int = 0
var can_input: bool = true


func setup(data: Dictionary) -> void:
	for key in data.keys():
		_make_new_npc(key, data[key])


func _make_new_npc(npc_name: String, npc_data: Dictionary) -> void:
	var NpcInstance: Npc = NPC_SCENE.instantiate()
	NpcInstance.setup(npc_name, npc_data)
	NpcInstance.close_npc.connect(_close_npc)

	Npcs.append(NpcInstance)

	NpcContainer.add_child(NpcInstance)


func _input(event: InputEvent) -> void:
	if can_input:
		_npc_manager_input(event)


func _npc_manager_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		if npc_index > 0:
			npc_index -= 1
	elif event.is_action_pressed("ui_down"):
		if npc_index < Npcs.size() - 1:
			npc_index += 1
	elif event.is_action_pressed("ui_accept"):
		print("open npc")
		_open_npc()
		return

	_display() 


func _display() -> void:
	for i in Npcs.size():
		if i == npc_index:
			Npcs[i].set_selected(true)
		else:
			Npcs[i].set_selected(false)


func _open_npc() -> void:
	can_input = false
	Npcs[npc_index].open()


func _close_npc() -> void:
	can_input = true




