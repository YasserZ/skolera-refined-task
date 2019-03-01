class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :provider, :uid, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :email, :name, :nickname, :image
end
