module MagicHelper
  def link_card(card_name)
    #link_to card_name, "http://www.magiccards.info/autocard.php?card=#{card_name}", :title => card_name, :onclick => "AutoCard('#{card_name}'); return false;"
    %Q[<a href="http://www.magiccards.info/autocard.php?card=#{card_name}" onclick="AutoCard('#{card_name}'); return false;" onmouseover="s('#{card_name.gsub(' ', '_').gsub(',', '')}');" title="#{card_name}">#{card_name}</a>]
  end
  
  def deck_display(deck)
    order = %w{Creature Instant Sorcery Artifact Enchantment Land Planeswalker Sideboard}
    line_count = 0
    o = %q[<div class="deck">]
    o << %q[<div class="deckblock">]
    order.each do |card_type|
      if cards = deck[card_type]
        o << %Q[<h3>#{card_type} \[#{count_cards(cards)}\]</h3>]
        line_count += 1
        cards.sort {|a,b| a[0]<=>b[0]}.each do |name, qty|
          o << %Q[<p>#{qty} #{link_card(name)}</p>]
          line_count = line_count + 1
        end
      end  
      if line_count > 11
        o << %q[</div>]
        o << %q[<div class="deckblock">]
        line_count = 0
      end
    end    
    o << %q[</div>]
    o << %q[<div class="cardframe"><img src="/images/back.jpg" id="card" width="200" height="281" /></div>]
    o << %Q[<br style="clear:both;" /><h3 class="total">#{count_deck(deck)} cards</h3></div>]
    o
  end
  
  def count_deck(deck)
    deck.inject(0) {|sum, cards| cards[0] == 'Sideboard' ? sum : sum + count_cards(cards[1]) }
  end
  
  def count_cards(cards)
    cards.inject(0) {|sum, card| sum + card[1]}
  end
end

Webby::Helpers.register(MagicHelper)