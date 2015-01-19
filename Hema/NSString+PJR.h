//
//  NSString+PJR.h
//  Lib
//
//  Created by Paritosh on 15/05/14.
//
//
/* All rights reserved.
*
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

#import <Foundation/Foundation.h>

@interface NSString (PJR)

/*
 Boolian Value Object Method
 */

- (BOOL)isUrl;
- (BOOL)isEmpty;
- (BOOL)isBlank;
- (BOOL)isValid;
- (BOOL)isEmail;
- (BOOL)isDigit;
- (BOOL)isNumeric;
- (BOOL)isValidUrl;
- (BOOL)isValidEmail;
- (BOOL)hasBothCases;
- (BOOL)isPhoneNumber;
- (BOOL)isAlphanumeric;
- (BOOL)isVAlidPhoneNumber;
- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (BOOL)isInThisarray:(NSArray*)array;
- (BOOL)isEndssWith:(NSString *)string;
- (BOOL)isBeginsWith:(NSString *)string;
- (BOOL)isMinLength:(NSUInteger)length;
- (BOOL)isMaxLength:(NSUInteger)length;
- (BOOL)containsString:(NSString *)subString;
- (BOOL)isMinLength:(NSUInteger)min andMaxLength:(NSUInteger)max;
- (BOOL)containsString: (NSString*)substring range:(NSRange*)range;

/*
 NSData Instance Method
 */

- (NSData *)convertToData;

/*
 NSArray Instance Method
 */

- (NSArray *)getArray;
- (NSArray*)splitString:(NSString*)string seperator:(NSString *)seperator;

/*
 NSMutableArray Instance Method
 */

- (NSMutableArray*)stringsBetweenString:(NSString*)start andString:(NSString*)end;

/*
 NSUInteger Instance Method
 */

- (NSUInteger)countWords;
- (NSUInteger)countNumberOfWords;
- (NSUInteger)occurrencesOfString:(NSString *)needle;

/*
 NSString Class Method
 */

+ (NSString *)randomEmoji;
+ (NSString *)getMyApplicationName;
+ (NSString *)getMyApplicationVersion;
+ (NSString *)getStringFromData:(NSData *)data;
+ (NSString *)getStringFromArray:(NSArray *)array;

/*
 NSString Instance Method
 */

- (NSString*)stripNewlines;
- (NSString *)CleanTextField;
- (NSString*)removeSpacesFromString;
- (NSString *)trimWhitespaceFromEnds;
- (NSString *)removeWhiteSpacesFromString;
- (NSString *)inverseCapitalisationString;
- (NSString *)addString:(NSString *)string;
- (NSString*)removeSubstring:(NSString*)substring;
- (NSString *)removeSubString:(NSString *)subString;
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
- (NSString *)stringBetweenString:(NSString*)start andString:(NSString*)end;
- (NSString*)compileStrings:(NSArray*)chunks seperator:(NSString*)seperator;
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;

@end
