|=  [[now=@da eny=@uvJ byk=beak] ~ ~]
|=  [authenticated=? =request:http]
^-  simple-payload:http
=*  data
  %-  as-octs:mimes:html
  .^  @t
      %gx
      ;:  weld
        /(scot %p p.byk)/blog/(scot r.byk)/html
        (pa:dejs:format [%s url.request])
        /noun
      ==
  ==
:_  `(unit octs)``data
`response-header:http`[200 ['Content-Type' 'text/html']~]
