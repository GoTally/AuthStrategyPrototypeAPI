class HealthController < ApplicationController
  def status
    render text: 'ok'
  end
end
