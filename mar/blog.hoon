:: Realy all unix/mime stuff should look something like this but w/e
::
|_  txt=@t
::
++  grab
  |%
  ++  mime  |=((pair mite octs) (@t q.q))
  ++  noun  @t
  --
++  grow
  |%
  ++  mime  [/text/plain (as-octs:mimes:html txt)]
  ++  json  [%s txt]
  --
++  grad  %mime
--
