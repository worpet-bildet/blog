|%
++  name  %paths
+$  rock  (set path)
+$  wave
  $%  [%init paths=(set path)]
      [%post =path]
      [%depost =path]
  ==
++  wash
  |=  [=rock =wave]
  ?-  -.wave
    %init    paths.wave
    %post    (~(put in rock) path.wave)
    %depost  (~(del in rock) path.wave)
  ==
--