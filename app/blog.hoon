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
    +$  state-0  (map path (pair html=@t md=@t))
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
  `this(themes (~(put by themes) %default default-theme:blog-lib))
++  on-save  !>(state)
++  on-load
  |=  =vase 
  ^-  (quip card _this)
  :: this is super messed up because state-0 wasn't tagged with %0
  :: for later updates need to add %2, %3, etc. on -.q.vase
  ?:  &(?=(^ q.vase) =(-.q.vase %0))
      =+  !<(old=state-0 vase)
      =/  new=state-2
        :^    %2
            (~(urn by old) |=([=path html=@t md=@t] [html md %default]))
          ~
        (~(gas by *(map @tas @t)) [%default default-theme:blog-lib]~)
      :_  this(state new)
      %-  zing
      %+  turn  ~(tap by old)
      |=  [=path *]
      :-  [%pass /bind %arvo %e %disconnect `path]
      [%pass /bind %arvo %e %connect `path dap.bowl]~
  ::
  =+  !<(old=versioned-state vase)
  ?-  -.old
    %1
  =/  new=state-2
    :^    %2
        (~(urn by files.old) |=([=path html=@t md=@t] [html md %default]))
      drafts.old
    (~(gas by *(map @tas @t)) [%default default-theme:blog-lib]~)
  :_  this(state new)
  %-  zing
  %+  turn  ~(tap by files.old)
  |=  [=path *]
  :-  [%pass /bind %arvo %e %disconnect `path]
  [%pass /bind %arvo %e %connect `path dap.bowl]~
  ::
    %2  `this(state old)
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
    =/  got  (~(got by files) (rash url.request.req stap))
    :_  this
    %^    http-response-cards:blog-lib
        rid
      [200 ['Content-Type' 'text/html; charset=utf-8']~]
    %-  some
    %-  as-octs:mimes:html
    %-  crip
    %+  weld
      (trip html.got)
    (add-style:blog-lib (~(got by themes) theme.got)) 
  ::
  ++  handle-action
    |=  [=bowl:gall act=action:blog]
    ^-  (quip card _this)
    ?-    -.act
        %publish
      :_  this(files (~(put by files) [path html md theme]:act))
      [%pass /bind %arvo %e %connect `path.act dap.bowl]~
    ::
        %unpublish
      :_  this(files (~(del by files) path.act))
      [%pass /bind %arvo %e %disconnect `path.act]~
    ::
      %save-draft    `this(drafts (~(put by drafts) [path md]:act))
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
  ?+    path  ~
  ::
      [%x %md ^]       ``blog+!>(+<:(~(got by files) t.t.path))
      [%x %html ^]     ``blog+!>(-:(~(got by files) t.t.path))
      [%x %draft ^]    ``blog+!>((~(got by drafts) t.t.path))
      [%x %theme @ ~]  ``noun+!>((~(got by themes) i.t.t.path))
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
    ?+  -.action  [%s 'unknown']
      %gen             [%s (crip "desk: {<desk.generator.action>}")]
      %app             [%s (crip "app: {<app.action>}")]
      %authentication  [%s '%authentication']
      %logout          [%s '%logout']
      %channel         [%s '%channel']
      %scry            [%s '%scry']
      :: %name            [%s '%name'] :: TODO next release
      :: %four-oh-four    [%s '%four-oh-four']
    ==
  ==
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+  wire  (on-arvo:def wire sign-arvo)
    [%bind ~]  ~&  >  sign-arvo  ?>(?=([%eyre %bound %.y *] sign-arvo) `this)
  ==
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--
