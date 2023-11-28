#NoEnv
#SingleInstance, force
#NoTrayIcon
#Include %A_ScriptDir%\..\export.ahk
SetBatchLines, -1

Class CustomError {
  
}

; to test .toThrow() matcher
createError() {
  Throw, "Error"
}

createCustomError() {
  Throw new CustomError()
}

createNoError() {
}

assert := new unittesting()

assert.group(".test")
assert.label("vars, arrays, objects")
assert.test("hello", "hello")
assert.test(["hello"], ["hello"])
assert.test({"key": "value"}, {"key": "value"})


assert.group(".equal")
assert.label("vars, arrays, objects")
assert.equal("hello", "hello")
assert.equal(["hello"], ["hello"])
assert.equal({"key": "value"}, {"key": "value"})


assert.group(".notEqual")
assert.label("vars, arrays, objects")
assert.notEqual("hello", "Hello")
assert.notEqual(["hello"], ["world"])
; assert.notEqual({"key": "value"}, {"key": "differentValue"})
assert.notEqual({"key": "value"}, {"key": "differentValue"})


assert.group(".toThrow")
assert.label("function throwing error")
assert.toThrow(func("createError"))

assert.label("function throwing error of type CustomError")
assert.toThrow(func("createCustomError"), "CustomError")

assert2 := new unittesting()
assert.label("function not throwing error")
assert2.toThrow(func("createNoError"))
assert.test(assert2.failTotal, 1)

assert.label("function throwing 'CustomError', expecting 'TypeError'")
assert2.toThrow(func("createCustomError"), "TypeError")
assert.test(assert2.failTotal, 2)

assert.label("function throwing error string, expecting 'TypeError'")
assert2.toThrow(func("createError"), "TypeError")
assert.test(assert2.failTotal, 3)
assert2.sendReportToDebugConsole()
; OutputDebug, % "`n"


assert.group(".true")
assert.label("vars")
assert.true(true)
assert.true(1)
assert.label("expressions")
assert.true((1 == 1))
assert.true((1 != 0))
assert.label("Function")
assert.true(inStr("String", "s"))


assert.group(".false")
assert.label("vars")
assert.false(false)
assert.false(0)
assert.label("expressions")
assert.false((1 == 0))
assert.false((1 != 1))

; wrap up
assert.writeResultsToFile()
; assert.fullReport()
assert.sendReportToDebugConsole()
ExitApp
