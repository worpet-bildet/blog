|%
+$  action
  $%  [%publish =path html=@t md=@t theme=@tas]
      [%unpublish =path]
      [%export ~]
      [%import files=(axal *)]
      [%save-draft =path md=@t]
      [%delete-draft =path]
      [%save-theme theme=@tas css=@t]
      [%delete-theme theme=@tas]
  ==
--