/-  blog
/+  dbug, default-agent, blog-lib=blog
::
%-  agent:dbug
^-  agent:gall
=>  |%
    +$  versioned-state  $%(state-0)
    +$  state-0  a=@
    --
=|  state-0
=*  state  -
=<
|_  bowl=bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    hc    ~(. +> bowl)
    card  card:agent:gall
++  on-init  `this
++  on-save  on-save:def
++  on-load  on-load:def
++  on-poke
  |=  [=mark =vase]
  ?>  =(%blog-action mark)
  =+  !<(act=action:blog vase)
  ?-    -.act
      %unbind-post :: TODO probably dont' need this
    :_  this
    [%pass /bind %arvo %e %disconnect `bind.act]~
  ::
      %save-file
    ~&  >  text.act
    ~&  >  file.act
    ::  /=blog=/blogs/...
    =*  file  [%posts file.act]
    =*  nor  `nori:clay`[%& [file %ins %html !>(text.act)]~]
    :_  this
    :~  [%pass / %arvo %c %info %blog nor]
        [%pass /serve %arvo %e %serve `file.act dap.bowl /gen/blog/hoon ~]
    ==
  ::
      %delete-file  :: TODO unbind here as well
    =*  nor  `nori:clay`[%& [file.act %del ~]~]
    [%pass / %arvo %c %info %blog nor]~^this
  ==
++  on-agent  on-agent:def
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>(?=([%http-response *] path) `this)
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  ~
  ::
      [%x %existing-bindings ~]
    =*  pax  /(scot %p our.bowl)/bindings/(scot %da now.bowl)
    :^  ~  ~  %bindings  !>
    .^((list [binding:eyre duct action:eyre]) %e pax)
  ::
      [%x %posts ~]
    =*  pax  /(scot %p our.bowl)/blog/(scot %da now.bowl)/blogs
    ``arch+!>((turn ~(tap by dir:.^(arch %cy pax)) head))
  ::
      [%x %content ^]
    :^  ~  ~  %html
    !>  ^-  cord
    %-  of-wain:format
    .^  wain
        %cx
        %+  weld
          /(scot %p our.bowl)/blog/(scot %da now.bowl)/blog
        t.t.path
    ==
  ::
  ==
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+    wire  (on-arvo:def wire sign-arvo)
      [%serve ~]
    ?>  ?=(%eyre -.sign-arvo)
    ?>  ?=(%bound +<.sign-arvo)
    ?-    accepted.sign-arvo
      %|  ~&(>>> "%blog: {<path.binding.sign-arvo>} failed bind" `this)
      %&  ~&("%blog: {<path.binding.sign-arvo>} successful bind" `this)
    ==
  ==
::
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--
::
|_  =bowl:gall
++  make-http-response
  |=  $:  paths=(list path)
          header=response-header:http
          data=octs
      ==
  ^-  (list card:agent:gall)
  :~  [%give %fact paths [%http-response-header !>(header)]]
      [%give %fact paths [%http-response-data !>(`data)]]
      [%give %kick paths ~]
  ==
--
