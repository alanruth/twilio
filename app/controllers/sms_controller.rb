class SmsController < ApplicationController

 skip_before_action :verify_authenticity_token

  def create
	  @sms_state = session[:state]

	  if @sms_state.nil? || @sms_state == ''
		  @sms_state = 'step_1'
		  session[:state] = @sms_state
		  #message = 'hello this is me'
		  #twiml = Twilio::TwiML::Response.new do |r|
		  #  r.Sms message
		  #end
		  #twiml.text

		  message = '<Response><Sms>Thank you for contacting Sparktext. Please respond with your name.'+session[:state]+'</Sms></Response>'
		  render :text => message, :content_type => 'text/xml'

	  elsif @sms_state == 'step_1'
		  @sms_state = "step_2"
		  session[:state] = @sms_state
		  message = '<Response><Sms>Respond with how can we help you?</Sms></Response>'

		  render :text => message, :content_type => 'text/xml'

	  elsif @sms_state == "step_2"
		  @sms_state = "step_3"
		  session[:state] = @sms_state
		  message = '<Response><Sms>Respond with how many people are affected.</Sms></Response>'

		  render :text => message, :content_type => 'text/xml'
	  else
		  @sms_state = "final"
		  session[:state] = @sms_state
		  message = '<Response><Sms>Your request has been saved.</Sms></Response>'

		  render :text => message, :content_type => 'text/xml'
	  end
  end
end
