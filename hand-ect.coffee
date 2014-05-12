ectModule = require('ect')
 

handEct = (option={})->
  
  ectOption = option.ectOption || 
    cache: false  
    ext: '.ect'
  ectRender = ectModule ectOption 

  for own key, value of option.helpers
    handEct.helpers[key] = value

  return (req,res,next)-> 

    ect = (tempalteId, data = null )->
      data = res.data unless data
      filepath = handEct.helpers.fnPath tempalteId 

      for own key, value of handEct.helpers 
        data[key] = value
    
      html = ectRender.render filepath, data
      res.writeHead 200
      res.end html
    res.ect = ect
    return next()

handEct.helpers = 
  fnPath : (templateId)-> return templateId


module.exports = exports = handEct