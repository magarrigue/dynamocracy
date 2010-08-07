ActionController::Dispatcher.middleware.use Rack::OpenID, ActiveRecordStore.new

class OpenID::Consumer::SuccessResponse
  def get_signed(ns_uri, ns_key, default=nil)
    if signed?(ns_uri, ns_key)
      return @message.get_arg(ns_uri, ns_key, default)
    else
      return default
    end
  end
end