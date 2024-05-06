blackjack_calculator <- function(players, current_player_index, dealer_shows, hits_soft_17, decks, running_count) {
  # Calculate the true count from the running count and the estimated remaining decks
  get_true_count <- function(running_count, decks_remaining) {
    true_count <- running_count / decks_remaining
    return(true_count)
  }
  
  # Update the running count based on the card values using the Hi-Lo card counting strategy
  update_count <- function(card, current_count) {
    if (card >= 2 && card <= 6) {
      current_count <- current_count + 1  # Low cards increase the count
    } else if (card >= 10 || card == 1) {
      current_count <- current_count - 1  # High cards decrease the count
    }
    return(current_count)
  }
  
  # Estimate the number of decks remaining based on the number of cards seen
  cards_seen <- sum(sapply(players, function(player) length(player$cards))) + 1
  decks_remaining <- max(decks - cards_seen / 52, 0.5)  # Ensure at least half a deck remains to avoid division by zero
  
  # Calculate the true count using the running count and remaining decks
  true_count <- get_true_count(running_count, decks_remaining)
  
  # Function to calculate the total value of a hand, considering Aces as either 1 or 11
  card_value <- function(cards) {
    values <- ifelse(cards > 1 & cards < 11, cards, 10)
    values[cards == 1] <- 11
    if (sum(values) > 21 && any(cards == 1)) {
      aces <- sum(cards == 1)
      while (sum(values) > 21 && aces > 0) {
        values[values == 11][1] <- 1  # Change Aces from 11 to 1 if total exceeds 21
        aces <- aces - 1
      }
    }
    return(sum(values))
  }
  
  # Retrieve current player's cards from the list of players
  current_player_cards <- players[[current_player_index]]$cards
  player_total <- card_value(current_player_cards)
  
  # Update the count for all cards currently held by the player
  for (card in current_player_cards) {
    running_count <- update_count(card, running_count)
  }
  
  # Basic strategy decision making with adjustment for card counting
  if (player_total == 21 && length(current_player_cards) == 2) {
    return(paste("Player", current_player_index, "has Blackjack! Stand. True count:", true_count))
  }
  
  action <- "Hit"
  if (player_total >= 17) {
    action <- "Stand"  # Generally stand if total is 17 or higher
  } else if (player_total >= 12 && dealer_shows < 7) {
    action <- "Stand"  # Stand if dealer shows a weak card and player has a marginal hand
  } else if (player_total <= 11 || dealer_shows >= 7) {
    action <- "Hit"   # Hit if dealer shows a strong card or player has a low total
  }
  
  # Further adjust strategy based on the true count for more nuanced decisions
  if (true_count > 2 && player_total >= 16 && dealer_shows >= 7) {
    action <- "Stand"  # Stand on lower totals when the count is high and dealer shows a high card
  }
  
  # Advice string including the player's action and the current true count
  advice <- paste("Player", current_player_index, action, "with a true count of", round(true_count, 2))
  return(advice)
}

# Example usage with multiple decks and initial count
players <- list(
  list(cards = c(1, 9)),
  list(cards = c(5, 10)),
  list(cards = c(5, 6))
)
current_turn <-3
dealer_card <- 8
hits_soft_17 <- FALSE
decks <- 8
initial_running_count <- 0

advice <- blackjack_calculator(players, current_turn, dealer_card, hits_soft_17, decks, initial_running_count)
print(advice)
