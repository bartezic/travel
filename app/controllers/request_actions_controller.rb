class RequestActionsController < InheritedResources::Base
  def create
    @request_action = RequestAction.new(params[:request_action])

    respond_to do |format|
      if @request_action.save && (@request_action.email || @request_action.phone)
        AdminUser.all.each do |user|
          RequestActionsMailer.new_request(@request_action, user.email).deliver
        end
        format.html { redirect_to :back, notice: 'Successfully created.' }
        format.json { render json: { success: true }, status: :created }
      else
        format.html { redirect_to :back, notice: 'Oops...' }
        format.json { render json: { success: false }, status: :unprocessable_entity }
      end
    end
  end
end
