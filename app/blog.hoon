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
++  on-init  on-init:def
++  on-save  on-save:def
++  on-load  on-load:def
++  on-poke
  |=  [=mark =vase]
  ?>  =(%blog-action mark)
  =+  !<(act=action:blog vase)
  ?-    -.act
      %save-file
    =*  file  [%posts file.act]
    =*  nor  `nori:clay`[%& [file %ins %html !>(text.act)]~]
    :_  this
    :~  [%pass / %arvo %c %info %blog nor]
        [%pass /serve %arvo %e %serve `file.act dap.bowl /gen/blog/hoon ~]
    ==
  ::
      %delete-file
    =*  nor  `nori:clay`[%& [file.act %del ~]~]
    :_  this
    :~  [%pass / %arvo %c %info %blog nor]
        [%pass /serve %arvo %e %disconnect `file.act]
    ==
  ==
++  on-agent  on-agent:def
++  on-watch  on-watch:def
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
      [%x %md *]
    :: TODO need to put/scry out actual md files
    :^  ~  ~  %md
    !>(['# %studio test file' ~])
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
