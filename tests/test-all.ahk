#Include "..\export.ahk"

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
assert.notEqual("hello", "hello!")
assert.notEqual(["hello"], ["world"])
assert.notEqual({key: "value"}, {key: "differentValue"})


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
assert.fullReport()
ExitApp()
