class SpellworkCli::Spell
  attr_accessor :name, :type, :description, :url, :effect, :light, :incantation, :hand_motion #, :creator, :practitioners

  @@all = []

  def self.types
    # returns an array of unique types of all spells
    # spell_types = ["Transfiguration", "Charm", "Dark Charm (Curses, hexes, and jinxes)", "Counter-Spell", "Healing Spells", "Spell"]
    # puts spell_types.sort

    spell1 = SpellworkCli::Spell.new
    spell1.name = "Alohamorra"
    spell1.type = "Charm"
    spell1.description = "opens door"

    spell2 = SpellworkCli::Spell.new
    spell2.name = "Accio"
    spell2.type = "Transfiguration"
    spell2.description = "calls object to wizard"

    spell3 = SpellworkCli::Spell.new
    spell3.name = "Wingardium Leviosa"
    spell3.type = "Counter-Spell"
    spell3.description = "levitates object"

    [spell1, spell2, spell3].collect { |spell| spell.type }.uniq.sort
  end

  def self.list_by_type(type)
    # returns an array of all spells with a specific type
    # spells_of_type = ["Alohamorra", "Accio", "Wingardium Leviosa"]
    # spells_of_type.sort

    spell1 = SpellworkCli::Spell.new
    spell1.name = "Alohamorra"
    spell1.type = "Charm"
    spell1.description = "opens door"

    spell2 = SpellworkCli::Spell.new
    spell2.name = "Accio"
    spell2.type = "Transfiguration"
    spell2.description = "calls object to wizard"

    spell3 = SpellworkCli::Spell.new
    spell3.name = "Wingardium Leviosa"
    spell3.type = "Counter-Spell"
    spell3.description = "levitates object"

    [spell1, spell2, spell3].select { |spell| spell if spell.type == type }.collect { |item| item.name }.sort
  end

  # def self.casting_from_type_list(index)
  #   # returns casting information for the spell from the type list with the given index?????
  #   # VS HAVING TO CHANGE INDEX TO NAME FOR CASTING_INFO(NAME)????
  # end

  def self.casting_info(name)
    # returns casting information for a spell with a given name
  end

end

# spell1 = SpellworkCli::Spell.new
# spell1.name = "Alohamorra"
# spell1.type = "Charm"
# spell1.description = "opens door"
#
# spell2 = SpellworkCli::Spell.new
# spell2.name = "Accio"
# spell2.type = "Transfiguration"
# spell2.description = "calls object to wizard"
#
# spell3 = SpellworkCli::Spell.new
# spell3.name = "Wingardium Leviosa"
# spell3.type = "Counter-Spell"
# spell3.description = "levitates object"

# A spell has a name
# A spell has a type
# A spell needs a url

# A spell has a description

# A spell has an effect
# A spell has a light
# A spell has an incantation
# A spell possibly has a hand motion
