defmodule TerminalTwitter do


  ## FUNCTIONS FOR EXECUTABLE

  def main(args) do
    args |> parse_args
  end

  def parse_args(args) do
    {_, flags, _} = OptionParser.parse(args)

    if length(flags) == 2 do
      call_function(Enum.at(flags, 0), Enum.at(flags, 1))
    else
      Enum.at(flags, 0) |> call_function
    end
  
  end
  
  def call_function("new") do
    latest
  end
  
  def call_function("search", term) do
    find(term)
  end
  
  def call_function("me") do
    me
  end

  def call_function(function_name) do
    IO.puts """ 
            Not a valid command!
              Try any of the following:
                  `twitter new`
                  `twitter search apple`
                  `twitter me`
            """
  end


  ## HELPER FUNCTIONS

  def padding do 
    IO.puts "\n"
  end

  def bold(text) do
    "\e[1m#{text}\e[0m"
  end

  def retweets(rt_count) do
    "♺ (#{rt_count})"
  end

  def user_details(tweet) do
    "#{tweet.name} (@#{tweet.screen_name})"
  end

  def line_break(text) do
    "#{text}\n"
  end

  def indent(text) do
    text
    |> String.split("\n")
    |> Enum.map(fn(line) -> "  #{line}" end)
    |> Enum.join("\n")
    |> String.replace("&amp;", "&")
  end

  def details(tweet) do
    "♺ (#{tweet[:rt]}) \t #{tweet[:date]}"
  end


  ### TWITTER API FUNCTIONS

  def latest(items \\ 200) do
    padding
    
    ExTwitter.home_timeline(count: items)
    |> Enum.map(fn(tweet) -> 
      [
        tweet.user |> user_details |> bold |> line_break,
        tweet.text |> indent |> line_break,
        %{date: tweet.created_at, rt: tweet.retweet_count} |> details
      ] 
      |> Enum.join("\n")
    end) 
    |> Enum.join("\n\n-----\n\n") 
    |> IO.puts
    
    padding
  end


  def me(items \\ 200) do
    padding
    
    ExTwitter.user_timeline(count: items)
    |> Enum.map(fn(tweet) -> 
      [
        tweet.text |> line_break,
        %{date: tweet.created_at, rt: tweet.retweet_count} |> details
      ] 
      |> Enum.join("\n")
    end) 
    |> Enum.join("\n\n-----\n\n") 
    |> IO.puts
    
    padding
  end

  
  def find(search_term, items \\ 200) do
    padding
    
    ExTwitter.search(search_term, [count: items])
    |> Enum.map(fn(tweet) -> 
      [
        tweet.user |> user_details |> bold |> line_break,
        tweet.text |> indent |> line_break,
        %{date: tweet.created_at, rt: tweet.retweet_count} |> details
      ] 
      |> Enum.join("\n")
    end) 
    |> Enum.join("\n\n-----\n\n") 
    |> IO.puts
    
    padding
  end

end
