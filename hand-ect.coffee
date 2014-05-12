ectModule = require('ect')
 

handEct = (option={})->
  
  ectOption = option.ectOption || 
    cache: false  
    ext: '.ect'
  ectRender = ectModule ectOption 

  for own key, value of option.global
    handEct.global[key] = value

  return (req,res,next)-> 

    ect = (tempalteId, InData = {} )->

      filepath = handEct.global.fnPath tempalteId 

      viewData = {}
      for own key, value of handEct.global 
        viewData[key] = value

      for own key, value of res.data 
        viewData[key] = value

      for own key, value of InData 
        viewData[key] = value
      


      html = ectRender.render filepath, viewData
      res.writeHead 200
      res.end html
    res.ect = ect
    return next()

handEct.global = 
  fnPath : (templateId)-> return templateId


module.exports = exports = handEct