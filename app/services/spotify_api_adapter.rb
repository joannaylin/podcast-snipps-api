class SpotifyApiAdapter

  # def self.search_catalog(user, query)
  #   p user
  #   user.refresh_access_token

  #   header = {
  #     "Authorization": "Bearer #{user.access_token}"
  #   }

  #   query_params = {
  #     q: query,
  #     type: "show",
  #     market: "US",
  #     limit: 10
  #   }

  #   search_response = RestClient.get("https://api.spotify.com/v1/search#{query_params.to_query}", header)
  #   search_params = JSON.parse(search_response)
  # end

end