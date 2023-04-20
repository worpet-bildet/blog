:-  %say
|=  *
[%blog-action %import ~]


:: |-
:: :: IF we are done with all the files, return: (pure:m !>(~))
:: :: ELSE, construct the next poke, and poke like this, see below
:: ;< ~ bind:m (poke-our %blog !>([%publish path html md theme]))

