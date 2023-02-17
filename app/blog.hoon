/-  blog
/+  dbug, default-agent
::
%-  agent:dbug
^-  agent:gall
=>  |%
    +$  versioned-state
      $%  state-1
      ==
    +$  state-0  (map path (pair html=@t md=@t))
    +$  state-1
      $:  %1
          files=(map path (pair html=@t md=@t))
          drafts=(map path md=@t)
      ==
    --
=|  state-1
=*  state  -
|_  bowl=bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    card  card:agent:gall
++  on-init  on-init:def
++  on-save  !>(state)
++  on-load
  |=  =vase 
  ^-  (quip card _this)
  :: this is super messed up because state-0 wasn't tagged with %0
  :: for later updates need to add %2, %3, etc. on -.q.vase
  ?.  &(?=(^ q.vase) =(-.q.vase %1))
      =+  !<(old=state-0 vase)
      `this(state [%1 old ~])
  =+  !<(old=versioned-state vase)
  ?-  -.old
    %1  `this(state old)
  ==
::
++  on-poke
  |=  [=mark =vase]
  ?>  =(%blog-action mark)
  =+  !<(act=action:blog vase)
  ?-    -.act
      %publish
    :_  this(files (~(put by files) [path html md]:act))
    [%pass /bind %arvo %e %serve `path.act dap.bowl /gen/blog/hoon ~]~
  ::
      %unpublish
    :_  this(files (~(del by files) path.act))
    [%pass /bind %arvo %e %disconnect `path.act]~
  ::
      %save-draft  
    `this(drafts (~(put by drafts) [path md]:act))
  ::
      %delete-draft
    `this(drafts (~(del by drafts) path.act))
  ==
++  on-agent  on-agent:def
++  on-watch  on-watch:def
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  ~
  ::
      [%x %md ^]     ``blog+!>(q:(~(got by files) t.t.path))
      [%x %html ^]   ``blog+!>(p:(~(got by files) t.t.path))
      [%x %draft ^]  ``blog+!>((~(got by drafts) t.t.path))
  ::
      [%x %pages ~]
    =;  pages  ``json+!>([%a pages])
    (turn ~(tap by files) |=([=^path *] (path:enjs:format path)))
  ::
      [%x %drafts ~]
    =;  names  ``json+!>([%a names])
    (turn ~(tap by drafts) |=([=^path *] (path:enjs:format path)))
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
