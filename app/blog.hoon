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
    --
=|  state-2
=*  state  -
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    card  card:agent:gall
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
    :_  this
    %+  turn  ~(tap by files.old)
    |=  [=path *]
    [%pass /bind %arvo %e %connect `path dap.bowl]
  ==
::
++  on-poke
  |=  [=mark =vase]
  |^
  ?+    mark  (on-poke:def mark vase)
      %handle-http-request
    (handle-http-request bowl !<([@tas inbound-request:eyre] vase))
  ::
      %blog-action
    (handle-action bowl !<(act=action:blog vase))
  ==
  ::
  ++  handle-http-request
    |=  [=bowl:gall rid=@tas req=inbound-request:eyre]
    ^-  (quip card _this)
    =/  url-len  (met 3 url.request.req)
    ?:  =('.md' (cut 3 [(sub url-len 3) 3] url.request.req)) :: get MARKDOWN
      =/  file  (rash (end [3 (sub url-len 3)] url.request.req) stap)
      :_  this
      %^    http-response-cards:blog-lib
          rid
        [200 ['Content-Type' 'text/plain; charset=utf-8']~]
      `(as-octs:mimes:html md:(~(got by files) file))
    ::
    =?  url.request.req  =('.html' (cut 3 [(sub url-len 5) 5] url.request.req))
      (end [3 (sub url-len 5)] url.request.req)
    =/  file   (~(got by files) (rash url.request.req stap))
    =/  theme  ?~(got=(~(get by themes) theme.file) '' u.got)
    =/  post-with-style
      (cat 3 html:file (add-style:blog-lib theme))
    :_  this
    %^    http-response-cards:blog-lib
        rid
      [200 ['Content-Type' 'text/html; charset=utf-8']~]
    `(as-octs:mimes:html post-with-style)
  ::
  ++  handle-action
    |=  [=bowl:gall act=action:blog]
    ^-  (quip card _this)
    ?>  =(src.bowl our.bowl)
    ?-    -.act
        %publish
      :_  this(files (~(put by files) [path html md theme]:act))
      [%pass /bind %arvo %e %connect `path.act dap.bowl]~
    ::
        %unpublish
      :_  this(files (~(del by files) path.act))
      [%pass /bind %arvo %e %disconnect `path.act]~
    ::
        %export
      =/  theme-export=(map path @tas)
        (~(urn by files) |=([* * * theme=@tas] theme))
      =/  soba-meta=soba:clay
        ^-  soba:clay
        [[%export %published %meta %noun ~] [%ins %noun !>(theme-export)]]~
      =/  soba-html=soba:clay
        %-  zing
        %+  turn  ~(tap by files)
        |=  [=path html=@t md=@t theme=@tas]
        ^-  soba:clay
        =/  t  ?~(got=(~(get by themes) theme) '' u.got)
        :~  :^  [%export %published %html (snoc path %html)]
              %ins  %html
            ?:  css.act
              !>((cat 3 html (add-style:blog-lib t)))
            !>(html)
            ::
            :^  [%export %published %md (snoc path %md)]
              %ins  %md
            !>([md ~])
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
        [[%export %themes (snoc [theme]~ %css)] %ins %css !>(css)]
      :_  this
      :~  [%pass /info %arvo %c %info %blog %& soba-html]
          [%pass /info %arvo %c %info %blog %& soba-md]
          [%pass /info %arvo %c %info %blog %& soba-css]
          [%pass /info %arvo %c %info %blog %& soba-meta]
      ==
    ::
      %save-draft  `this(drafts (~(put by drafts) [path md]:act))
      %delete-draft  `this(drafts (~(del by drafts) path.act))
      %save-theme    `this(themes (~(put by themes) [theme css]:act))
      %delete-theme  `this(themes (~(del by themes) theme.act))
    ==
  --
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
