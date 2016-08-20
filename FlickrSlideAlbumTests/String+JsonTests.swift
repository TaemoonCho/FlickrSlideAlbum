import Quick
import Nimble
import SwiftyJSON

class String_JsonTests: QuickSpec {
    override func spec() {
        describe("String+Json") {
            let testJsonString = "{\"glossary\": {\"title\": \"example glossary\", \"GlossDiv\": {\"title\": \"S\", \"GlossList\": {\"GlossEntry\": {\"ID\": \"SGML\", \"SortAs\": \"SGML\", \"GlossTerm\": \"Standard Generalized Markup Language\", \"Acronym\": \"SGML\", \"Abbrev\": \"ISO 8879:1986\", \"GlossDef\": {\"para\": \"A meta-markup language, used to create markup languages such as DocBook.\", \"GlossSeeAlso\": [\"GML\", \"XML\"] }, \"GlossSee\": \"markup\"} } } } }"
            describe("parsing string to json as dictionary") {
                it("should return a dictionary to expect after parsing.") {
                    let json = testJsonString.json
                    expect(json?.count).to(equal(1))
                    expect(json?.type).to(equal(SwiftyJSON.Type.Dictionary))
                    expect(json?["glossary"]["GlossDiv"]["GlossList"]["GlossEntry"]["ID"].stringValue);
                }
            }
        }
    }
}
