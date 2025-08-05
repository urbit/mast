|%
++  lineage
  |=  a=path
  ^-  (list path)  :: includes pax
  %+  turn  (gulf 0 (lent a))
  |=  n=@
  (scag n a)
++  ancestors
  |=  a=path
  ^-  (list path)  :: does not include pax
  %-  snip
  (lineage a)
++  is-ancestor
  |=  [a=path b=path]
  ^-  ?
  .=  b
  (scag (lent b) a)
++  split-content
  |=  content=@t
  ^-  [subject=tape body=wall]
  =/  lines  (to-wain:format content)
  ?~  lines  ["none" ~]
  [(trip i.lines) (turn t.lines trip)]
++  cite-as-planet
  |=  who=@p
  ^-  tape
  =+  (cite:title who)
  ;:  welp
    (scag 7 -)
    "-"
    (slag 8 -)
  ==
--