# httpware-ect

> support `ect` template system through `res.ect` 
> support `helpers` function in view  (by `configure`)
> compatible with connec/express


## Examples

 
```coffee  
 
  ect = require '../httpware-ect'
  http = require 'http'


  ect.configure.upperHelper = (string) ->  # configure scope, apply every view
    return string.toUpperCase();

  hand = (req,res,next)->
      data = 
        title : 'Hello, world!',
        id : 'main',
        links: [
          { name : 'Google', url : 'http://google.com/' },
          { name : 'Facebook', url : 'http://facebook.com/' },
          { name : 'Twitter', url : 'http://twitter.com/' }
        ],
        upperHelper : (string) ->  # local scope, apply this view
          return string.toUpperCase();
        
      res.ect 'sample.ect', data

  server = http.createServer flyway [
    ect 
      ectOption:
        ext: '.ect'
        root : 'test'
    hand
  ]
 
# or with connect/express

  connect = require 'connect'
  app = connect()
  app.use ect()
  app.use hand
```  

## Important! - Shadowing of Datas
  
ect.configure < argument 'data'

```coffee 
#Given
  ect.configure.foo = 'a'
  res.ect 'sample.ect', { foo : 'b'}
#result is b
```

## License

(The MIT License)

Copyright (c) 2014 junsik &lt;js@seth.h@google.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 