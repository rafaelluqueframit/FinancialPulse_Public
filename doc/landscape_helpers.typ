#let landscape_page(body, margin: 2cm) = {
  pagebreak()
  set page(width: 29.7cm, height: 21cm, margin: margin)
  body
  set page(
    width: 21cm,
    height: 29.7cm,
    margin: (
      left: 3cm,
      right: 3cm,
      top: 5cm,
      bottom: 5cm,
    ),
  )
  pagebreak()
}
