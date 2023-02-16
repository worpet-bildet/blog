|=  [[now=@da eny=@uvJ byk=beak] ~ ~]
|=  [authenticated=? =request:http]
^-  simple-payload:http
=/  turl=tape  (trip url.request)
=/  turl-len  (lent turl)
=/  scry-path=@t
  =+  md=(find ".md" turl)
  ?:  &(?=(^ md) =((add u.md 3) turl-len))
    (crip (weld "/md" (swag [0 (sub turl-len 3)] turl)))
  =+   html=(find ".html" turl)
  ?:  &(?=(^ html) =((add u.html 5) turl-len))
    (crip (weld "/html" (swag [0 (sub turl-len 5)] turl)))
  (crip (weld "/html" turl))
::
^-  [response-header:http (unit octs)]
:-  [200 ['Content-Type' 'text/html; charset=utf-8']~]
%-  some
%-  as-octs:mimes:html
.^  @t  %gx
    ;:  weld
      /(scot %p p.byk)/blog/(scot r.byk)
      (rash scry-path stap)  /noun
    ==
==