ectModule = require('ect')
debug = require('debug') 'httpware-ect'

httpwareEct = (option={})->
  
  ectOption = option.ectOption || 
    cache: false  
    ext: '.ect'
  ectRender = ectModule ectOption 

  for own key, value of option.configure
    httpwareEct.configure[key] = value


  return (req,res,next)-> 

    ect = (tempalteId, InData = {} )->
      debug 'send ect ', tempalteId

      filepath = httpwareEct.configure.fnPath tempalteId 

      viewData = {}
      for own key, value of httpwareEct.configure 
        viewData[key] = value

      for own key, value of InData 
        viewData[key] = value
      


      html = ectRender.render filepath, viewData
      debug 'render file ', filepath
      res.writeHead 200
      res.end html
    res.ect = ect
    return next()

httpwareEct.configure = 
  fnPath : (templateId)-> return templateId


module.exports = exports = httpwareEct