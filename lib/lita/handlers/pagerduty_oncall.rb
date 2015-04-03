require "time"
require "json"
require "net/http"

module Lita
  module Handlers
    class PagerdutyOncall < Handler

      route(
        /^oncall|whoisoncall$/,
        :print_oncall, 
        command: true,
        help: { "oncall | whoisoncall" => "Show who is Oncall as per PagerDuty" } 
      )

      def print_oncall(resp)
        oc = pdapi_get_oc
        fmt = parse_escalation_policy(oc)
        resp.reply(fmt)
      end

      def self.default_config(config)
        config.api_key = nil
        config.subdomain = nil
      end

      def base_url
        "https://#{subdomain}.pagerduty.com/api/v1"
      end

      def subdomain
        Lita.config.handlers.pagerduty_oncall.subdomain
      end

      def api_key
        Lita.config.handlers.pagerduty_oncall.api_key
      end
  
      def pdapi_get_oc
        #base_url  = "https://#{subdomain}.pagerduty.com/api/v1"
        uri = URI("#{base_url}/escalation_policies/on_call")

        req = Net::HTTP::Get.new(uri)
        req.add_field("Content-type", "application/json")
        req.add_field("Authorization", "Token token=#{api_key}")

        res = Net::HTTP.start(uri.host, uri.port,
                      :use_ssl => uri.scheme == 'https') do |http|
          http.request(req)
        end
        res.body
      end

      def parse_escalation_policy(json_resp)
        fmt = ""
        JSON.parse(json_resp)["escalation_policies"].each do |p|
          fmt.concat("#{p["name"]}:\n")

          count = 0
          p["on_call"].each do |oc|
            oc_time = "" 			#####  "#{oc["start"]} - #{oc["end"]}"
            if oc["start"].to_s.empty?
              oc_time = "static"
            else 
	      stime = Time.parse(oc["start"]).strftime("%m/%d/%y %H:%M")
              etime = Time.parse(oc["end"]).strftime("%m/%d/%y %H:%M %Z") 
              oc_time = "#{stime} - #{etime}"
            end

            fmt.concat("  #{oc["level"]}: #{oc["user"]["name"]} (#{oc_time})\n")
            count += 1
          end #/p.each

          if count == 0
             fmt.concat("  -- Empty Rotation --\n")
          end
          fmt.concat("\n")
        end #/JSON.prase
        fmt
      end #/def

    end #/Class

    Lita.register_handler(PagerdutyOncall)
  end #/Module
end
