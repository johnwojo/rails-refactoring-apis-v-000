class GithubRepo

  attr_reader :name, :url

  def initialize(hash = {})
    @name = hash["name"]
    @url = hash["html_url"]
  end

  def authenticate!(client_id, client_secret, code)
   response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: client_secret, code: code}, {'Accept' => 'application/json'}
   access_hash = JSON.parse(response.body)
   access_hash["access_token"]
  end

  def get_username(token)
   user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{token}", 'Accept' => 'application/json'}
   user_json = JSON.parse(user_response.body)
   user_json["login"]
 end

  def get_repos(token)
   resp = Faraday.get("https://api.github.com/user/repos") do |req|
     req['Authorization'] = "token #{token}"
     req['Accept'] = 'application/json'
   end
   JSON.parse(resp.body)
 end

  def create_repo(name, token)
   poster = Faraday.post "https://api.github.com/user/repos", {name: name}.to_json, {'Authorization' => "token #{token}", 'Accept' => 'application/json'}
 end
end
