const { Brainfuck } = require('../src/index')

const Code = {
  'Brainfuck': '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.'
}

const File = {
  'Brainfuck': `${__dirname}/scripts/helloworld.bf`
}

Brainfuck.performance(Code.Brainfuck)
console.log(Brainfuck.toOok(Code.Brainfuck))
Brainfuck.runFile(File.Brainfuck)
