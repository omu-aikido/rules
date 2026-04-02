#let to-kanji(num) = {
  let d = ("〇", "一", "二", "三", "四", "五", "六", "七", "八", "九")
  if num < 10 { return d.at(num) } else if num < 20 {
    return "十" + if num - 10 > 0 { d.at(num - 10) } else { "" }
  } else if num < 100 {
    let t = calc.floor(num / 10)
    let o = calc.rem(num, 10)
    return d.at(t) + "十" + if o > 0 { d.at(o) } else { "" }
  } else { return str(num) }
}

// 条は章をまたいで通し番号にするため、独自カウンターを使用
#let article-counter = counter("article")

#let setup-document(
  title,
  organization: "大阪公立大学合氣道部",
  body,
) = {
  set page(
    paper: "a4",
    margin: (x: 18mm, y: 26mm),
    header: context [#h(1fr)［#title］],
    footer: context [
      #set text(size: 9.5pt)
      #align(center)[#counter(page).display("1 / 1")]
    ],
  )

  set text(font: "IPAexMincho", size: 10.5pt, fill: rgb("222"))
  set enum(numbering: n => pad(left: 1em)[#text[（#n）]])
  set document(title: text[#organization #title])
  set terms(indent: 1em)
  set heading(numbering: "1.1.1")

  show heading.where(level: 1): it => {
    set text(size: 10.5pt)
    align(center, it.body)
  }

  show heading.where(level: 2): it => {
    let nums = counter(heading).at(it.location())
    let n = nums.at(1)
    set text(size: 10.5pt)
    [#v(1em)第#to-kanji(n)章#h(1em)#it.body]
  }

  article-counter.update(0)

  show heading.where(level: 3): it => {
    article-counter.step()
    context {
      let n = article-counter.get().first()
      set text(size: 10.5pt)
      [#v(0.2em)#h(0.1em)（#it.body）#linebreak()第#to-kanji(n)条#h(0.8em)]
    }
  }

  show ref: it => context {
    let el = it.element
    if el != none and el.func() == heading {
      if el.level == 2 {
        let n = counter(heading).at(el.location()).at(1)
        [第#to-kanji(n)章]
      } else if el.level == 3 {
        let n = article-counter.at(el.location()).first() + 1
        [第#to-kanji(n)条]
      } else { it }
    } else { it }
  }

  body
}

#let additional(
  body,
) = {
  show heading.where(level: 2): it => {
    set text(size: 10.5pt)
    [#v(1em)#it.body]
  }

  show heading.where(level: 3): it => {
    context {
      set text(size: 10.5pt)
      [#v(0.2em)（#it.body）#linebreak()]
    }
  }

  body
}
