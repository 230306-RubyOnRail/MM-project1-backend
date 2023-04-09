# frozen_string_literal: true

module PrintMessage
  extend ActiveSupport::Concern

  included do
    puts "I am included in #{self}"
    before_action :print_message
  end

  private
  def print_message
    puts "I am a private method"
  end
end