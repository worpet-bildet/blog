|_  bind=(list [binding:eyre duct action:eyre])
::
++  grab
  |%
  ++  noun  (list [binding:eyre duct action:eyre])
  --
::
++  grow
  |%
  ++  noun  bind
  ++  json
    :-  %a
    %+  turn  bind
    |=  [=binding:eyre duct action:eyre]
    (path:enjs:format path.binding)
  --
::
++  grad  %noun
--
