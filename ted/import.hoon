/-  spider, blog
/+  *strandio
=,  strand=strand:spider
=,  strand-fail=strand-fail:libstrand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
;<  our=@p  bind:m  get-our
;<  now=@da  bind:m  get-time
=/  files-path=path  /(scot %p our)/blog/(scot %da now)/import
=/  files=(axal *)
  |-
  =+  .^(=arch %cy files-path)
  ?:  (test dir.arch ~)
    =/  mark
    ?+  (rear files-path)  !!
      %md  wain
      %html  @t
      %css  @t
      %noun  noun
    ==
    =/  content  .^(mark %cx files-path)
    :-  [~ content]
    (~(urn by dir.arch) |=([name=@ta ~] ^$(files-path (snoc files-path name))))
  :-  fil.arch
  (~(urn by dir.arch) |=([name=@ta ~] ^$(files-path (snoc files-path name))))

=/  all-files  ~(tap of files)
=/  imp  :+
  pub=*(map path [html=@t md=@t theme=@tas])
  dra=*(map path md=@t)
  thm=*(map @tas css=@t)
=.  imp
|-
?:  =(all-files ~)  imp
%.  (rear all-files)
|=  [=path content=*]
%=  ^$
  all-files  (snip all-files)
  imp
  ?+  (rear path)  imp
      %md
    =+  content=(of-wain:format ((list cord) content))
    ?:  ?=(%published (snag 0 path))
      =/  file-name  (oust [0 2] (snip path))
      =/  file  (~(gut by pub.imp) file-name [html='' md='' theme=%default])
      imp(pub (~(put by pub.imp) file-name file(md content)))
    =/  draft-name  (oust [0 1] (snip path))
    =/  draft  (~(gut by dra.imp) draft-name [md=''])
    imp(dra (~(put by dra.imp) draft-name draft(md content)))
      %css
    =/  theme-name  (@tas (rear (oust [0 1] (snip path))))
    =/  theme  (~(gut by thm.imp) theme-name [css=''])
    imp(thm (~(put by thm.imp) theme-name theme(css (@t (@tas content)))))
      %html
    =/  file-name  (oust [0 2] (snip path))
    =/  file  (~(gut by pub.imp) file-name [html='' md='' theme=%default])
    imp(pub (~(put by pub.imp) file-name file(html (@t (@tas content)))))
  ==
==
=|  cards=(list card:agent:gall)
=/  thm-map  ;;  (map path @tas)
  .^(noun %cx /(scot %p our)/blog/(scot %da now)/import/published/meta/noun)
=/  act
  :~  %pass
      /poke
      %agent
      [our %blog]
      %poke
      %blog-action
  ==
=.  cards
;:  welp
  cards

  %+  turn  ~(tap by pub.imp)
  |=  [=path html=@t md=@t theme=@tas]
  (welp act !>([%publish path html md (~(gut by thm-map) path %default)]))

  %+  turn  ~(tap by dra.imp)
  |=  [=path md=@t]
  (welp act !>([%save-draft path md]))

  %+  turn  ~(tap by thm.imp)
  |=  [theme=@tas css=@t]
  (welp act !>([%save-theme theme css]))

==
;<  ~  bind:m  (send-raw-cards cards)
(pure:m !>(~))