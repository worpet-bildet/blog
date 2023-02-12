/-  blog
::
|_  =action:blog
++  grab
  |%
  ++  noun  action:blog
  ++  json
    =,  dejs:format
    %-  of
    :~  [%unbind-post pa]
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
