extends Resource
class_name EnemyType

@export var name: String
@export var rarity_weights: Dictionary = {
	"common": 60,
	"uncommon": 25,
	"rare": 10,
	"epic": 4,
	"unique": 1
}
