def login(u = nil)
  u ||= Factory(:user)
  sign_in :user, u
  u
end

def logout
  sign_out :user
end
