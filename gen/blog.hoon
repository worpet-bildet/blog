|=  [[now=@da eny=@uvJ byk=beak] ~ ~]
|=  [authenticated=? =request:http]
^-  simple-payload:http
=/  turl=tape  (trip url.request)
=/  turl-len  (lent turl)
:: TODO all the text parsing here is super ugly, might
::   be a better way to do it, but basically just detect
::   .md or .html, manipulate the scry-path, add 
::   proper headers, and that's it.
=/  [content-type=@t scry-path=@t]
  =+  md=(find ".md" turl)
  ?:  &(?=(^ md) =((add u.md 3) turl-len))
    :-  'text/plain; charset=utf-8'
    (crip (weld "/md" (swag [0 (sub turl-len 3)] turl)))
  :-  'text/html; charset=utf-8'
  =+   html=(find ".html" turl)
  ?:  &(?=(^ html) =((add u.html 5) turl-len))
    (crip (weld "/html" (swag [0 (sub turl-len 5)] turl)))
  (crip (weld "/html" turl))
::
^-  [response-header:http (unit octs)]
:-  [200 ['Content-Type' content-type]~]
%-  some
%-  as-octs:mimes:html
.^  @t  %gx
    ;:  weld
      /(scot %p p.byk)/blog/(scot r.byk)
      (rash scry-path stap)  /noun
    ==
==