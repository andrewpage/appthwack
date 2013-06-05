require 'spec_helper'
require 'fake_web'
require 'timecop'

describe Appthwack do
  
  let(:api_token) { "DTOZZNWeCNWFWtuqqJEm14nnonVJMDXA9flmdvzg" }
  
  before do
    FakeWeb.allow_net_connect = false
  end
  
  describe "When configuring an Appthwack Client" do
    
    it "should correctly configure the api_token" do
      Appthwack::Client.new(api_token).api_token.should == api_token
    end
    
    it "should correctly configure connection options" do
      options = {
        base_url: "thwackbin.herokuapp.com",
        request_timeout: 5,
        open_timeout: 5
      }
      
      client = Appthwack::Client.new(api_token, options)
      client.base_url.should == options[:base_url]
      client.request_timeout.should == options[:request_timeout]
      client.open_timeout.should == options[:open_timeout]
    end
    
  end
  
  describe "When using an Appthwack Client" do
    
    let (:client) { Appthwack::Client.new(api_token) }
    let (:project_id) { 2 }
    let (:run_id) { 3 }
    
    before do
      mock_projects_response(api_token)
      mock_device_pools_response(api_token, project_id)
      mock_upload_file_response(api_token)
      mock_schedule_test_response(api_token)
      mock_test_run_status_response(api_token, project_id, run_id)
      mock_test_run_results_response(api_token, project_id, run_id)
    end
    
    it "should successfully retrieve projects" do
      client.projects.count.should == 2
    end
    
    it "should successfully retrieve device pools for a project" do
      client.device_pools(project_id).count.should == 2
    end
    
    it "should upload a file" do
      f = File.open("spec/fixtures/files/com.actionbarsherlock.sample.demos.4.1.0.apk")
      client.upload_file("myfile.apk", f)["file_id"].should_not be_nil
    end
    
    it "should schedule a test" do
      client.schedule_test("my test", project_id, run_id)["run_id"].should_not be_nil
    end
    
    it "should retrieve test run status" do
      client.test_run_status(project_id, run_id)["status"].should_not be_nil
    end
    
    it "should retrieve test run results" do
      client.test_run_results(project_id, run_id)
    end
    
  end
  
end