//: Alp Keser 05022017

import Foundation

extension String {
    
    func contains(turkishString searchString: String, caseSensitive: Bool) -> Bool{
        guard let regex = searchString.turkishRegex(caseSensitive: caseSensitive) else {
            return false
        }
        let results = regex.matches(in: self,
                                        options: [], range: NSMakeRange(0, self.characters.count))
        return results.count > 0
    }
    
    func turkishRegex(caseSensitive: Bool) -> NSRegularExpression? {
        do {
            //s i o c g u
            var regexPattern = ""
            var regexCharacter = ""
            for character in self.characters {
                regexCharacter = ""
                if character == "I" || character == "İ" || character == "ı" || character == "i" {
                    regexCharacter = "[Iİıi]"
                } else if character == "S" || character == "Ş" || character == "s" || character == "ş" {
                    regexCharacter = "[SŞsş]"
                } else if character == "O" || character == "Ö" || character == "o" || character == "ö" {
                    regexCharacter = "[OÖoö]"
                } else if character == "C" || character == "Ç" || character == "c" || character == "ç" {
                    regexCharacter = "[CÇcç]"
                } else if character == "G" || character == "Ğ" || character == "g" || character == "ğ" {
                    regexCharacter = "[GĞgğ]"
                } else if character == "U" || character == "Ü" || character == "u" || character == "ü" {
                    regexCharacter = "[UÜuü]"
                } else {
                    regexCharacter = "\(character)"
                }
                regexPattern = regexPattern + regexCharacter
            }
            
            let options: NSRegularExpression.Options = caseSensitive ? [] : [.caseInsensitive]
            
            return try NSRegularExpression(pattern: regexPattern, options: options)
        } catch {
            return nil
        }
    }
}

//Testing
let turkishSentence = "Türkçe ya da Türk dili, batıda Balkanlar’dan başlayıp doğuda Hazar Denizi sahasına kadar konuşulan Altay dillerinden biridir."
let turkishWannabe = "basLayip"

let shouldBeTrue = turkishSentence.contains(turkishString: turkishWannabe, caseSensitive: false)
let shouldBeFalse = turkishSentence.contains(turkishString: turkishWannabe, caseSensitive: true)



