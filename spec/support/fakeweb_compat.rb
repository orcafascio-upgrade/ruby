# Compatibility layer for FakeWeb -> WebMock migration
module FakeWeb
  def self.register_uri(method, uri, options = {})
    stub = WebMock.stub_request(method.to_sym, uri)
    
    response_options = {}
    response_options[:body] = options[:body] if options[:body]
    response_options[:status] = options[:status] if options[:status]
    
    if options[:content_type]
      response_options[:headers] = { "Content-Type" => options[:content_type] }
    end
    
    stub.to_return(response_options) unless response_options.empty?
    stub
  end

  def self.last_request
    last_request_signature = WebMock::RequestRegistry.instance.requested_signatures.last
    return nil unless last_request_signature
    
    request = last_request_signature.request
    uri = URI(request.uri.to_s)
    path_with_query = uri.path
    path_with_query += "?#{uri.query}" if uri.query
    
    # Create a request object that mimics FakeWeb's last_request
    request_obj = Object.new
    
    # Store headers for access
    headers_hash = request.headers || {}
    
    # Define methods on the request object
    request_obj.define_singleton_method(:body) { request.body }
    request_obj.define_singleton_method(:path) { path_with_query }
    request_obj.define_singleton_method(:method) { request.method.to_s.upcase }
    request_obj.define_singleton_method(:[]) do |key|
      headers_hash[key] || headers_hash[key.to_s] || headers_hash[key.to_s.downcase]
    end
    
    request_obj
  end

  def self.clean_registry
    WebMock.reset!
  end

  def self.allow_net_connect=(value)
    if value
      WebMock.allow_net_connect!
    else
      WebMock.disable_net_connect!(allow_localhost: true)
    end
  end
end

