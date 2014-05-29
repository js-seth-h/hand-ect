request = require 'supertest'


describe 'hand-ect', ()->

  flyway = require 'flyway'
  ect = require '../src'
  http = require 'http'

  ect.configure.upperHelper = (string) ->
    return string.toUpperCase();
  hand = (req,res,next)->
      data = 
        title : 'Hello, world!',
        id : 'main',
        links: [
          { name : 'Google', url : 'http://google.com/' },
          { name : 'Facebook', url : 'http://facebook.com/' },
          { name : 'Twitter', url : 'http://twitter.com/' }
        ]
        
      res.ect 'sample.ect', data

  server = http.createServer flyway [
    ect 
      ectOption:
        ext: '.ect'
        root : 'test'
    hand
  ]

  agent = request.agent(server);
    
  it 'should set ', (done)-> 
    # request(server)
    agent.get('/')
      .expect 200
      .expect /.*<html>.*/ 
      .expect /.*href.*/  
      .expect /.*Google.*/ 
      .expect /.*<h1>HELLO.*/ 
      .end done
 

  # describe 'with connect', ()->
 
  #   connect = require('connect') 
  #   app = connect()
  #   app.use ect()
  #   app.use (req,res,next)->
  #     res.ect 'test/sample.ect'

  #   agent = request.agent(server);
      
  #   it 'should set ', (done)-> 
  #     # request(server)
  #     agent.get('/set')
  #       .expect(200, 'set') 
  #       .end done

  #   it 'should get ', (done)-> 
  #     agent.get('/get')
  #       .expect(200, 'test-result')
  #       .end done
   