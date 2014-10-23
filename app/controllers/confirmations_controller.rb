class ConfirmationsController < Devise::ConfirmationsController

  respond_to :json

  def show
	self.resource = resource_class.confirm_by_token(params[:confirmation_token])
	yield resource if block_given?
	if resource.errors.empty?
	respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
	else
	respond_with_navigational(resource){ redirect_to "/login?confirmation_error=true" }
	end
  end

  private

  def after_confirmation_path_for(resource_name, resource)
  	"/login?email=#{resource.email}&confirmed=true"
  end

end