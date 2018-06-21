'use strict'
class Brainfuck {
  constructor () {
    this.reload()
  }

  reload (code, args) {
    this.code = code || ''
    this.argv = args || ''

    this.stdout = ''

    this.argc = 0
    this.index = 0
    this.instruction_pointer = 0

    this.stack = []
    this.memory = []

    this.memory[0] = 0
  }

  clean (code) {
    let __code = code || this.code
    return __code
      .replace(new RegExp('[^\\>\\<\\[\\]\\+\\-\\.\\,]', 'g'), '')
  }

  parse (cmd) {
    switch (cmd) {
      case '>': this.index++; if (!this.memory[this.index]) this.memory[this.index] = 0; break
      case '<': this.index--; if (!this.memory[this.index]) this.memory[this.index] = 0; break
      case '+': this.memory[this.index] = (this.memory[this.index] === 255) ? 0 : this.memory[this.index] + 1; break
      case '-': this.memory[this.index] = (this.memory[this.index] === 0) ? 255 : this.memory[this.index] - 1; break
      case '.': this.stdout += String.fromCharCode(this.memory[this.index]); break
      case ',': if (this.argv) {
        if (Number.isInteger(this.argv[this.argc]) && this.argv[this.argc] >= 0 && this.argv[this.argc] <= 255) { this.memory[this.index] = this.argv[this.argc] }
        this.argc++
      } break
      case '[': this.stack.push(this.instruction_pointer); break
      case ']': if (this.memory[this.index] === 0) this.stack.pop(); else this.instruction_pointer = this.stack[this.stack.length - 1]; break
    }
  }

  interpret () {
    while (this.instruction_pointer < this.code.length) {
      this.parse(this.code[this.instruction_pointer])
      this.instruction_pointer++
    }
    return this.stdout
  }

  run (code) {
    let __code = code || this.code
    this.reload(this.clean(__code))
    return this.interpret()
  }

  runFile (file) {
    let __code = require('fs').readFileSync(file, 'utf-8', function (err, data) {
      if (err) throw err
    })
    return this.run(__code)
  }

  performance (code) {
    if (code) this.reload(code)
    console.time('Compiled in')
    this.interpret()
    console.timeEnd('Compiled in')
  }

  toOok (code) {
    // TODO: Code or file with code
    let __code = code || this.code
    return this.clean(__code)
      .replace(new RegExp('\\.', 'g'), 'Ook! Ook. ')
      .replace(new RegExp('\\,', 'g'), 'Ook. Ook! ')
      .replace(new RegExp('\\>', 'g'), 'Ook. Ook? ')
      .replace(new RegExp('\\<', 'g'), 'Ook? Ook. ')
      .replace(new RegExp('\\[', 'g'), 'Ook! Ook? ')
      .replace(new RegExp('\\]', 'g'), 'Ook? Ook! ')
      .replace(new RegExp('\\+', 'g'), 'Ook. Ook. ')
      .replace(new RegExp('\\-', 'g'), 'Ook! Ook! ')
      .trim()
  }
}

class Ook {
  constructor () {
    this.reload()
  }

  reload (code, args) {
    this.code = code || ''
    this.argv = args || ''

    this.stdout = ''

    this.argc = 0
    this.index = 0
    this.instruction_pointer = 0

    this.stack = []
    this.memory = []

    this.memory[0] = 0
  }

  clean (code) {
    let __code = code || this.code
    return __code
      .match(new RegExp('Ook[.!?] Ook[.!?]', 'g')).join(' ').trim()
  }

  minify (code) {
    let __code = code || this.code
    return this.clean(__code)
      .replace(new RegExp(' ', 'g'), '')
      .replace(new RegExp('Ook', 'g'), '')
  }

  parse (cmd) {
    switch (cmd) {
      case '.?': this.index++; if (!this.memory[this.index]) this.memory[this.index] = 0; break
      case '?.': this.index--; if (!this.memory[this.index]) this.memory[this.index] = 0; break
      case '..': this.memory[this.index] = (this.memory[this.index] === 255) ? 0 : this.memory[this.index] + 1; break
      case '!!': this.memory[this.index] = (this.memory[this.index] === 0) ? 255 : this.memory[this.index] - 1; break
      case '!.': this.stdout += String.fromCharCode(this.memory[this.index]); break
      case '.!': if (this.argv) {
        if (Number.isInteger(this.argv[this.argc]) && this.argv[this.argc] >= 0 && this.argv[this.argc] <= 255) { this.memory[this.index] = this.argv[this.argc] }
        this.argc++
      } break
      case '!?': this.stack.push(this.instruction_pointer); break
      case '?!': if (this.memory[this.index] === 0) this.stack.pop(); else this.instruction_pointer = this.stack[this.stack.length - 1]; break
    }
  }

  interpret () {
    let __code = this.code.match(new RegExp('[.!?]{2}', 'g'))
    while (this.instruction_pointer < __code.length) {
      this.parse(__code[this.instruction_pointer])
      this.instruction_pointer++
    }
    return this.stdout
  }

  run (code) {
    let __code = code || this.code
    this.reload(this.minify(this.clean(__code)))
    return this.interpret()
  }

  runFile (file) {
    let __code = require('fs').readFileSync(file, 'utf-8', function (err, data) {
      if (err) throw err
    })
    return this.run(__code)
  }

  performance (code) {
    if (code) this.reload(this.minify(this.clean(code)))
    console.time('Compiled in')
    this.interpret()
    console.timeEnd('Compiled in')
  }

  toBrainfuck (code) {
    let __code = this.minify(code) || this.code
    let cmds = __code
      .match(new RegExp('[.!?]{2}', 'g'))
    for (let i in cmds) {
      switch (cmds[i]) {
        case '..': cmds[i] = '+'; break
        case '.!': cmds[i] = ','; break
        case '.?': cmds[i] = '>'; break
        case '!.': cmds[i] = '.'; break
        case '!!': cmds[i] = '-'; break
        case '!?': cmds[i] = '['; break
        case '?.': cmds[i] = '<'; break
        case '?!': cmds[i] = ']'; break
        default: cmds[i] = ''
      }
    }
    return (cmds !== null) ? cmds.join('') : this
  }
}

module.exports = {
  Ook: new Ook(),
  Brainfuck: new Brainfuck()
}
