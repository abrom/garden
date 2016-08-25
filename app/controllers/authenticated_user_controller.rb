class AuthenticatedUserController < ApplicationController
  before_filter :authenticate_user!
end
