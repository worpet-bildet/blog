/-  blog
::
|_  =action:blog
++  grab
  |%
  ++  noun  action:blog
  ++  json
    =,  dejs:format
    %-  of
    :~  [%publish (ot ~[path+pa html+so md+so])]
        [%unpublish (ot ~[path+pa])]
        [%save-draft (ot ~[path+pa md+so])]
        [%delete-draft (ot ~[path+pa])]
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
