class SpellworkCli::Spell
  attr_accessor :name, :type, :description, :url, :effect, :light, :incantation, :hand_motion #, :creator, :practitioners

  @@all = []

  def self.types
    # returns an array of unique types of all spells
    spell_types = ["Transfiguration", "Charm", "Dark Charm (Curses, hexes, and jinxes)", "Counter-Spell", "Healing Spells", "Spell"]
    spell_types.sort
  end

  def self.list_by_type(type)
    # returns an array of all spells with a specific type
    spells_of_type = ["Alohamorra", "Accio", "Wingardium Leviosa"]
    spells_of_type.sort
  end

end

# A spell has a name
# A spell has a type
# A spell needs a url

# A spell has a description

# A spell has an effect
# A spell has a light
# A spell has an incantation
# A spell possibly has a hand motion
