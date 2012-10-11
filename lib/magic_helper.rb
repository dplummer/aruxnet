module MagicHelper
  class Deck
    def initialize(source = nil)
      @order = %w{Creature Instant Sorcery Artifact Enchantment Land
                  Planeswalker Sideboard}

      case source
      when Hash
        load_from_hash(source)
      when String
        load_from_string(source)
      end
    end

    def load_from_hash(source)
      @deck_hash = source
    end

    def load_from_string(source)

    end

    def to_html
      line_count = 0
      o = %q[<div class="deck">]
      o << %q[<div class="deckblock">]
      @order.each do |card_type|
        if cards = @deck_hash[card_type]
          o << %Q[<h3><span class="hidden">// </span>#{card_type} \[#{count_cards(cards)}\]</h3>]
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
      o << %Q[<br style="clear:both;" /><h3 class="total">#{size} cards</h3></div>]
      o
    end

    def to_text
      o = ""
      @order.each do |card_type|
        if cards = deck[card_type]
          o << %Q[// #{card_type} \[#{count_cards(cards)}\]\n]
          cards.sort {|a,b| a[0]<=>b[0]}.each do |name, qty|
            o << %Q[    #{qty} #{name}\n]
          end
        end
      end
      o
    end

    def count_cards(cards)
      cards.sum {|card| card[1]}
    end

    def size
      @deck_hash.sum do |grouping, cards|
        grouping == 'Sideboard' ? 0 : count_cards(cards)
      end
    end

    def link_card(card_name)
      %Q[<a href="http://www.magiccards.info/autocard.php?card=#{card_name}"
        onclick="AutoCard('#{card_name}'); return false;"
        onmouseover="s('#{card_name.gsub(' ', '_').gsub(',', '')}');"
        title="#{card_name}">#{card_name}</a>]
    end
  end

  def link_card(card_name)
    link_to card_name,
      "http://store.arux.net/products/search?q=#{card_name}&ref=aruxblog",
      :title => card_name,
      :onclick => "AutoCard('#{card_name}'); return false;"
  end

  def deck_display(deck)
    Deck.new(deck).to_html
  end
end

Webby::Helpers.register(MagicHelper)
