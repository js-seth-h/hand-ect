request = require 'supertest'


describe 'hand-ect', ()->

  ho = require 'handover'
  ect = require '../hand-ect'
  http = require 'http'


  server = http.createServer ho.make [
    ect 
      ectOption:
        ext: '.ect'
        root : 'test'
    (req,res,next)->
      data = 
        title : 'Hello, world!',
        id : 'main',
        links: [
          { name : 'Google', url : 'http://google.com/' },
          { name : 'Facebook', url : 'http://facebook.com/' },
          { name : 'Twitter', url : 'http://twitter.com/' }
        ],
        upperHelper : (string) ->
          return string.toUpperCase();
        
      res.ect 'sample.ect', data

  ]

  agent = request.agent(server);
    
  it 'should set ', (done)-> 
    # request(server)
    agent.get('/')
      .expect 200
      .expect /.*<html>.*/ 
      .expect /.*href.*/  
      .expect /.*Google.*/ 
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
   