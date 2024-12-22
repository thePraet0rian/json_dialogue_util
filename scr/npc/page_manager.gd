class_name NpcPageManger 
extends CanvasLayer


const PAGE_SCENE: PackedScene = preload(
	"res://scn/line/page.tscn")
const PAGE_TITLE_SCENE: PackedScene = preload(
	"res://scn/line/page_titles.tscn")

@onready var NpcPages: Control = $NpcPages
@onready var NpcPageTitles: HBoxContainer = $NpcPageTitles

var Pages: Array[Page]
var PageTitles: Array[PageTitle]
var npc_data: Dictionary 
var can_input: bool = false
var page_index: int = 0 


func setup(_npc_data: Dictionary) -> void:
	self.npc_data = _npc_data
	for key in _npc_data.keys():
		_make_new_page(key, _npc_data[key])
		_make_new_page_title(key)


func _make_new_page(page_name: String, page_data: Array) -> void:
	var PageInstance: Page = PAGE_SCENE.instantiate()
	PageInstance.setup(page_name, page_data)
	Pages.append(PageInstance)
	NpcPages.add_child(PageInstance)


func _make_new_page_title(key: String) -> void:
	var PageTitleInstance: PageTitle = PAGE_TITLE_SCENE.instantiate()
	PageTitleInstance.setup(key)
	PageTitles.append(PageTitleInstance)
	NpcPageTitles.add_child(PageTitleInstance)
	

func set_selected(selection: bool) -> void:
	if selection:
		can_input = true
	else:
		can_input = false


func _input(event: InputEvent) -> void:
	if can_input:
		_npc_page_manager_input(event)


func _npc_page_manager_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		if page_index > 0:
			page_index -= 1
	elif event.is_action_pressed("ui_right"):
		if page_index < Pages.size() - 1:
			page_index += 1
	elif event.is_action_pressed("ui_accept"):
		_open_page()	
	elif event.is_action_pressed("shift"):
		can_input = false
		_close()
		return

	_display()


func _close() -> void:
	for i in PageTitles.size():
		PageTitles[i].modulate = Color8(255, 255, 255, 255)
		Pages[i].modulate = Color8(255, 255, 255, 255)


func _display() -> void:
	for i in PageTitles.size():
		if page_index == i:
			PageTitles[i].modulate = Color8(255, 0, 0, 255)
		else:
			PageTitles[i].modulate = Color8(255, 255, 255, 255)
	
	for i in Pages.size():
		if page_index == i:
			Pages[i].visible = true
			Pages[i].modulate = Color8(255, 255, 0, 255)
		else:
			Pages[i].visible = false
			Pages[i].modulate = Color8(255, 255, 255, 255)


func _open_page() -> void:
	Pages[page_index].open()
	can_input = false


