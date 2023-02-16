|=  [[now=@da eny=@uvJ byk=beak] ~ ~]
|=  [authenticated=? =request:http]
:: TODO this code is ugly. Either:
::   split this into two generators
::   put the logic in a mark
=/  turl=tape  (trip url.request)
=/  turl-len  (lent turl)
=^  content-type=@t  url.request
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
^-  simple-payload:http
:-  [200 ['Content-Type' content-type]~]
%-  some
%-  as-octs:mimes:html
.^  @t  %gx
    ;:  weld
      /(scot %p p.byk)/blog/(scot r.byk)
      (rash url.request stap)  /noun
    ==
==