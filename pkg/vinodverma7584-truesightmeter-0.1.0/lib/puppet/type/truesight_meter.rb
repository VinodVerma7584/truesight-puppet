Puppet::Type.newtype(:truesight_meter) do

  @doc = "Manage creation/deletion of Truesight meters."

  ensurable

  newparam(:meter, :namevar => true) do
    desc "The Truesight meter name."
  end

  newparam(:token) do
    desc "The Truesight Installation Token."
  end

  newproperty(:tags, :array_matching => :all) do
    desc "Tags to be added to the Truesight meter. Specify a tag or an array of tags."

    def insync?(is)
      is.sort == @should.sort
    end
  end
end
