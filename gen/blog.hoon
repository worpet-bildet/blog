|=  [[now=@da eny=@uvJ byk=beak] ~ ~]
|=  [authenticated=? =request:http]
^-  simple-payload:http
=*  data
  %-  as-octs:mimes:html
  .^  @t
      %cx
      %+  weld
        /(scot %p p.byk)/blog/(scot r.byk)/posts
      (pa:dejs:format [%s url.request])
  ==
:_  `(unit octs)``data
`response-header:http`[200 ['Content-Type' 'text/html']~]
