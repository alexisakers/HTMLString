/**
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   main.m
 *  Project         :   HTMLString
 *  Author          :   ALEXIS AUBRY RADANOVIC
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 *	The MIT License (MIT)
 *	Copyright (c) 2016 ALEXIS AUBRY RADANOVIC
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy of
 *	this software and associated documentation files (the "Software"), to deal in
 *	the Software without restriction, including without limitation the rights to
 *	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 *	the Software, and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in all
 *	copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 *	FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 *	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 *	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ==---------------------------------------------------------------------------------==
 */

#import <Foundation/Foundation.h>
@import HTMLString;

@interface HTMLStringObjCTests : NSObject

@end

@implementation HTMLStringObjCTests

+ (void) invokeAll {
    
    [self testStringASCIIEscaping];
    [self testStringUnicodeEscaping];
    [self testUnescaping];
    
}

///
/// Tests escaping a string for ASCII.
///

+ (void) testStringASCIIEscaping {
    
    NSString *namedEscape = [@"Fish & Chips" stringByEscapingForASCIIHTML];
    NSLog(@"%hhd", [namedEscape  isEqual: @"Fish &#38; Chips"]);
    
    NSString *namedDualEscape = [@"a ⪰̸ b" stringByEscapingForASCIIHTML];
    NSLog(@"%hhd", [namedDualEscape  isEqual: @"a &#10928;&#824; b"]);
    
    NSString *emojiEscape = [@"Hey 🙃" stringByEscapingForASCIIHTML];
    NSLog(@"%hhd", [emojiEscape  isEqual: @"Hey &#128579;"]);
    
    NSString *doubleEmojiEscape = [@"Going to the 🇺🇸 next June" stringByEscapingForASCIIHTML];
    NSLog(@"%hhd", [doubleEmojiEscape  isEqual: @"Going to the &#127482;&#127480; next June"]);
    
}

///
/// Tests escaping a string for Unicode.
///

+ (void) testStringUnicodeEscaping {
    
    NSString *requiredEscape = [@"Fish & Chips" stringByEscapingForUnicodeHTML];
    NSLog(@"%hhd", [requiredEscape  isEqual: @"Fish &#38; Chips"]);
    
    NSString *namedDualEscape = [@"a ⪰̸ b" stringByEscapingForUnicodeHTML];
    NSLog(@"%hhd", [namedDualEscape  isEqual: @"a ⪰̸ b"]);
    
    NSString *emojiEscape = [@"Hey 🙃!" stringByEscapingForUnicodeHTML];
    NSLog(@"%hhd", [emojiEscape  isEqual: @"Hey 🙃&#33;"]);
    
    NSString *doubleEmojiEscape = [@"Going to the 🇺🇸 next June" stringByEscapingForUnicodeHTML];
    NSLog(@"%hhd", [doubleEmojiEscape  isEqual: @"Going to the 🇺🇸 next June"]);
    
}

// MARK: - Unescaping

///
/// Tests unescaping sequences.
///

+ (void) testUnescaping {
    
    NSString *withoutMarker = [@"Hello, world." stringByUnescapingFromHTML];
    NSLog(@"%hhd", [withoutMarker  isEqual: @"Hello, world."]);
    
    NSString *noSemicolon = [@"Fish & Chips" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [noSemicolon  isEqual: @"Fish & Chips"]);
    
    NSString *decimal = [@"My phone number starts with a &#49;" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [decimal  isEqual: @"My phone number starts with a 1"]);
    
    NSString *invalidDecimal = [@"My phone number starts with a &#4_9;!" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [invalidDecimal  isEqual: @"My phone number starts with a &#4_9;!"]);
    
    NSString *hex = [@"Let's meet at the caf&#xe9;" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [hex  isEqual: @"Let's meet at the café"]);
    
    NSString *invalidHex = [@"Let's meet at the caf&#xzi;!" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [invalidHex  isEqual: @"Let's meet at the caf&#xzi;!"]);
    
    NSString *invalidUnicodePoint = [@"What is this character ? -> &#xd8ff;" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [invalidUnicodePoint  isEqual: @"What is this character ? -> &#xd8ff;"]);
    
    NSString *badSequence = [@"I love &swift;" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [badSequence  isEqual: @"I love &swift;"]);
    
    NSString *goodSequence = [@"Do you know &aleph;?" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [goodSequence  isEqual: @"Do you know ℵ?"]);
    
    NSString *twoSequences = [@"a &amp;&amp; b" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [twoSequences  isEqual: @"a && b"]);
    
    NSString *doubleEmojiEscape = [@"Going to the &#127482;&#127480; next June" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [doubleEmojiEscape  isEqual: @"Going to the 🇺🇸 next June"]);
    
}

@end

#pragma mark Run

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [HTMLStringObjCTests invokeAll];
    }
    return 0;
}
