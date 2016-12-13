class AppointmentsController < ApplicationController
  before_action :require_login
  # before_action :require_trainer only: [:destroy]

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user

    if @appointment.save
      @appointment.trainee_id = @appointment.user.id
      redirect_to user_url(@appointment.user), notice: "Appointment request sent!"
    else
      flash[:alert] = "Failed to process appointment request"
      render '/users'
    end
  end

  private

  def pledge_params
    params.require(:appointment).permit(:time)
  end
end
