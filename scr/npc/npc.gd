class_name Npc
extends Control


signal close_npc

const PAGE_SCENE: PackedScene = preload("res://scn/line/page.tscn")
const PAGE_TITLE_SCENE: PackedScene = preload("res://scn/line/page_titles.tscn")

@onready var Ui: CanvasLayer = $Ui
@onready var NpcNameLabel: Label = $NameLabel
@onready var NpcPages: Control = $Ui/NpcPages
@onready var NpcPageTitles: VBoxContainer = $Ui/NpcPageTitles

var npc_data: Dictionary
var npc_name: String
var can_input: bool = false

var Pages: Array[Page]
var PageTitles: Array[PageTitle]

var page_index: int = 0


func setup(_npc_name: String, _npc_data: Dictionary) -> void:
	self.npc_name = _npc_name
	self.npc_data = _npc_data


func _make_new_page(page_name: String, page_data: Array) -> void:
	var PageInstance: Page = PAGE_SCENE.instantiate()
	PageInstance.setup(page_name, page_data)
	PageInstance.close_page.connect(_close_page)
	Pages.append(PageInstance)
	NpcPages.add_child(PageInstance)


func _make_new_page_title(page_name: String) -> void:
	var PageTitleInstance: PageTitle = PAGE_TITLE_SCENE.instantiate()
	PageTitleInstance.setup(page_name)
	PageTitles.append(PageTitleInstance)
	NpcPageTitles.add_child(PageTitleInstance)


func set_selected(selection: bool) -> void:
	if selection:
		self.modulate = Color8(0, 0, 0, 255)
		Ui.visible = true
	else:
		self.modulate = Color8(255, 255, 255, 255)
		Ui.visible = false


func open() -> void:
	can_input = true
	self.modulate = Color8(255, 255, 255, 255)


func _ready() -> void:
	NpcNameLabel.text = npc_name
	for key in npc_data.keys():
		_make_new_page(key, npc_data[key])
		_make_new_page_title(key) 


func _input(event: InputEvent) -> void:
	if can_input:
		_npc_input(event)	


func _npc_input(event: InputEvent) -> void:
	if event.is_action_pressed("shift"):
		_close()
		return
	elif event.is_action_pressed("ui_up"):
		if page_index > 0:
			page_index -= 1
	elif event.is_action_pressed("ui_down"):
		if page_index < Pages.size() - 1:
			page_index += 1
	elif event.is_action_pressed("ui_accept"):
		_open_page()

	_display()


func _close() -> void:
	close_npc.emit()
	can_input = false
	for i in Pages.size():
		PageTitles[i].modulate = Color8(255, 255, 255, 255)
		Pages[i].modulate = Color8(255, 255, 255, 255)


func _display() -> void:
	for i in Pages.size():
		if page_index == i:
			Pages[i].visible = true
			PageTitles[i].modulate = Color8(255, 0, 0, 255)
		else:
			Pages[i].visible = false
			PageTitles[i].modulate = Color8(255, 255, 255, 255)


func _open_page() -> void:
	Pages[page_index].open()
	can_input = false


func _close_page() -> void:
	can_input = true
