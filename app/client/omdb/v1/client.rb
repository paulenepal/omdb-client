class Omdb::V1::Client

  BASE_URL = 'https://www.omdbapi.com/'.freeze
  API_KEY = Rails.application.credentials.omdb_api_key

  def movie(query)
    conn = connection
    response = conn.get('', { t: query, apikey: API_KEY })
    handle_response(response)
  end

  private

  def connection
    Faraday.new(url: BASE_URL) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def handle_response(response)
    case response.status
    when 200
      JSON.parse(response.body)
    else
      raise StandardError, "Error: #{response.status} - #{response.body}"
    end
  end

end