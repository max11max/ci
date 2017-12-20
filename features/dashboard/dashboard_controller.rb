require "sinatra/base"
require_relative "../../services/services"

module FastlaneCI
  class DashboardController < Sinatra::Base
    HOME = "/dashboard"

    get HOME do
      erb(:dashboard, 
        locals: { 
          taco_count: 18,
          projects: Services::CONFIG_SERVICE.projects
        }
      )
    end

    # Example of json endpoint if you want to use ajax to asyn load stuff
    get "#{HOME}/build_list" do
      Services::BUILD_SERVICE.builds do |builds, paging_token|
        "builds #{builds}, paging token: #{paging_token}"
      end
    end

    # TODO: we'll have to build the whole "Add Project flow"
    # This is the code that can be used to add a new project
    #
    # post "#{HOME}/new" do
    #   projects = Services::CONFIG_SERVICE.projects
    #   projects << Project.new(repo_url: "https://github.com/fastlane/fastlane", enabled: true)
    #   Services::CONFIG_SERVICE.projects = projects
    # end
  end
end
