#require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'vO3vsluUKckpwd8VihRA', 'xIZRnNCpTQMzCAQ3L4dSVZDf8KwCRbPoDK89r12coB4'
  provider :facebook, '117824241614921', '24949d831343e6e8756d5a6c5fea9335'
#  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end