module PartialsHelper
  def textile_ref
    [
      'h1. This is a Heading 1',
      'h2. Heading 2 gets more specific',
      'bq. Some people like to use blockquote to',
      'To type *bold*',
      'To type _italics_',
      'To -modufy- +modify+ a phrase.',
      'f(x, n) = log ~4~ x ^n^',
      'Images !http://i.imgur.com/F7Sev.gif(Nyan nyan nyan)! Nyan Cat',
      'Learn more "about textile":http://redcloth.org/textile <- Links and links',
    ]
  end
end
