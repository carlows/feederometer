require_relative "riot_api_requests_json"

class RiotApiDataProcessor
	def initialize
		@riot_api = RiotApiRequestsJSON.new('73cb4b46-ae25-440f-bb17-da66159eff9b')
	end

	def get_recent_games_data_for_summoner_name(summoner_name)
		summoner_name = summoner_name.downcase

		summoner_data = @riot_api.request_summoner_data(summoner_name)
		summoner_id = summoner_data[summoner_name]["id"]
		recent_games_data = @riot_api.request_recent_games_data(summoner_id)

		recent_games_summoner_data = {
			"name" => summoner_data[summoner_name]["name"],
			"icon_id" => summoner_data[summoner_name]["profileIconId"],
			"stats_games" => recent_games_data["games"].map do | item |
				{
					"deaths" => item["stats"]["numDeaths"],
					"assists" => item["stats"]["assists"],
					"kills" => item["stats"]["championsKilled"],
					"win" => item["stats"]["win"],
					"champion_id" => item["championId"]
				}
			end
		}		
	end
end