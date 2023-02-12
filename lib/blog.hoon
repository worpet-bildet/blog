|%
++  template
  |=  $:  paths=(list path)
          header=response-header:http
          data=octs
      ==
  :~  [%give %fact paths %http-resposne-header !>(header)]
      [%give %fact paths %http-response-data !>(`data)]
      [%give %kick paths ~]
  ==
--