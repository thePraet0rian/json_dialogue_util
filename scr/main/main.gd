class_name Main
extends Node2D



@onready var JsonFileSelection: JsonSelection = $JsonSelection
@onready var NpcManagerInstance: NpcManager = $NpcManager


func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	JsonFileSelection.open_file.connect(_on_open_file)


func _on_open_file(data: Dictionary) -> void:
	NpcManagerInstance.setup(data)


