#!/usr/bin/env ruby -wKU

###
# Student Name: Dan Nguyen
# Homework Week: 9
# Assignment: Sinatra webapp
###

require 'controller'
require "test/unit"
require 'rack/test'

set :environment, :test

 class ControllerTest < Test::Unit::TestCase
   include Rack::Test::Methods

   def app
     Sinatra::Application
   end
    
   def setup
     post '/login', :name => 'dantest'
     assert last_response.ok?
   end  
   
   def teardown
     get '/logout'
     assert last_response.ok?
   end
    
   def test_login
     get '/login'
     assert last_response.ok?
     assert last_response.body.include?('login - allows users to signin')
     
     post '/login', :name => 'test_name'
     assert last_response.ok?
     assert last_response.body.include?('Welcome to the webapp, click on some links.')     
   end

   # redirects to '/menu'
   def test_root
     get  '/'
     assert last_response.ok?
     assert last_response.body.include?('menu - routes for this webapp')
   end
   
   def test_menu
     get '/menu'
     assert last_response.ok?
     assert last_response.body.include?('menu - routes for this webapp')
   end

   def test_math
     get '/math'
     assert last_response.ok?
     assert last_response.body.include?('math - calculates simple math expressions')
     
     post '/math'
     assert last_response.ok?
     
     post '/math', :expression => "5 + 7"
     assert last_response.ok?
     assert last_response.body.include?("12")
     
     post '/math', :expression => "5 - 7"
     assert last_response.ok?
     assert last_response.body.include?("-2")
     
     post '/math', :expression => "5 - 7"
     assert last_response.ok?
     assert last_response.body.include?("-2")
     
     post '/math', :expression => "10 / 0"
     assert last_response.ok?
     assert last_response.body.include?("Sorry we are unable to calculate the expression: 10 / 0")

     post '/math', :expression => "5 ** 2"
     assert last_response.ok?
     assert last_response.body.include?("Unsupported operation: 5 ** 2")
     
     post '/math', :expression => "7.4 / 2.1"
     assert last_response.ok?
     assert last_response.body.include?("3.52380952380952")
     
     post '/math', :expression => "4.4 / 3.0"
     assert last_response.ok?
     assert last_response.body.include?("1.46666666666667")
     
     post '/math', :expression => "5x + 3x"
     assert last_response.ok?
     assert last_response.body.include?("Sorry we are unable to calculate the expression: 5x + 3x")
     
   end  

   def test_time
     get '/time'
     assert last_response.ok?
     assert last_response.body.include?('time - the current date and time')
   end
   
   def test_tracker 
     get '/tracker'
     assert last_response.ok?
     assert last_response.body.include?('Tracker - display page history')    
   end
   
   def test_fibonacci
     get '/fibonacci'
     assert last_response.ok?
     assert last_response.body.include?('fibonacci - generates a small set of the fibonacci sequence')
     
     post '/fibonacci', :limit => 5
     assert last_response.ok?
     assert last_response.body.include?('fibonacci output')
     assert last_response.body.include?("[1, 1, 2, 3, 5]")
     
     post '/fibonacci', :limit => 12
     assert last_response.ok?
     assert last_response.body.include?('fibonacci output')
     assert last_response.body.include?("[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]")
     
   end
   
   def test_factorial
     get '/factorial'
     assert last_response.ok?
     assert last_response.body.include?('factorial - calculates the factorial for the given number')
   
     post '/factorial', :n => 7
     assert last_response.ok?
     assert last_response.body.include?('factorial output')
     assert last_response.body.match("5040")
     
     post '/factorial', :n => 4
     assert last_response.ok?
     assert last_response.body.include?('factorial output')
     assert last_response.body.match("24")
   end
   
   def test_madlib
     get '/madlib'
     assert last_response.ok?
     assert last_response.body.include?('madlib - enter some words into the fields below')

     post '/madlib', :animals	            => 'monkeys', 
                     :body_part           => 'nose', 
                     :company             => 'Costco',
                     :description         => 'ugly', 
                     :group_of_people	    => 'Amish', 
                     :liquid	            => 'jello', 
                     :name_of_a_comedian	=> 'Chris Farley',
                     :perl6_release_date  => '2043'
                     
     assert last_response.ok?
     assert last_response.body.include?('madlib output')
     assert last_response.body.include?('monkeys')
     assert last_response.body.include?('nose')
     assert last_response.body.include?('Costco')
     assert last_response.body.include?('ugly')
     assert last_response.body.include?('Amish')
     assert last_response.body.include?('jello')
     assert last_response.body.include?('Chris Farley')
     assert last_response.body.include?('2043')
     
   end
   
 
 end
