class LibIME

  _element = null
  _directinput = no
  _num_up = 0
  _num_press = 0
  _except_keys = [8, 16, 17, 18, 91]

  onkeydown: -> return yes
  onkeypress: -> return yes
  onkeyup: -> return yes

  status: 0

  parse: (status) ->
    return '直接入力中' if status is 2
    return 'IME確定' if status is 1
    return 'IME入力中' if status is 0

  constructor: (expr) ->
    unless typeof expr is 'string'
      _element = expr
    else
      if jQuery?
        _element = ($ expr)
      else if document.querySelector?
        _element = document.querySelector expr
      else
        throw new Error 'expr isnt object'

    eventer = 'addEventListener'
    eventer = 'on' if jQuery?

    unless _element[eventer]?
      throw new Error 'invalid object or expr passed, must be jQuery/Raw DOM object'

    _element[eventer] 'keydown', (event) =>
      _directinput = no
      _num_press = 0
      _num_up = 0
      return @onkeydown arguments

    _element[eventer] 'keypress', (event) =>
      _directinput = yes
      _num_press += 1
      return @onkeypress arguments

    _element[eventer] 'keyup', (event) =>
      _num_up += 1
      if (_except_keys.indexOf event.keyCode) is -1
        if !_directinput and event.keyCode is 13
          @status = 1
        else if !_directinput and _num_press is 0
          @status = 0
        else
          @status = 2
      else
        @status = 2
      return @onkeyup arguments
