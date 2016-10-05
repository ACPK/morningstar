module Morningstar
  class Config
    class_attribute :username, :password, :base_url, :register_users

    # Load yaml settings
    YAML.load_file("#{Rails.root}/config/morningstar.yml")[Rails.env].each do |key, value|
      self.send("#{key}=", value)
    end

    Morningstar::Base.base_uri base_url
  end
end
