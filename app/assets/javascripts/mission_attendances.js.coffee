extractNumber   = (node) ->
  if node.childNodes[0].nodeType == 1
    node.childNodes[0].getAttribute("data-number")

$ ->
  $('#mission_attendances').tablesorter
    sortList: [[0,0],[1,0]],
    textExtraction: extractNumber,
    headers:
      2: {sorter: false},
      3: {sorter: false}
