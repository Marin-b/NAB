extends Node
class_name CustomSceneFactory

var shop_scene = preload("res://scenes/shop/shop.tscn")

func create_shop(player, container) -> Shop:
	var shop = shop_scene.instantiate()
	shop.initialize(player)
	container.add_child(shop)
	return shop
