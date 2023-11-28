#Include "..\export.ahk"

Class CustomError {
  
}

; to test .toThrow() matcher
createError() {
  Throw "Error"
}

createCustomError() {
  Throw CustomError()
}

createNoError() {
}

assert := unittesting()

assert.group(".test")
assert.label("vars, arrays, objects")
assert.test("hello", "hello")
assert.test(["hello"], ["hello"])
assert.test({key: "value"}, {key: "value"})


assert.group(".equal")
assert.label("vars, arrays, objects")
assert.equal("hello", "hello")
assert.equal(["hello"], ["hello"])
assert.equal({key: "value"}, {key: "value" })


assert.group(".notEqual")
assert.label("vars, arrays, objects")
assert.notEqual("hello", "Hello")
assert.notEqual(["hello"], ["world"])
assert.notEqual({key: "value"}, {key: "differentValue"})


assert.group(".toThrow")
assert.label("function throwing error")
assert.toThrow(createError)

assert.label("function throwing error of type CustomError")
assert.toThrow(createCustomError, "CustomError")

assert2 := unittesting()
assert.label("function not throwing error")
assert2.toThrow(createNoError)
assert.test(assert2.failTotal, 1)

assert.label("function throwing 'CustomError', expecting 'TypeError'")
assert2.toThrow(createCustomError, "TypeError")
assert.test(assert2.failTotal, 2)

assert.label("function throwing error string, expecting 'TypeError'")
assert2.toThrow(createError, "TypeError")
assert.test(assert2.failTotal, 3)
; assert2.sendReportToDebugConsole()
; OutputDebug "`n"


assert.group(".true")
assert.label("vars")
assert.true(true)
assert.true(1)
assert.label("expressions")
assert.true((1 == 1))
assert.true((1 != 0))
assert.label("Function")
assert.true(InStr("String", "s"))


assert.group(".false")
assert.label("vars")
assert.false(false)
assert.false(0)
assert.label("expressions")
assert.false((1 == 0))
assert.false((1 != 1))

; wrap up
assert.writeResultsToFile()
assert.sendReportToDebugConsole()
; assert.fullReport()
ExitApp()
