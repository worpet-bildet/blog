/-  blog
/+  blog-lib=blog, dbug, default-agent
::
%-  agent:dbug
^-  agent:gall
=>  |%
    +$  versioned-state
      $%  state-1
          state-2
      ==
    +$  state-1
      $:  %1
          files=(map path (pair html=@t md=@t))
          drafts=(map path md=@t)
      ==
    +$  state-2
      $:  %2
          files=(map path [html=@t md=@t theme=@tas])
          drafts=(map path md=@t)
          themes=(map @tas css=@t)
      ==
    +$  card  $+(card card:agent:gall)
    --
=|  state-2
=*  state  -
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
++  on-init
  ^-  (quip card _this)
  `this(themes (~(gas by themes) [%default default-theme:blog-lib]~))
++  on-save  !>(state)
++  on-load
  |=  =vase
  ^-  (quip card _this)
  =+  !<(old=versioned-state vase)
  ?-    -.old
      %1
    :-  %-  zing
        %+  turn  ~(tap by files.old)
        |=  [=path *]
        :~  [%pass /bind %arvo %e %disconnect `path]
            [%pass /bind %arvo %e %connect `path dap.bowl]
        ==
    %=    this
        state
      :^    %2
          (~(urn by files.old) |=([=path html=@t md=@t] [html md %none]))
        drafts.old
      (~(gas by *(map @tas @t)) [%default default-theme:blog-lib]~)
    ==
  ::
      %2
    :_  this(state old)
    %-  zing
    %+  turn  ~(tap by files.old)
    |=  [=path html=@t md=@t theme=@tas]
    :~  [%pass /bind %arvo %e %disconnect `path]
        :*  %pass  /bind  %arvo  %e
            %set-response  (spat path)
            ~  %.n  %payload
            [200 ['Content-Type' 'text/html; charset=utf-8']~]
            =/  tem=@t  (~(gut by themes.old) theme '')
            `(as-octs:mimes:^html (cat 3 html (add-style:blog-lib tem)))
        ==
        :*  %pass  /bind  %arvo  %e
            %set-response  (cat 3 (spat path) '.md')
            ~  %.n  %payload
            [200 ['Content-Type' 'text/plain; charset=utf-8']~]
            `(as-octs:mimes:^html md)
    ==  ==
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ~|  "unexpected poke to {<dap.bowl>} with mark {<mark>}"
  ?>  =(%blog-action mark)
  =+  !<(act=action:blog vase)
  ?>  =(src.bowl our.bowl)
  ?-    -.act
      %publish
    :_  this(files (~(put by files) [path html md theme]:act))
    :~  :*  %pass  /bind  %arvo  %e
            %set-response  (cat 3 (spat path.act) '.md')
            ~  %.n  %payload
            [200 ['Content-Type' 'text/plain; charset=utf-8']~]
            `(as-octs:mimes:html md.act)
        ==
    
        :*  %pass  /bind  %arvo  %e
            %set-response  (spat path.act)
            ~  %.n  %payload
            [200 ['Content-Type' 'text/html; charset=utf-8']~]
            =/  tem=@t  (~(gut by themes) theme.act '')
            `(as-octs:mimes:html (cat 3 html.act (add-style:blog-lib tem)))
    ==  ==
  ::
      %unpublish
    :_  this(files (~(del by files) path.act))
    :~  [%pass /bind %arvo %e %set-response `@t`(cat 3 (spat path.act) '.md') ~]
        [%pass /bind %arvo %e %set-response (spat path.act) ~]
    ==
  ::
      %export
    =/  soba-html=soba:clay
      %-  zing
      %+  turn  ~(tap by files)
      |=  [=path html=@t md=@t theme=@tas]
      ^-  soba:clay
      =/  tem  (~(gut by themes) theme '')
      :~  :-  [%export %published %html (snoc path %html)]
          [%ins %html !>((cat 3 html (add-style:blog-lib tem)))]
      ::
          :-  [%export %published %md (snoc path %md)]
          [%ins %md !>([md ~])]
      ==
    =/  soba-md=soba:clay
      %+  turn  ~(tap by drafts)
      |=  [=path md=@t]
      ^-  (pair ^path miso:clay)
      [[%export %drafts (snoc path %md)] %ins %md !>([md ~])]
    =/  soba-css=soba:clay
      %+  turn  ~(tap by themes)
      |=  [theme=@tas css=@t]
      ^-  (pair path miso:clay)
      [[%export %themes theme %css ~] %ins %css !>(css)]
    :_  this
    :~  [%pass /info %arvo %c %info %blog %& soba-html]
        [%pass /info %arvo %c %info %blog %& soba-md]
        [%pass /info %arvo %c %info %blog %& soba-css]
    ==
  ::
    %save-draft    `this(drafts (~(put by drafts) [path md]:act))
    %delete-draft  `this(drafts (~(del by drafts) path.act))
    %save-theme    `this(themes (~(put by themes) [theme css]:act))
    %delete-theme  `this(themes (~(del by themes) theme.act))
  ==
::
++  on-agent  on-agent:def
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>  ?=([%http-response *] path)
  `this
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  ~&  "unexpected scry into {<dap.bowl>} on path {<path>}"  ~
  ::
      [%x %md ^]       ``blog+!>(+<:(~(got by files) t.t.path)) :: TODO bad practice
      [%x %html ^]     ``blog+!>(-:(~(got by files) t.t.path))
      [%x %draft ^]    ``blog+!>((~(got by drafts) t.t.path))
      [%x %theme @ ~]  ``blog+!>((~(got by themes) i.t.t.path))
  ::
      [%x %pages ~]
    =;  pages  ``json+!>([%a pages])
    (turn ~(tap by files) |=([=^path *] (path:enjs:format path)))
  ::
      [%x %drafts ~]
    =;  names  ``json+!>([%a names])
    (turn ~(tap by drafts) |=([=^path *] (path:enjs:format path)))
  ::
      [%x %themes ~]
    =;  themes  ``json+!>([%a themes])
    (turn ~(tap by themes) |=([t=@tas *] s+t))
  ::
      [%x %active-theme ^]
    =;  theme  ``json+!>(s+theme)
    theme:(~(got by files) t.t.path)
  ::
      [%x %all-bindings ~]
    =;  the-thing  ``json+!>(the-thing)
    %-  pairs:enjs:format
    %+  turn
      .^  (list [binding:eyre * action:eyre])  %e
          /(scot %p our.bowl)/bindings/(scot %da now.bowl)
      ==
    |=  [=binding:eyre * =action:eyre]
    ^-  [@t json]
    :-  (spat path.binding)
    ?-  -.action
      %gen             [%s (crip "desk: {<desk.generator.action>}")]
      %app             [%s (crip "app: {<app.action>}")]
      %authentication  [%s '%authentication']
      %logout          [%s '%logout']
      %channel         [%s '%channel']
      %scry            [%s '%scry']
      %name            [%s '%name']
      %four-oh-four    [%s '%four-oh-four']
    ==
  ==
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+  wire  (on-arvo:def wire sign-arvo)
    [%bind ~]  ?>(?=([%eyre %bound %.y *] sign-arvo) `this)
  ==
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--
