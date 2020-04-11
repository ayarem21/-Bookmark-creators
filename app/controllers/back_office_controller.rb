class BackOfficeController < ApplicationController
  before_action :check_admin
  layout "backoffice"
end
