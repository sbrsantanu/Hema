//
//  NSString+PJR.m
//  Lib
//
//  Created by Paritosh on 15/05/14.
//
// * All rights reserved.
/*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of the <organization> nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
   * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*/


#import "NSString+PJR.h"

@implementation NSString (PJR)


// Checking if String is Empty
-(BOOL)isBlank
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""]) ? YES : NO;
}
//Checking if String is empty or nil
-(BOOL)isValid
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]) ? NO :YES;
}

// remove white spaces from String
- (NSString *)removeWhiteSpacesFromString
{
	NSString *trimmedString = [self stringByTrimmingCharactersInSet:
							   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return trimmedString;
}

// Counts number of Words in String
- (NSUInteger)countNumberOfWords
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil]) {
        count++;
    }
	
    return count;
}

// If string contains substring
- (BOOL)containsString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

// If my string starts with given string
- (BOOL)isBeginsWith:(NSString *)string
{
    return ([self hasPrefix:string]) ? YES : NO;
}

// If my string ends with given string
- (BOOL)isEndssWith:(NSString *)string
{
    return ([self hasSuffix:string]) ? YES : NO;
}



// Replace particular characters in my string with new character
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar
{
    return  [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}

// Get Substring from particular location to given lenght
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end
{
	NSRange r;
	r.location = begin;
	r.length = end - begin;
	return [self substringWithRange:r];
}

// Add substring to main String 
- (NSString *)addString:(NSString *)string
{
    if(!string || string.length == 0)
        return self;

    return [self stringByAppendingString:string];
}

// Remove particular sub string from main string
-(NSString *)removeSubString:(NSString *)subString
{
    if ([self containsString:subString])
    {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}


// If my string contains ony letters
- (BOOL)containsOnlyLetters
{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// If my string contains only numbers
- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// If my string contains letters and numbers
- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

// If my string is available in particular array
- (BOOL)isInThisarray:(NSArray*)array
{
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

// Get String from array
+ (NSString *)getStringFromArray:(NSArray *)array
{
    return [array componentsJoinedByString:@" "];
}

// Convert Array from my String
- (NSArray *)getArray
{
    return [self componentsSeparatedByString:@" "];
}

// Get My Application Version number
+ (NSString *)getMyApplicationVersion
{
	NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
	NSString *version = [info objectForKey:@"CFBundleVersion"];
	return version;
}

// Get My Application name
+ (NSString *)getMyApplicationName
{
	NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
	NSString *name = [info objectForKey:@"CFBundleDisplayName"];
	return name;
}


// Convert string to NSData
- (NSData *)convertToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// Get String from NSData
+ (NSString *)getStringFromData:(NSData *)data
{
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
    
}

// Is Valid Email

- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

// Is Valid Phone

- (BOOL)isVAlidPhoneNumber
{
    NSString *regex = @"[235689][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:self];
}

// Is Valid URL

- (BOOL)isValidUrl
{
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}



+ (BOOL)isNilOrEmpty:(NSString *)input {
    return !input || [input isEmpty];
}

- (BOOL)isEmail {
    NSString *regex = @"[a-zA-Z0-9.\\-_]{2,32}@[a-zA-Z0-9.\\-_]{2,32}\\.[A-Za-z]{2,4}";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regExPredicate evaluateWithObject:self];
}

- (BOOL)isPhoneNumber {
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber
                                                               error:nil];
    
    return [detector numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
}

- (BOOL)isDigit {
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    
    return [alphaNums isSupersetOfSet:inStringSet];
}

- (BOOL)isNumeric {
    NSString *regex = @"([0-9])+((\\.|,)([0-9])+)?";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regExPredicate evaluateWithObject:self];
}

- (BOOL)isAlphanumeric {
    NSString *regex = @"^.*(?=.*?[a-zA-Z])(?=.*?[0-9]).+$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regExPredicate evaluateWithObject:self];
}

- (BOOL)hasBothCases {
    NSString *regex = @"^.*(?=.*?[a-z])(?=.*?[A-Z]).+$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regExPredicate evaluateWithObject:self];
}

- (BOOL)isUrl {
    NSString *regex = @"https?:\\/\\/[\\S]+";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regExPredicate evaluateWithObject:self];
}

- (BOOL)isMinLength:(NSUInteger)length {
    return (self.length >= length);
}

- (BOOL)isMaxLength:(NSUInteger)length {
    return (self.length <= length);
}

- (BOOL)isMinLength:(NSUInteger)min andMaxLength:(NSUInteger)max {
    return ([self isMinLength:min] && [self isMaxLength:max]);
}

- (BOOL)isEmpty {
    return (!self.length);
}
-(NSString *)CleanTextField
{
    NSString *Cleanvalue = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return Cleanvalue;
}
-(NSUInteger)occurrencesOfString:(NSString *)needle {
    NSString *haystack = (NSString*)self;
    const char * rawNeedle = [needle UTF8String];
    NSUInteger needleLength = strlen(rawNeedle);
    
    const char * rawHaystack = [haystack UTF8String];
    NSUInteger haystackLength = strlen(rawHaystack);
    
    NSUInteger needleCount = 0;
    NSUInteger needleIndex = 0;
    for (NSUInteger index = 0; index < haystackLength; ++index) {
        const char thisCharacter = rawHaystack[index];
        if (thisCharacter != rawNeedle[needleIndex]) {
            needleIndex = 0; //they don't match; reset the needle index
        }
        
        //resetting the needle might be the beginning of another match
        if (thisCharacter == rawNeedle[needleIndex]) {
            needleIndex++; //char match
            if (needleIndex >= needleLength) {
                needleCount++; //we completed finding the needle
                needleIndex = 0;
            }
        }
    }
    return needleCount;
}

-(BOOL)containsString:(NSString *)substring range:(NSRange *)range{
    
    NSRange r = [self rangeOfString : substring];
    BOOL found = ( r.location != NSNotFound );
    if (range != NULL) *range = r;
    return found;
}

- (NSString *) inverseCapitalisationString
{
    // This is a quick hack to convert upper case letters to lowercase, and vice versa
    // It uses the standard C character manipulation functions so it will obviously not
    // work on anything other than basic ASCII strings.
    
    // get the length of the string that is to be manipulated
    int len = (int)[self length];
    
    // create a string to hold our modified text
    NSMutableString *capitalisedString = [NSMutableString stringWithCapacity:len];
    
    // iterate over the original string, pulling out each character for inspection
    for (int i = 0; i < len; i++)
    {
        // get the next character in the original string
        char ch = [self characterAtIndex:i];
        
        // convert upper-case to lower-case, and lower-case to upper-case
        if (isupper(ch))
        {
            ch = tolower(ch);
        }
        else if (islower(ch))
        {
            ch = toupper(ch);
        }
        
        // append the manipulated character to the modified string
        [capitalisedString appendString:[NSString stringWithFormat:@"%c", ch]];
    }
    
    // return the newly modified string
    return capitalisedString;
}

-(NSString*)removeSubstring:(NSString*)substring {
    NSString *stringWithoutSubstring = [self stringByReplacingOccurrencesOfString:substring withString:@""];
    return stringWithoutSubstring;
}

-(NSString*)stringBetweenString:(NSString*)start andString:(NSString*)end {
    NSRange startRange = [self rangeOfString:start];
    if (startRange.location != NSNotFound) {
        NSRange targetRange;
        targetRange.location = startRange.location + startRange.length;
        targetRange.length = [self length] - targetRange.location;
        NSRange endRange = [self rangeOfString:end options:0 range:targetRange];
        if (endRange.location != NSNotFound) {
            targetRange.length = endRange.location - targetRange.location;
            return [self substringWithRange:targetRange];
        }
    }
    return nil;
}

-(NSMutableArray*)stringsBetweenString:(NSString*)start andString:(NSString*)end
{
    NSMutableArray* strings = [NSMutableArray arrayWithCapacity:0];
    NSRange startRange = [self rangeOfString:start];
    for( ;; )
    {
        if (startRange.location != NSNotFound)
        {
            NSRange targetRange;
            
            targetRange.location = startRange.location + startRange.length;
            targetRange.length = [self length] - targetRange.location;
            
            NSRange endRange = [self rangeOfString:end options:0 range:targetRange];
            
            if (endRange.location != NSNotFound)
            {
                targetRange.length = endRange.location - targetRange.location;
                [strings addObject:[self substringWithRange:targetRange]];
                
                NSRange restOfString;
                
                restOfString.location = endRange.location + endRange.length;
                restOfString.length = [self length] - restOfString.location;
                
                startRange = [self rangeOfString:start options:0 range:restOfString];
            }
            else
            {
                break;
            }
        }
        else
        {
            break;
        }
    }
    return strings;
}

-(NSString*)compileStrings:(NSArray*)chunks seperator:(NSString*)seperator {
    NSString *compiledString = [chunks componentsJoinedByString:seperator];
    return compiledString;
}

-(NSUInteger)countWords {
    __block NSUInteger wordCount = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByWords usingBlock:^(NSString *character, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         wordCount++;
     }];
    return wordCount;
}

-(NSString*)stripNewlines {
    NSMutableString *mstring = [NSMutableString stringWithString:self];
    NSRange wholeShebang = NSMakeRange(0, [mstring length]);
    [mstring replaceOccurrencesOfString: @"" withString: @"" options: 0 range: wholeShebang];
    return [NSString stringWithString: mstring];
}

-(NSString*)removeSpacesFromString {
    return [self stringByReplacingOccurrencesOfString: @" " withString: @""];
}

-(NSString *)trimWhitespaceFromEnds {
    NSString *trimmed = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmed;
}

-(NSArray*)splitString:(NSString*)string seperator:(NSString *)seperator {
    NSArray *chunks = [string componentsSeparatedByString:seperator];
    return chunks;
}
+ (NSString *)randomEmoji {
    NSArray *emojisArray = [self emojisArray];
    NSString *randomEmoji = [emojisArray objectAtIndex:arc4random_uniform([emojisArray count])];
    
    return randomEmoji;
}

+ (NSArray *)emojisArray {
    return @[@"\U0001F44D",
             @"\U0001F44E",
             @"\U0001F4AF",
             @"\U0001F522",
             @"\U0001F3B1",
             @"\U0001F170",
             @"\U0001F18E",
             @"\U0001F524",
             @"\U0001F521",
             @"\U0001F251",
             @"\U0001F6A1",
             @"\U00002708",
             @"\U000023F0",
             @"\U0001F47D",
             @"\U0001F691",
             @"\U00002693",
             @"\U0001F47C",
             @"\U0001F4A2",
             @"\U0001F620",
             @"\U0001F627",
             @"\U0001F41C",
             @"\U0001F34E",
             @"\U00002652",
             @"\U00002648",
             @"\U000025C0",
             @"\U000023EC",
             @"\U000023EB",
             @"\U00002B07",
             @"\U0001F53D",
             @"\U000025B6",
             @"\U00002935",
             @"\U00002934",
             @"\U00002B05",
             @"\U00002199",
             @"\U00002198",
             @"\U000027A1",
             @"\U000021AA",
             @"\U00002B06",
             @"\U00002195",
             @"\U0001F53C",
             @"\U00002196",
             @"\U00002197",
             @"\U0001F503",
             @"\U0001F504",
             @"\U0001F3A8",
             @"\U0001F69B",
             @"\U0001F632",
             @"\U0001F45F",
             @"\U0001F3E7",
             @"\U0001F171",
             @"\U0001F476",
             @"\U0001F37C",
             @"\U0001F424",
             @"\U0001F6BC",
             @"\U0001F519",
             @"\U0001F6C4",
             @"\U0001F388",
             @"\U00002611",
             @"\U0001F38D",
             @"\U0001F34C",
             @"\U0000203C",
             @"\U0001F3E6",
             @"\U0001F4CA",
             @"\U0001F488",
             @"\U000026BE",
             @"\U0001F3C0",
             @"\U0001F6C0",
             @"\U0001F6C1",
             @"\U0001F50B",
             @"\U0001F43B",
             @"\U0001F41D",
             @"\U0001F37A",
             @"\U0001F37B",
             @"\U0001F41E",
             @"\U0001F530",
             @"\U0001F514",
             @"\U0001F371",
             @"\U0001F6B4",
             @"\U0001F6B2",
             @"\U0001F459",
             @"\U0001F426",
             @"\U0001F382",
             @"\U000026AB",
             @"\U0001F0CF",
             @"\U00002B1B",
             @"\U000025FE",
             @"\U000025FC",
             @"\U00002712",
             @"\U000025AA",
             @"\U0001F532",
             @"\U0001F33C",
             @"\U0001F421",
             @"\U0001F4D8",
             @"\U0001F699",
             @"\U0001F499",
             @"\U0001F60A",
             @"\U0001F417",
             @"\U000026F5",
             @"\U0001F4A3",
             @"\U0001F4D6",
             @"\U0001F516",
             @"\U0001F4D1",
             @"\U0001F4DA",
             @"\U0001F4A5",
             @"\U0001F462",
             @"\U0001F490",
             @"\U0001F647",
             @"\U0001F3B3",
             @"\U0001F466",
             @"\U0001F35E",
             @"\U0001F470",
             @"\U0001F309",
             @"\U0001F4BC",
             @"\U0001F494",
             @"\U0001F41B",
             @"\U0001F4A1",
             @"\U0001F685",
             @"\U0001F684",
             @"\U0001F68C",
             @"\U0001F68F",
             @"\U0001F464",
             @"\U0001F465",
             @"\U0001F335",
             @"\U0001F370",
             @"\U0001F4C6",
             @"\U0001F4F2",
             @"\U0001F42B",
             @"\U0001F4F7",
             @"\U0000264B",
             @"\U0001F36C",
             @"\U0001F520",
             @"\U00002651",
             @"\U0001F697",
             @"\U0001F4C7",
             @"\U0001F3A0",
             @"\U0001F431",
             @"\U0001F408",
             @"\U0001F4BF",
             @"\U0001F4B9",
             @"\U0001F4C9",
             @"\U0001F4C8",
             @"\U0001F3C1",
             @"\U0001F352",
             @"\U0001F338",
             @"\U0001F330",
             @"\U0001F414",
             @"\U0001F6B8",
             @"\U0001F36B",
             @"\U0001F384",
             @"\U000026EA",
             @"\U0001F3A6",
             @"\U0001F3AA",
             @"\U0001F307",
             @"\U0001F306",
             @"\U0001F191",
             @"\U0001F44F",
             @"\U0001F3AC",
             @"\U0001F4CB",
             @"\U0001F550",
             @"\U0001F559",
             @"\U0001F565",
             @"\U0001F55A",
             @"\U0001F566",
             @"\U0001F55B",
             @"\U0001F567",
             @"\U0001F55C",
             @"\U0001F551",
             @"\U0001F55D",
             @"\U0001F552",
             @"\U0001F55E",
             @"\U0001F553",
             @"\U0001F55F",
             @"\U0001F554",
             @"\U0001F560",
             @"\U0001F555",
             @"\U0001F561",
             @"\U0001F556",
             @"\U0001F562",
             @"\U0001F557",
             @"\U0001F563",
             @"\U0001F558",
             @"\U0001F564",
             @"\U0001F4D5",
             @"\U0001F510",
             @"\U0001F302",
             @"\U00002601",
             @"\U00002663",
             @"\U0001F378",
             @"\U00002615",
             @"\U0001F630",
             @"\U0001F4A5",
             @"\U0001F4BB",
             @"\U0001F38A",
             @"\U0001F616",
             @"\U0001F615",
             @"\U00003297",
             @"\U0001F6A7",
             @"\U0001F477",
             @"\U0001F3EA",
             @"\U0001F36A",
             @"\U0001F192",
             @"\U0001F46E",
             @"\U000000A9",
             @"\U0001F33D",
             @"\U0001F46B",
             @"\U0001F491",
             @"\U0001F48F",
             @"\U0001F42E",
             @"\U0001F404",
             @"\U0001F4B3",
             @"\U0001F319",
             @"\U0001F40A",
             @"\U0001F38C",
             @"\U0001F451",
             @"\U0001F622",
             @"\U0001F63F",
             @"\U0001F52E",
             @"\U0001F498",
             @"\U000027B0",
             @"\U0001F4B1",
             @"\U0001F35B",
             @"\U0001F36E",
             @"\U0001F6C3",
             @"\U0001F300",
             @"\U0001F483",
             @"\U0001F46F",
             @"\U0001F361",
             @"\U0001F3AF",
             @"\U0001F4A8",
             @"\U0001F4C5",
             @"\U0001F333",
             @"\U0001F3EC",
             @"\U0001F4A0",
             @"\U00002666",
             @"\U0001F61E",
             @"\U0001F625",
             @"\U0001F4AB",
             @"\U0001F635",
             @"\U0001F6AF",
             @"\U0001F436",
             @"\U0001F415",
             @"\U0001F4B5",
             @"\U0001F38E",
             @"\U0001F42C",
             @"\U0001F6AA",
             @"\U0001F369",
             @"\U0001F409",
             @"\U0001F432",
             @"\U0001F457",
             @"\U0001F42A",
             @"\U0001F4A7",
             @"\U0001F4C0",
             @"\U0001F4E7",
             @"\U0001F442",
             @"\U0001F33E",
             @"\U0001F30D",
             @"\U0001F30E",
             @"\U0001F30F",
             @"\U0001F373",
             @"\U0001F346",
             @"\U00002734",
             @"\U00002733",
             @"\U0001F50C",
             @"\U0001F418",
             @"\U00002709",
             @"\U0001F51A",
             @"\U00002709",
             @"\U0001F4E9",
             @"\U0001F4B6",
             @"\U0001F3F0",
             @"\U0001F3E4",
             @"\U0001F332",
             @"\U00002757",
             @"\U0001F611",
             @"\U0001F453",
             @"\U0001F440",
             @"\U0001F44A",
             @"\U0001F3ED",
             @"\U0001F342",
             @"\U0001F46A",
             @"\U000023E9",
             @"\U0001F4E0",
             @"\U0001F628",
             @"\U0001F43E",
             @"\U0001F3A1",
             @"\U0001F4C1",
             @"\U0001F525",
             @"\U0001F692",
             @"\U0001F386",
             @"\U0001F313",
             @"\U0001F31B",
             @"\U0001F41F",
             @"\U0001F365",
             @"\U0001F3A3",
             @"\U0000270A",
             @"\U0001F38F",
             @"\U0001F526",
             @"\U0001F42C",
             @"\U0001F4BE",
             @"\U0001F3B4",
             @"\U0001F633",
             @"\U0001F301",
             @"\U0001F3C8",
             @"\U0001F463",
             @"\U0001F374",
             @"\U000026F2",
             @"\U0001F340",
             @"\U0001F193",
             @"\U0001F364",
             @"\U0001F35F",
             @"\U0001F438",
             @"\U0001F626",
             @"\U000026FD",
             @"\U0001F315",
             @"\U0001F31D",
             @"\U0001F3B2",
             @"\U0001F48E",
             @"\U0000264A",
             @"\U0001F47B",
             @"\U0001F381",
             @"\U0001F49D",
             @"\U0001F467",
             @"\U0001F310",
             @"\U0001F410",
             @"\U000026F3",
             @"\U0001F347",
             @"\U0001F34F",
             @"\U0001F4D7",
             @"\U0001F49A",
             @"\U00002755",
             @"\U00002754",
             @"\U0001F62C",
             @"\U0001F601",
             @"\U0001F600",
             @"\U0001F482",
             @"\U0001F3B8",
             @"\U0001F52B",
             @"\U0001F487",
             @"\U0001F354",
             @"\U0001F528",
             @"\U0001F439",
             @"\U0000270B",
             @"\U0001F45C",
             @"\U0001F4A9",
             @"\U0001F425",
             @"\U0001F423",
             @"\U0001F3A7",
             @"\U0001F649",
             @"\U00002764",
             @"\U0001F49F",
             @"\U0001F60D",
             @"\U0001F63B",
             @"\U0001F493",
             @"\U0001F497",
             @"\U00002665",
             @"\U00002714",
             @"\U00002797",
             @"\U0001F4B2",
             @"\U00002757",
             @"\U00002796",
             @"\U00002716",
             @"\U00002795",
             @"\U0001F681",
             @"\U0001F33F",
             @"\U0001F33A",
             @"\U0001F506",
             @"\U0001F460",
             @"\U0001F52A",
             @"\U0001F36F",
             @"\U0001F41D",
             @"\U0001F434",
             @"\U0001F3C7",
             @"\U0001F3E5",
             @"\U0001F3E8",
             @"\U00002668",
             @"\U0000231B",
             @"\U000023F3",
             @"\U0001F3E0",
             @"\U0001F3E1",
             @"\U0001F62F",
             @"\U0001F368",
             @"\U0001F366",
             @"\U0001F194",
             @"\U0001F250",
             @"\U0001F47F",
             @"\U0001F4E5",
             @"\U0001F4E8",
             @"\U0001F481",
             @"\U00002139",
             @"\U0001F607",
             @"\U00002049",
             @"\U0001F4F1",
             @"\U0001F3EE",
             @"\U0001F383",
             @"\U0001F5FE",
             @"\U0001F3EF",
             @"\U0001F47A",
             @"\U0001F479",
             @"\U0001F456",
             @"\U0001F602",
             @"\U0001F639",
             @"\U0001F511",
             @"\U0001F51F",
             @"\U0001F458",
             @"\U0001F48B",
             @"\U0001F617",
             @"\U0001F63D",
             @"\U0001F61A",
             @"\U0001F618",
             @"\U0001F619",
             @"\U0001F428",
             @"\U0001F201",
             @"\U0001F3EE",
             @"\U0001F535",
             @"\U0001F537",
             @"\U0001F536",
             @"\U0001F317",
             @"\U0001F31C",
             @"\U0001F606",
             @"\U0001F343",
             @"\U0001F4D2",
             @"\U0001F6C5",
             @"\U00002194",
             @"\U000021A9",
             @"\U0001F34B",
             @"\U0000264C",
             @"\U0001F406",
             @"\U0000264E",
             @"\U0001F688",
             @"\U0001F517",
             @"\U0001F444",
             @"\U0001F484",
             @"\U0001F512",
             @"\U0001F50F",
             @"\U0001F36D",
             @"\U000027BF",
             @"\U0001F4E2",
             @"\U0001F3E9",
             @"\U0001F48C",
             @"\U0001F505",
             @"\U000024C2",
             @"\U0001F50D",
             @"\U0001F50E",
             @"\U0001F004",
             @"\U0001F4EB",
             @"\U0001F4EA",
             @"\U0001F4EC",
             @"\U0001F4ED",
             @"\U0001F468",
             @"\U0001F472",
             @"\U0001F473",
             @"\U0001F45E",
             @"\U0001F341",
             @"\U0001F637",
             @"\U0001F486",
             @"\U0001F356",
             @"\U0001F4E3",
             @"\U0001F348",
             @"\U0001F4DD",
             @"\U0001F6B9",
             @"\U0001F687",
             @"\U0001F3A4",
             @"\U0001F52C",
             @"\U0001F30C",
             @"\U0001F690",
             @"\U0001F4BD",
             @"\U0001F4F4",
             @"\U0001F4B8",
             @"\U0001F4B0",
             @"\U0001F412",
             @"\U0001F435",
             @"\U0001F69D",
             @"\U0001F314",
             @"\U0001F393",
             @"\U0001F5FB",
             @"\U0001F6B5",
             @"\U0001F6A0",
             @"\U0001F69E",
             @"\U0001F42D",
             @"\U0001F401",
             @"\U0001F3A5",
             @"\U0001F5FF",
             @"\U0001F4AA",
             @"\U0001F344",
             @"\U0001F3B9",
             @"\U0001F3B5",
             @"\U0001F3BC",
             @"\U0001F507",
             @"\U0001F485",
             @"\U0001F4DB",
             @"\U0001F454",
             @"\U0000274E",
             @"\U0001F610",
             @"\U0001F195",
             @"\U0001F311",
             @"\U0001F31A",
             @"\U0001F4F0",
             @"\U0001F196",
             @"\U0001F515",
             @"\U0001F6B3",
             @"\U000026D4",
             @"\U0001F6AB",
             @"\U0001F645",
             @"\U0001F4F5",
             @"\U0001F636",
             @"\U0001F6B7",
             @"\U0001F6AD",
             @"\U0001F6B1",
             @"\U0001F443",
             @"\U0001F4D3",
             @"\U0001F4D4",
             @"\U0001F3B6",
             @"\U0001F529",
             @"\U00002B55",
             @"\U0001F17E",
             @"\U0001F30A",
             @"\U0001F419",
             @"\U0001F362",
             @"\U0001F3E2",
             @"\U0001F197",
             @"\U0001F44C",
             @"\U0001F646",
             @"\U0001F474",
             @"\U0001F475",
             @"\U0001F51B",
             @"\U0001F698",
             @"\U0001F68D",
             @"\U0001F694",
             @"\U0001F696",
             @"\U0001F4D6",
             @"\U0001F4C2",
             @"\U0001F450",
             @"\U0001F62E",
             @"\U000026CE",
             @"\U0001F4D9",
             @"\U0001F4E4",
             @"\U0001F402",
             @"\U0001F4E6",
             @"\U0001F4C4",
             @"\U0001F4C3",
             @"\U0001F4DF",
             @"\U0001F334",
             @"\U0001F43C",
             @"\U0001F4CE",
             @"\U0001F17F",
             @"\U0000303D",
             @"\U000026C5",
             @"\U0001F6C2",
             @"\U0001F43E",
             @"\U0001F351",
             @"\U0001F350",
             @"\U0001F4DD",
             @"\U0000270F",
             @"\U0001F427",
             @"\U0001F614",
             @"\U0001F3AD",
             @"\U0001F623",
             @"\U0001F64D",
             @"\U0001F471",
             @"\U0001F64E",
             @"\U0000260E",
             @"\U0001F437",
             @"\U0001F416",
             @"\U0001F43D",
             @"\U0001F48A",
             @"\U0001F34D",
             @"\U00002653",
             @"\U0001F355",
             @"\U0001F447",
             @"\U0001F448",
             @"\U0001F449",
             @"\U0000261D",
             @"\U0001F446",
             @"\U0001F693",
             @"\U0001F429",
             @"\U0001F4A9",
             @"\U0001F3E3",
             @"\U0001F4EF",
             @"\U0001F4EE",
             @"\U0001F6B0",
             @"\U0001F45D",
             @"\U0001F357",
             @"\U0001F4B7",
             @"\U0001F63E",
             @"\U0001F64F",
             @"\U0001F478",
             @"\U0001F44A",
             @"\U0001F49C",
             @"\U0001F45B",
             @"\U0001F4CC",
             @"\U0001F6AE",
             @"\U00002753",
             @"\U0001F430",
             @"\U0001F407",
             @"\U0001F40E",
             @"\U0001F4FB",
             @"\U0001F518",
             @"\U0001F621",
             @"\U0001F683",
             @"\U0001F308",
             @"\U0000270B",
             @"\U0001F64C",
             @"\U0001F64B",
             @"\U0001F40F",
             @"\U0001F35C",
             @"\U0001F400",
             @"\U0000267B",
             @"\U0001F697",
             @"\U0001F534",
             @"\U000000AE",
             @"\U0000263A",
             @"\U0001F60C",
             @"\U0001F501",
             @"\U0001F502",
             @"\U0001F6BB",
             @"\U0001F49E",
             @"\U000023EA",
             @"\U0001F380",
             @"\U0001F35A",
             @"\U0001F359",
             @"\U0001F358",
             @"\U0001F391",
             @"\U0001F48D",
             @"\U0001F680",
             @"\U0001F3A2",
             @"\U0001F413",
             @"\U0001F339",
             @"\U0001F6A8",
             @"\U0001F4CD",
             @"\U0001F6A3",
             @"\U0001F3C9",
             @"\U0001F3C3",
             @"\U0001F3C3",
             @"\U0001F3BD",
             @"\U0001F202",
             @"\U00002650",
             @"\U000026F5",
             @"\U0001F376",
             @"\U0001F461",
             @"\U0001F385",
             @"\U0001F4E1",
             @"\U0001F606",
             @"\U0001F3B7",
             @"\U0001F3EB",
             @"\U0001F392",
             @"\U00002702",
             @"\U0000264F",
             @"\U0001F631",
             @"\U0001F640",
             @"\U0001F4DC",
             @"\U0001F4BA",
             @"\U00003299",
             @"\U0001F648",
             @"\U0001F331",
             @"\U0001F367",
             @"\U0001F411",
             @"\U0001F41A",
             @"\U0001F6A2",
             @"\U0001F455",
             @"\U0001F4A9",
             @"\U0001F45E",
             @"\U0001F6BF",
             @"\U0001F4F6",
             @"\U0001F52F",
             @"\U0001F3BF",
             @"\U0001F480",
             @"\U0001F634",
             @"\U0001F62A",
             @"\U0001F3B0",
             @"\U0001F539",
             @"\U0001F538",
             @"\U0001F53A",
             @"\U0001F53B",
             @"\U0001F604",
             @"\U0001F638",
             @"\U0001F603",
             @"\U0001F63A",
             @"\U0001F608",
             @"\U0001F60F",
             @"\U0001F63C",
             @"\U0001F6AC",
             @"\U0001F40C",
             @"\U0001F40D",
             @"\U0001F3C2",
             @"\U00002744",
             @"\U000026C4",
             @"\U0001F62D",
             @"\U000026BD",
             @"\U0001F51C",
             @"\U0001F198",
             @"\U0001F509",
             @"\U0001F47E",
             @"\U00002660",
             @"\U0001F35D",
             @"\U00002747",
             @"\U0001F387",
             @"\U00002728",
             @"\U0001F496",
             @"\U0001F64A",
             @"\U0001F50A",
             @"\U0001F4AC",
             @"\U0001F6A4",
             @"\U00002B50",
             @"\U0001F31F",
             @"\U0001F303",
             @"\U0001F689",
             @"\U0001F5FD",
             @"\U0001F682",
             @"\U0001F372",
             @"\U0001F4CF",
             @"\U0001F353",
             @"\U0001F61B",
             @"\U0001F61D",
             @"\U0001F61C",
             @"\U0001F31E",
             @"\U0001F33B",
             @"\U0001F60E",
             @"\U00002600",
             @"\U0001F305",
             @"\U0001F304",
             @"\U0001F3C4",
             @"\U0001F363",
             @"\U0001F69F",
             @"\U0001F613",
             @"\U0001F4A6",
             @"\U0001F605",
             @"\U0001F360",
             @"\U0001F3CA",
             @"\U0001F523",
             @"\U0001F489",
             @"\U0001F389",
             @"\U0001F38B",
             @"\U0001F34A",
             @"\U00002649",
             @"\U0001F695",
             @"\U0001F375",
             @"\U0000260E",
             @"\U0001F4DE",
             @"\U0001F52D",
             @"\U0001F3BE",
             @"\U000026FA",
             @"\U0001F4AD",
             @"\U0001F44E",
             @"\U0001F44D",
             @"\U0001F3AB",
             @"\U0001F42F",
             @"\U0001F405",
             @"\U0001F62B",
             @"\U00002122",
             @"\U0001F6BD",
             @"\U0001F5FC",
             @"\U0001F345",
             @"\U0001F445",
             @"\U0001F51D",
             @"\U0001F3A9",
             @"\U0001F69C",
             @"\U0001F6A5",
             @"\U0001F683",
             @"\U0001F686",
             @"\U0001F68A",
             @"\U0001F6A9",
             @"\U0001F4D0",
             @"\U0001F531",
             @"\U0001F624",
             @"\U0001F68E",
             @"\U0001F3C6",
             @"\U0001F379",
             @"\U0001F420",
             @"\U0001F69A",
             @"\U0001F3BA",
             @"\U0001F455",
             @"\U0001F337",
             @"\U0001F422",
             @"\U0001F4FA",
             @"\U0001F500",
             @"\U0001F495",
             @"\U0001F46C",
             @"\U0001F46D",
             @"\U0001F239",
             @"\U0001F234",
             @"\U0001F23A",
             @"\U0001F22F",
             @"\U0001F237",
             @"\U0001F236",
             @"\U0001F235",
             @"\U0001F21A",
             @"\U0001F238",
             @"\U0001F232",
             @"\U0001F233",
             @"\U00002614",
             @"\U0001F612",
             @"\U0001F51E",
             @"\U0001F513",
             @"\U0001F199",
             @"\U0000270C",
             @"\U0001F6A6",
             @"\U0001F4FC",
             @"\U0001F4F3",
             @"\U0001F4F9",
             @"\U0001F3AE",
             @"\U0001F3BB",
             @"\U0000264D",
             @"\U0001F30B",
             @"\U0001F19A",
             @"\U0001F6B6",
             @"\U0001F318",
             @"\U0001F316",
             @"\U000026A0",
             @"\U0000231A",
             @"\U0001F403",
             @"\U0001F349",
             @"\U0001F44B",
             @"\U00003030",
             @"\U0001F312",
             @"\U0001F314",
             @"\U0001F6BE",
             @"\U0001F629",
             @"\U0001F492",
             @"\U0001F433",
             @"\U0001F40B",
             @"\U0000267F",
             @"\U00002705",
             @"\U000026AA",
             @"\U0001F4AE",
             @"\U00002B1C",
             @"\U000025FD",
             @"\U000025FB",
             @"\U000025AB",
             @"\U0001F533",
             @"\U0001F390",
             @"\U0001F377",
             @"\U0001F609",
             @"\U0001F43A",
             @"\U0001F469",
             @"\U0001F45A",
             @"\U0001F452",
             @"\U0001F6BA",
             @"\U0001F61F",
             @"\U0001F527",
             @"\U0000274C",
             @"\U0001F49B",
             @"\U0001F4B4",
             @"\U0001F60B",
             @"\U000026A1",
             @"\U0001F4A4"
             ];
}
@end
