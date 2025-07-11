" Colorscheme generated by https://github.com/arcticlimer/djanho
highlight clear

function s:highlight(group, bg, fg, style)
  let gui = a:style == '' ? '' : 'gui=' . a:style
  let fg = a:fg == '' ? '' : 'guifg=' . a:fg
  let bg = a:bg == '' ? '' : 'guibg=' . a:bg
  exec 'hi ' . a:group . ' ' . bg . ' ' . fg  . ' ' . gui
endfunction

let s:Color7 = '#614242'
let s:Color2 = '#9BD4B2'
let s:Color6 = '#505333'
let s:Color4 = '#131313'
let s:Color10 = '#6c6c6c'
let s:Color5 = '#e0e0e0'
let s:Color0 = '#6A6A6A'
let s:Color1 = '#90AED3'
let s:Color3 = '#CEB0D3'
let s:Color8 = '#353535'
let s:Color9 = '#333333'

call s:highlight('Comment', '', s:Color0, '')
call s:highlight('String', '', s:Color1, '')
call s:highlight('Number', '', s:Color1, '')
call s:highlight('Keyword', '', s:Color2, '')
call s:highlight('Type', '', s:Color3, '')
call s:highlight('StatusLine', s:Color5, s:Color4, '')
call s:highlight('WildMenu', s:Color4, s:Color5, '')
call s:highlight('Pmenu', s:Color4, s:Color5, '')
call s:highlight('PmenuSel', s:Color5, s:Color4, '')
call s:highlight('PmenuThumb', s:Color4, s:Color5, '')
call s:highlight('DiffAdd', s:Color6, '', '')
call s:highlight('DiffDelete', s:Color7, '', '')
call s:highlight('Normal', s:Color4, s:Color5, '')
call s:highlight('Visual', s:Color8, '', '')
call s:highlight('CursorLine', s:Color8, '', '')
call s:highlight('ColorColumn', s:Color8, '', '')
call s:highlight('SignColumn', s:Color4, '', '')
call s:highlight('LineNr', '', s:Color9, '')
call s:highlight('TabLine', s:Color4, s:Color10, '')
call s:highlight('TabLineSel', s:Color5, s:Color4, '')
call s:highlight('TabLineFill', s:Color4, s:Color10, '')
call s:highlight('TSPunctDelimiter', '', s:Color5, '')

highlight! link TSString String
highlight! link TSConditional Conditional
highlight! link TSComment Comment
highlight! link TSPunctSpecial TSPunctDelimiter
highlight! link TSFunction Function
highlight! link TSTag MyTag
highlight! link TSTagDelimiter Type
highlight! link TSKeyword Keyword
highlight! link Repeat Conditional
highlight! link TSConstBuiltin TSVariableBuiltin
highlight! link TelescopeNormal Normal
highlight! link TSFuncMacro Macro
highlight! link TSFloat Number
highlight! link TSField Constant
highlight! link TSNamespace TSType
highlight! link Operator Keyword
highlight! link TSPunctBracket MyTag
highlight! link Whitespace Comment
highlight! link TSOperator Operator
highlight! link TSParameterReference TSParameter
highlight! link TSNumber Number
highlight! link TSRepeat Repeat
highlight! link TSType Type
highlight! link TSProperty TSField
highlight! link TSConstant Constant
highlight! link TSLabel Type
highlight! link NonText Comment
highlight! link Folded Comment
highlight! link Macro Function
highlight! link Conditional Operator
highlight! link TSParameter Constant
highlight! link CursorLineNr Identifier
