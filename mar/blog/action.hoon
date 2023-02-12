/-  blog
::
|_  =action:blog
++  grab
  |%
  ++  noun  action:blog
  ++  json
    |=  jon=^json
    =,  dejs:format
    ^-  action:pyro
    %-  of
    :~  [%blog-bind pa]
        [%blog-unbind pa]
        [%save-file (ot ~[file+pa text+so])]
        [%delete-file pa]
    ==
  --
::
++  grow
  |%
  ++  noun  action
  --
::
++  grad  %noun
--
