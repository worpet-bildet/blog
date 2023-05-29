/-  blog-paths, *blog
/+  default-agent, dbug, *sss, verb
=/  sub-paths  (mk-subs blog-paths ,[%paths ~])
::
|%
+$  card  card:agent:gall
--
%-  agent:dbug
%+  verb  &
^-  agent:gall
|_  =bowl:gall
+*  this      .
    default   ~(. (default-agent this %.n) bowl)
    da-paths  =/  da  (da blog-paths ,[%paths ~])
              (da sub-paths bowl -:!>(*result:da) -:!>(*from:da) -:!>(*fail:da))
++  on-init
  ^-  (quip card _this)
  `this
::
++  on-save   !>(sub-paths)
++  on-load
  |=  =vase
  :-  ~
  =/  old  !<(=_sub-paths vase)
  this(sub-paths sub-paths.old)
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark    `this
      %blog-sub
    =/  sub  !<([%sub =ship] vase)
    =^  cards  sub-paths  (surf:da-paths ship.sub %blog [%paths ~])
    [cards this]
    ::
      %sss-paths
    =^  cards  sub-paths  (apply:da-paths !<(into:da-paths (fled vase)))
    [cards this]
    ::
      %sss-on-rock
    ~&  >  "received!"
    `this
  ==
++  on-watch  on-watch:default
++  on-leave  on-leave:default
++  on-peek   on-peek:default
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card:agent:gall _this)
  ?>  ?=(%poke-ack -.sign)
  ?~  p.sign  `this
  %-  (slog u.p.sign)
  ?+    wire   `this
      [~ %sss %on-rock @ @ @ %paths ~]
    =.  sub-paths  (chit:da-paths |3:wire sign)
    `this
    ::
      [~ %sss %scry-request @ @ @ %paths ~]
    =^  cards  sub-paths  (tell:da-paths |3:wire sign)
    [cards this]
  ==
++  on-arvo
  |=  [=wire sign=sign-arvo]
  ^-  (quip card:agent:gall _this)
  ?+  wire  `this
    [~ %sss %behn @ @ @ %paths ~]  [(behn:da-paths |3:wire) this]
  ==
++  on-fail   on-fail:default
--
