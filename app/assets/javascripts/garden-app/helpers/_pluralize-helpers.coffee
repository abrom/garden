App.PluralizeHelper = Em.Helper.helper (params)-> if params[0] == 1 then params[1] else params[2]
