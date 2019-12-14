extends "res://scripts/gameplay/ItemPickable.gd"


func _on_Picked():
    print("wumpa")
    self.queue_free()