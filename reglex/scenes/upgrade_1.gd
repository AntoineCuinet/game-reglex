extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Exemple de texte formaté avec 3 colonnes
	var table_text = ""
	
	# En-tête du tableau
	table_text += "[b]Colonne 1[/b]  [b]Colonne 2[/b]  [b]Colonne 3[/b]\n"
	
	# Ajouter des lignes de tableau avec des colonnes
	table_text += "Nom      Âge      Ville\n"
	table_text += "Alice     30       Paris\n"
	table_text += "Bob       25       Lyon\n"
	table_text += "Charlie   35       Marseille\n"
	
	# Assigner le texte au RichTextLabel
	text = table_text
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
