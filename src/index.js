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
    return code
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
    this.reload(code)
    return this.interpret()
  }

  runFile (file) {
    var code = require('fs').readFileSync(file, 'utf-8', function (err, data) {
      if (err) throw err
    })
    return this.run(code)
  }

  performance (code) {
    this.reload(code)
    console.time('Compiled in')
    this.interpret()
    console.timeEnd('Compiled in')
  }

  toOok (code) {
    // TODO: Code or file with code
    return this.clean(code)
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

module.exports = {
  Brainfuck: new Brainfuck()
}
