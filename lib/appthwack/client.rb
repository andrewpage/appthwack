module Appthwack
  class Client
    attr_accessor :api_token, :base_url, :request_timeout, :open_timeout, :last_request
    
    def initialize(api_token, options={})
      @api_token = api_token
      
      @base_url, @request_timeout, @open_timeout = {
        base_url: BASE_URL,
        request_timeout: 600,
        open_timeout: 10
      }.merge(options).values
    end
    
    def projects
      get("#{@base_url}/api/project/")
    end
    
    def create_device_pool(name, device_ids)
      payload = {
        :name => name,
        :devices => device_ids
      }
      
      post("#{@base_url}/api/devicepool", payload)
    end
    
    def device_pools(project_id)
      get("#{@base_url}/api/devicepool/#{project_id}")
    end
    
    def devices
      get("#{@base_url}/api/device")
    end
    
    def upload_file(name, file)
      payload = {
        :name => name,
        :file => file
      }
      
      post("#{@base_url}/api/file", payload)
    end
    
    def schedule_test(name, project_id, app_file_id, opt={})
      payload = {
        :project => project_id,
        :name => name,
        :app => app_file_id
      }.merge(opt)
      
      post("#{@base_url}/api/run", payload)
    end
    
    def test_run_status(project_id, run_id)
      get("#{@base_url}/api/run/#{project_id}/#{run_id}/status")
    end
    
    def test_run_results(project_id, run_id)
      get("#{@base_url}/api/run/#{project_id}/#{run_id}")
    end
    
    private
    
    def get(url, params={})
      @last_request = {
        url: url,
        request: params
      }
      
      if params.empty?
        query_string_params = ""
      else
        query_string_params = "?" +  params.collect{ |p| "&#{p[0].to_s}=#{p[1].to_s}" }.join
      end
      
      result = RestClient::Request.execute(:method => :get, :url => "#{url}#{query_string_params}", :timeout => @request_timeout, :open_timeout => @open_timeout, :user => @api_token, :password => "")
      @last_request[:response] = result
      
      JSON.parse(result)
    end
    
    def post(url, data)
      @last_request = {
        url: url,
        request: data
      }
      
      result = RestClient::Request.execute(:method => :post, :url => url, :payload => data, :timeout => @request_timeout, :open_timeout => @open_timeout, :user => @api_token, :password => "")
      @last_request[:response] = result
      
      JSON.parse(result)
    end
    
  end
end