|%
+$  action
  $%  [%save-file =path html=@t md=@t] :: TODO needs to be text and md
      [%delete-file =path]
      [%save-draft name=term md=@t]
      [%delete-draft name=term]
  ==
--