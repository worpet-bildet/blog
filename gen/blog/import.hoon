:-  %say
|=  [[now=@da @ our=@p ^] *]
=/  =path  /(scot %p our)/blog/(scot %da now)/import
:-  %blog-action
:-  %import
|-
=+  .^(=arch %cy path)
:: If there is no directory below this, read the file's contents
?:  (test dir.arch ~)
  =/  mark
  ?+  (rear path)  !!
    %md  wain
    %html  @t
    %css  @t
  ==
  =/  content  .^(mark %cx path)
  :-  [~ content] :: mimic fil.arch (unit item)
  (~(rut by dir.arch) |=([name=@ta ~] ^$(path (snoc path name))))
:-  fil.arch  :: ~ or [~ u=item]
(~(rut by dir.arch) |=([name=@ta ~] ^$(path (snoc path name))))
