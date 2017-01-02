App.HumanizeHelper = Em.Helper.helper (params)->
  lower = params[0].toLowerCase().trim().split ''
  for char, i in lower
    if /[a-z]/.test char
      lower[i] = char.toUpperCase()
      break
  lower.join ''
