def find_kevin_bacon(start_node)
  array_of_links = []
  if start_node == kevin_bacon
    return array_of_links
  end
  current_actor = start_node
  while current_actor != kevin_bacon
    array_of_links = search_filmography_for_bacon(current_actor, array_of_links)
    current_movie = array_of_links.last
    if current_movie.include?(kevin_bacon)
      current_actor = kevin_bacon
    else
      current_actor = current_movie.sample
    end
  end
  if array_of_links.length <= 6
    return array_of_links
  else find_kevin_bacon(start_node)
  end
end

def search_filmography_for_bacon(current_actor, array_of_links)
  list_of_movies = current_actor.keys
  list_of_movies.each do |movie|
    movie.each do |actor|
      if actor == kevin_bacon
        return array_of_links << movie
      end
    end
    next_link = list_of_movies.sample
    while array_of_links.include?(next_link)
      next_link = list_of_movies.sample
    end
    array_of_links << next_link
  end

end
