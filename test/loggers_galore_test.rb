require 'test_helper'

class LoggersGaloreTest < ActiveSupport::TestCase
  
  def log_dir(filename)
    "#{Rails.root}/log/%s.log" % filename.to_s
  end
  
  
  test "should be able to set loggers through Rails module" do
    assert Rails.respond_to?(:extra_loggers=)
  end
  
  test "should raise an exception if arguements are not an array, string or symbol" do
    assert_raise ArgumentError do
      Rails.extra_loggers = [true, 1]
    end
  end
  
  test "should create a new log file in log dir" do
    File.delete(log_dir :dummy) if File.exist?(log_dir :dummy)
    Rails.extra_loggers = [:dummy]
    assert File.exist?(log_dir :dummy)
  end
  
  test "should raise an error if logger is called test, production or development" do
    assert_raise ArgumentError do
      Rails.extra_loggers = [:test]
    end
    assert_raise ArgumentError do
      Rails.extra_loggers = [:production]
    end
    assert_raise ArgumentError do
      Rails.extra_loggers = [:development]
    end
  end
  
  test "should add logger method to ActionController::Base, ActiveRecord::Base and ActionMailer::Base" do
    Rails.extra_loggers = [ :alvin, :simon, :theodore ]
    [ ActionController::Base, ActionMailer::Base, ActiveRecord::Base ].each do |fwrk|
      assert fwrk.respond_to?("alvin_logger")
      assert fwrk.respond_to?("simon_logger")
      assert fwrk.respond_to?("theodore_logger")
    end
  end
  
  test "should add a line-break if this is a new log" do
    File.delete(log_dir :another_dummy) if File.exist?(log_dir :another_dummy)
    Rails.extra_loggers = [:another_dummy]
    assert File.read(log_dir :another_dummy)["\n"]
  end
  
end
