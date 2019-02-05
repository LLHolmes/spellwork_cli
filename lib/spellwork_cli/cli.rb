class SpellworkCli::CLI

def start
  puts "Welcome to Spellwork, an Encyclopedia of known Harry Potter spells!"
  puts "Types of spells:"
  # list_spell_types
  choose_spell_type
  goodbye
end

def list_spell_types(spell_types)
  # spell_types = ["Transfiguration", "Charm", "Dark Charm (Curses, hexes, and jinxes)", "Counter-Spell", "Healing Spells", "Spell"]
  # @spells.types = SpellworkCli::Spells.types
  spell_types.each.with_index(1) { |type, i| puts "#{i}. #{type}" }
end

def choose_spell_type
  spell_types = ["Transfiguration", "Charm", "Dark Charm (Curses, hexes, and jinxes)", "Counter-Spell", "Healing Spells", "Spell"]
  # @spells.types = SpellworkCli::Spells.types
  list_spell_types(spell_types)
  input = nil
  while input != "exit"
    puts 'Enter the number for a selection of specific spells of that kind, "list" for the list, or "exit":'
    input = gets.chomp.downcase
    if input != "exit"
      if input.to_i > 0 && input.to_i <= spell_types.length
        choose_spell("#{spell_types[input.to_i-1]}")
  # DON'T WANT THIS IN A WHILE LOOP????
      elsif input == "list"
        list_spell_types(spell_types)
      else
        puts "I'm not sure what you mean. Please try again."
      end
    end
  end
end

def list_spells_of_a_type(type)
  # spells_of_type = ["Alohamorra", "Accio", "Wingardium Leviosa"]
  # @spells.of_type = SpellworkCli::Spells.list_by_type(type)
  # SpellworkCli::Spells.list_by_type(type).each.with_index(1) { |spell, i| puts "#{i}. #{type}" }
  spells_of_type.each.with_index(1) { |type, i| puts "#{i}. #{type}" }
end

def choose_spell(type)
  puts type
  spells_of_type = ["Alohamorra", "Accio", "Wingardium Leviosa"]
  # @spells.type = SpellworkCli::Spells.list_by_type(type)
  list_spell_types(spells_of_type)
  # list objects of a specific type
  # accept user input
  # SpellworkCli::Spells.list_by_type(type).each.with_index(1) { |spell, i| puts "#{i}. #{type}" }
end

def goodbye
  puts "Goodbye."
end

end
