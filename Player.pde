public class Player
{
  private String playerName;

  //Constructor to create a player with a starting name
  public Player(String playerName)
  {
    this.playerName = playerName;
  }

  //getters
  public String getPlayerName()
  {
    return playerName;
  }

  //setter for player name
  public void setPlayerName(String playerName)
  {
    this.playerName = playerName;
  }
}