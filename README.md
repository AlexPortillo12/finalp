# Enhanced Blackjack Calculator README

## Overview
This enhanced Blackjack calculator for R is designed to help players make better strategic decisions by incorporating basic Blackjack strategies along with a card counting feature using the Hi-Lo system. It is adjusted for multiple deck games and provides advice based on the current card count and the composition of remaining cards in the deck.

## Features
- **Basic Blackjack Strategy**: Advises when to hit, stand, or adjust the play based on the dealer's card and player's hand.
- **Card Counting (Hi-Lo System)**: Tracks the running count of the cards seen and adjusts play suggestions based on the true count.
- **Multiple Decks Handling**: Adjusts calculations for multiple decks, providing more accurate advice for casino play.
- **Dealer Rules Configuration**: Adjusts strategies based on whether the dealer hits or stands on a soft 17.

## Function Parameters
The function `blackjack_calculator` requires several parameters to be set when called:
- `players`: A list of players where each player is represented as a list with a key `cards` containing their current hand as numeric values (1 for Ace, 11 for Jack, 12 for Queen, 13 for King).
- `current_player_index`: An integer representing which player's turn it is (1-based index).
- `dealer_shows`: The card the dealer is showing (1 for Ace, through 13 for King).
- `hits_soft_17`: A boolean value (`TRUE` or `FALSE`) indicating whether the dealer hits on a soft 17.
- `decks`: The number of decks being used in the game.
- `running_count`: The current running count for card counting; starts at 0 and is updated throughout the game.

## Usage
To use the blackjack calculator, set up the game configuration and call the function with the appropriate parameters.

```r
# Example Setup
players <- list(
  list(cards = c(10, 10)),  # Player 1 with a pair of tens (Jacks, Queens, or Kings)
  list(cards = c(5, 6)),    # Player 2's hand
  list(cards = c(9, 2))     # Player 3's hand
)
current_turn <- 2            # It's Player 2's turn
dealer_card <- 6             # Dealer shows a 6
hits_soft_17 <- TRUE         # Dealer hits on soft 17
decks <- 6                   # Using 6 decks
initial_running_count <- 0   # Starting the game with a count of 0

# Function Call
advice <- blackjack_calculator(players, current_turn, dealer_card, hits_soft_17, decks, initial_running_count)
print(advice)
```
## Output

The function will output advice for the current player, such as whether to hit or stand, along with the true count which can guide further strategic decisions.

