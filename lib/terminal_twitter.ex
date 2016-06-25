defmodule TerminalTwitter do


  ## FUNCTIONS FOR EXECUTABLE

  def main(args) do
    args |> parse_args
  end

  def parse_args(args) do
    {_, flags, _} = OptionParser.parse(args)
    if length(flags) > 3, do: call_function, else: call_function(flags)
  end
  
  def call_function(["search", term, num]), do: find(term, num)
  def call_function(["user", name, num]),   do: user(name, num)
  def call_function([_, _, _]),             do: call_function
  def call_function(["search", term]),      do: find(term)
  def call_function(["user", name]),        do: user(name)
  def call_function(["new", num]),          do: latest(num)
  def call_function(["me", num]),           do: me(num)
  def call_function([_, _]),                do: call_function
  def call_function(["new"]),               do: latest 
  def call_function(["me"]),                do: me
  def call_function([_]),                   do: call_function
  
  def call_function do
    IO.puts """ 
            \nNot a valid command!
              Try any of the following:
                  `twitter new [number of tweets - 1-200]`
                  `twitter search apple [number of tweets]`
                  `twitter me [number of tweets]
              Ex.
                  `twitter new 100  
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

  
  def user(user, items \\ 200) do
    # TODO : DRY this up to use same function as 'me'
    padding
    
    ExTwitter.user_timeline([screen_name: user, count: items])
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
