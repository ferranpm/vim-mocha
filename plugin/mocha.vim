command! -nargs=0 MochaTest call mocha#RunTest(0)
command! -nargs=0 MochaDescription call mocha#RunDescription(0)
command! -nargs=0 MochaTestDebug call mocha#RunTest(1)
command! -nargs=0 MochaDescriptionDebug call mocha#RunDescription(1)

command! -nargs=0 MochaRunLast call mocha#RunLast(0)
command! -nargs=0 MochaRunLastDebug call mocha#RunLast(1)
