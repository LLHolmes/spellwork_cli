class SpellworkCli::CLI

def start
  puts "Welcome to Spellwork, where you can learn to cast known Harry Potter spells!"
  build_encyclopedia
  choose_spell_type
  goodbye
end

def build_encyclopedia
  # Scrapes site & creates new Spell instances which are collected in @@all
  SpellworkCli::Scraper.scrape_fandom_wiki_index
    # students_array = Scraper.scrape_index_page(BASE_PATH + 'index.html')
    # Student.create_from_collection(students_array)
end

def list_spell_types
  @types = SpellworkCli::Spell.types
  puts "Types of spells:"
  @types.each.with_index(1) { |type, i| puts "#{i}. #{type}" }
end

def choose_spell_type
  list_spell_types
  input = nil
  while input != "exit"
    puts "Enter the number for a selection of specific spells of that kind, \"list\" for the list of types, or \"exit\":"
    input = gets.chomp.downcase
    if input != "exit"
      if input.to_i > 0 && input.to_i <= @types.length
        choose_spell("#{@types[input.to_i-1]}")
  # DO I WANT THIS IN A WHILE LOOP????
      elsif input == "list"
        list_spell_types
      # elsif input == "all"
      #   puts 'There are x known spells.  Would you still like a list of them all? y/n'
      #   choice = gets.chomp.downcase
      #     if choice == "y"
      #       puts 'LIST OF ALL SPELLS'
      else
        puts "I'm not sure what you mean. Please try again."
      end
    end
  end
end

def list_spells_of_a_type(type)
  @spells_by_type = SpellworkCli::Spell.list_name_by_type(type)
  puts "All #{type.downcase} spells:"
  @spells_by_type.each.with_index(1) { |spell, i| puts "#{i}. #{spell}" }
end

def choose_spell(type)
  list_spells_of_a_type(type)
  input = nil
  while input != "exit"
    puts "Enter the number of a spell to learn about casting it, \"list\" for the list of #{type.downcase} spells, or \"exit\":"
    input = gets.chomp.downcase
    if input != "exit"
      if input.to_i > 0 && input.to_i <= @spells_by_type.length
        # requested_spell = SpellworkCli::Spell.request_info_by_name(@spells_by_type[input.to_i-1])
        # list_details(requested_spell)
        puts "more on #{@spells_by_type[input.to_i-1]}"
  # DO I WANT THIS IN A WHILE LOOP????
      elsif input == "list"
        list_spells_of_a_type(type)
      else
        puts "I'm not sure what you mean. Please try again."
      end
    end
  end
end

def list_details(spell)
  #puts extra details about spell casting
end

def goodbye
  puts "Goodbye."
end

end
