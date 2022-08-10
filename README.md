# Rules
- Each player has a deck(with no size limit)
- Each player starts by choosing 5 cards from their deck
- A game board has 9 spaces. Each space can hold 1 card. (At least 1 card will not be played)
- Each card has a Top, Bottom, Left and Right value
    - The top, bottom, left and right values are from 1 to 10
- When a card is played, it will look at all of the adjacent spaces and evaluate whether or not its values are greater than or less than the cards occupying those spaces
    - If the values are greater than, those cards that it beats will be "captured"
    - Every captured card increases the score by 1 point for the player