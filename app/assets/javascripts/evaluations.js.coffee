extractNumber   = (node) ->
  node.childNodes[0].getAttribute("data-number")

$ ->
  $('#evaluations').tablesorter
    sortList: [[0,0],[1,0],[2,0]],
    textExtraction: extractNumber,
    headers: {3: {sorter: false}}
