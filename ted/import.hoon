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
=/  files
  |-
  =+  .^(=arch %cy files-path)
  :: If there is no directory below this, read the file's contents
  ?:  (test dir.arch ~)
    =/  mark
    ?+  (rear files-path)  !!
      %md  wain
      %html  @t
      %css  @t
      %noun  noun
    ==
    =/  content  .^(mark %cx files-path)
    :-  [~ content] :: mimic fil.arch (unit item)
    (~(urn by dir.arch) |=([name=@ta ~] ^$(files-path (snoc files-path name))))
  :-  fil.arch  :: ~ or [~ u=item]
  (~(urn by dir.arch) |=([name=@ta ~] ^$(files-path (snoc files-path name))))

=/  all-files  ~(tap of files)
=/  files-import  :+
  published=*(map path [html=@t md=@t theme=@tas])
  drafts=*(map path md=@t)
  themes=*(map @tas css=@t)
=.  files-import
|-
?:  (test all-files ~)  files-import
%.  (rear all-files)
|=  [=path content=*]
%=  ^$
  all-files  (snip all-files)
  files-import
  ?+  (rear path)  files-import
    %md
      =+  content=(of-wain:format ((list cord) content))
      ?:  ?=(%published (snag 0 path))
        =/  file-name  (oust [0 2] (snip path))
        =/  file  (~(gut by published.files-import) file-name [html='' md='' theme=%default])
        files-import(published (~(put by published.files-import) file-name file(md content)))
      =/  draft-name  (oust [0 1] (snip path))
      =/  draft  (~(gut by drafts.files-import) draft-name [md=''])
      files-import(drafts (~(put by drafts.files-import) draft-name draft(md content)))
    %css
      =/  theme-name  (@tas (rear (oust [0 1] (snip path))))
      =/  theme  (~(gut by themes.files-import) theme-name [css=''])
      files-import(themes (~(put by themes.files-import) theme-name theme(css (@t (@tas content)))))
    %html
      =/  file-name  (oust [0 2] (snip path))
      =/  file  (~(gut by published.files-import) file-name [html='' md='' theme=%default])
      files-import(published (~(put by published.files-import) file-name file(html (@t (@tas content)))))
  ==
==
=/  cards  *(list card:agent:gall)
=/  themes-map  ;;  (map path @tas)  .^(noun %cx /(scot %p our)/blog/(scot %da now)/import/published/meta/noun)
=.  cards
;:  welp
  cards

  %+  turn  ~(tap by published.files-import)
  |=  [=path html=@t md=@t theme=@tas]
  [%pass /poke %agent [our %blog] %poke %blog-action !>([%publish path html md (~(gut by themes-map) path %default)])]

  %+  turn  ~(tap by drafts.files-import)
  |=  [=path md=@t]
  [%pass /poke %agent [our %blog] %poke %blog-action !>([%save-draft path md])]

  %+  turn  ~(tap by themes.files-import)
  |=  [theme=@tas css=@t]
  [%pass /poke %agent [our %blog] %poke %blog-action !>([%save-theme theme css])]

==
;<  ~  bind:m  (send-raw-cards cards)
(pure:m !>(~))