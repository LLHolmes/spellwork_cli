How to build a CLI gem (based on Ari's tutorial):

1. Plan your gem, what will it do?
2. Set up the project.
3. Start with the entry point - make sure the run file works & environment is set up.
4. Connect the run file to the CLI interface.
5. Stub out the interface.
6. Start making things real.
7. Discover objects.
8. Program.



- Spellwork is a command line interface for a collection of known Harry Potter Spells.

- Uses https://harrypotter.fandom.com/wiki/List_of_spells#A as the website.

Simple Encyclopedia:
Welcome.
			 - ??? - Show selection of types of spells
			 - ??? - User selects type of spells
			Show list of spells (in that section???)
			User selects spell to explore
				Show more information, including entymology, creator, how to cast, effects, description???, known users???
			Back to list of spells to select (or selection of types of spells???) until exit

      Encyclopedia & game:
      Welcome.
      	Choice of learn or duel
      	if learn (Encyclopedia?):
      			 - ??? - Show selection of types of spells
      			 - ??? - User selects type of spells
      			Show list of spells (in that section???)
      			User selects spell to explore (gain more knowledge about casting the spell)
      				Show more information, including how to cast, light, effect, creator, known users
      			Back to list of spells to select (or selection of types of spells???) until exit

      	if Duel
      		Explains rules
      		User selects to continue by bowing (can also exit)
      			|| Update on life statuses
      			|| User chooses action
      			|| Opponent chooses action
      			  - until one life status is 0%
      		End game - Congratulate winner, console loser
      		Back to choice of learn or duel

def list_deals
  puts
end

def menu
  input = until
  while input != "exit"
    puts ""
    input = gets.strip.downcase
    case input
      when ""
        x
      when ""
        y
      else
        z
    end
  end
end



Encyclopedia & game:
Welcome.
	Choice of learn or duel
	if learn (Encyclopedia?):
			 - ??? - Show selection of types of spells
			 - ??? - User selects type of spells
			Show list of spells (in that section???)
			User selects spell to explore (gain more knowledge about casting the spell)
				Show more information, including how to cast, light, effect, creator, known users
			Back to list of spells to select (or selection of types of spells???) until exit

	if Duel
		Explains rules
		User selects to continue by bowing (can also exit)
			|| Update on life statuses
			|| User chooses action
			|| Opponent chooses action
			  - until one life status is 0%
		End game - Congratulate winner, console loser
		Back to choice of learn or duel
