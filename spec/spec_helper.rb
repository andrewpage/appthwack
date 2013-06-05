require 'rspec'
require 'appthwack'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

def mock_projects_response(token)
  url = "https://#{token}@appthwack.com/api/project/"
  response = "[{\"name\": \"cisimple - ios\", \"url\": \"cisimple-ios\", \"id\": 4698}, {\"name\": \"cisimple - android\", \"url\": \"cisimple-android\", \"id\": 4697}]"
  FakeWeb.register_uri(:get, url, :body => response, :status => 200)
end

def mock_device_pools_response(token, project_id)
  url = "https://#{token}@appthwack.com/api/devicepool/#{project_id}"
  response = "[{\"id\": 1, \"name\": \"All devices (25)\"}, {\"id\": 4, \"name\": \"Top 10 devices (10)\"}]"
  FakeWeb.register_uri(:get, url, :body => response, :status => 200)
end

def mock_upload_file_response(token)
  url = "https://#{token}@appthwack.com/api/file"
  response = "{ \"file_id\": 42 }"
  FakeWeb.register_uri(:post, url, :body => response, :status => 200)
end

def mock_schedule_test_response(token)
  url = "https://#{token}@appthwack.com/api/run"
  response = "{ \"run_id\": 43 }"
  FakeWeb.register_uri(:post, url, :body => response, :status => 200)
end

def mock_test_run_status_response(token, project_id, run_id)
  url = "https://#{token}@appthwack.com/api/run/#{project_id}/#{run_id}/status"
  response = "{ \"status\": \"completed\" }"
  FakeWeb.register_uri(:get, url, :body => response, :status => 200)
end

def mock_test_run_results_response(token, project_id, run_id)
  url = "https://#{token}@appthwack.com/api/run/#{project_id}/#{run_id}"
  response = "{ }"
  FakeWeb.register_uri(:get, url, :body => response, :status => 200)
end
