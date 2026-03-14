extends Resource
class_name Constants

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY
}

enum CollectableType
{
	GADGET,
	TRICKET,
	CD,
	RODENT,
	ACCESSORY
}

static func rarity2str(r : Rarity):
	match(r):
		Rarity.COMMON:
			return "COMMON"
		Rarity.UNCOMMON:
			return "UNCOMMON"
		Rarity.RARE:
			return "RARE"
		Rarity.LEGENDARY:
			return "LEGENDARY"
