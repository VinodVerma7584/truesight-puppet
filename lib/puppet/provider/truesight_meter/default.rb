Puppet::Type.type(:truesight_meter).provide(:default) do

  desc "This is a default provider that does nothing. This allows us to install the Truesight meter on the same puppet run where we want to use it."

  def create
    return false
  end

  def destroy
    return false
  end

  def exists?
    fail('This is just the default provider for Truesight meter, all it does is fail')
  end
end
