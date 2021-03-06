class UserSession < Authlogic::Session::Base
  # only session related configuration goes here, see documentation for sub modules of Authlogic::Session
  # other config goes in acts_as block
  logout_on_timeout(true)
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end