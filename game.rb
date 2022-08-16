# Players have a deck (a deck is an array of cards)
# cards have stats
require 'securerandom'
require 'sqlite3'

$db = SQLite3::Database.new("game.db")
$db.results_as_hash = true

# Create a table
$db.execute <<-SQL
  create table if not exists players(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name varchar(255),
    email varchar(255),
    password varchar(255)
  );
SQL

$db.execute <<-SQL
  create table if not exists cards(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name varchar(255),
    top int,
    left int,
    bottom int,
    right int,
    element varchar(255),
    img varchar(255),
    card_id varchar(255),
    player_id int
  );
SQL

class Player
  attr_accessor :name, :email, :password, :deck
  def initialize(name, email, password, deck=[])
    @name = name
    @email = email
    @password = password
    @deck = deck
  end
end

# In order to save this information we would need to create a Cards table in a database
# when we create a card object, we would store that card object in the database
class Card
  attr_accessor :name, :top, :left, :bottom, :right, :element, :img, :card_id
  def initialize(name, top, left, bottom, right, element=nil, img=nil)
    @name = name
    @top = top
    @left = left
    @bottom = bottom
    @right = right
    @element = element
    @img = img
    @card_id = SecureRandom.uuid
  end

  def Card.all
      rows = $db.execute <<-SQL
        SELECT * FROM cards;
      SQL  
      puts rows
      return rows;
  end

  def Card.load(id)
    rows = $db.execute <<-SQL
      SELECT * FROM cards WHERE id = #{id};
    SQL
    # rebuild a card object using data from database
    result = rows.first
    card = Card.new(
      result['name'],
      result['top'],
      result['left'],
      result['bottom'],
      result['right'],
      result['element'],
      result['img']
    )
    card.card_id = result['card_id']
    card
  end

  def save
    $db.execute <<-SQL
      INSERT INTO cards(name, top, left, bottom, right)
      VALUES ("#{@name}", "#{@top}", "#{@left}", "#{@bottom}", "#{@right}");
    SQL
    puts "#{@name}-#{@card_id} saved to the database!"
  end
end

# @card1 = Card.new('Yojimbo', 9, 7, 6, 8)
# @card2 = Card.new('Tonberry', 3, 5, 2, 7)
# @card1.save
# @card2.save