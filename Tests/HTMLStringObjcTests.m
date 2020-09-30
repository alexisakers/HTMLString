//
//  HTMLStringObjcTests.m
//  HTMLString-iOS Tests
//
//  Created by Joshua on 2020/09/29.
//

#import <XCTest/XCTest.h>
#import <HTMLString/HTMLString-Swift.h>
#import "ObjcTestData.h"
///
/// Tests HTML escaping/unescaping in objective-c
///

@interface HTMLStringObjcTests : XCTestCase

@end

@implementation HTMLStringObjcTests

#pragma mark - Escaping

/// Tests escaping a string for ASCII.
- (void)testStringASCIIEscaping {
    NSString * emptyString = [@"" stringByAddingASCIIEntities];
    XCTAssertTrue([emptyString isEqualToString: @""]);

    NSString* namedEscape = [@"Fish & Chips" stringByAddingASCIIEntities];
    XCTAssertTrue([namedEscape isEqualToString: @"Fish &#38; Chips"]);

    NSString* namedDualEscape = [@"a ⪰̸ b" stringByAddingASCIIEntities];
    XCTAssertTrue([namedDualEscape isEqualToString: @"a &#10928;&#824; b"]);

    NSString* emojiEscape = [@"Hey 🙃" stringByAddingASCIIEntities];
    XCTAssertTrue([emojiEscape isEqualToString: @"Hey &#128579;"]);

    NSString* doubleEmojiEscape = [@"Going to the 🇺🇸 next June" stringByAddingASCIIEntities];
    XCTAssertTrue([doubleEmojiEscape isEqualToString: @"Going to the &#127482;&#127480; next June"]);
}
/// Tests escaping a string for Unicode.
- (void) testStringUnicodeEscaping {
    NSString* requiredEscape = [@"Fish & Chips" stringByAddingUnicodeEntities];
    XCTAssertTrue([requiredEscape isEqualToString: @"Fish &#38; Chips"]);

    NSString* namedDualEscape = [@"a ⪰̸ b" stringByAddingUnicodeEntities];
    XCTAssertTrue([namedDualEscape isEqualToString: @"a ⪰̸ b"]);

    NSString* emojiEscape = [@"Hey 🙃!" stringByAddingUnicodeEntities];
    XCTAssertTrue([emojiEscape isEqualToString: @"Hey 🙃&#33;"]);

    NSString* doubleEmojiEscape = [@"Going to the 🇺🇸 next June" stringByAddingUnicodeEntities];
    XCTAssertTrue([doubleEmojiEscape isEqualToString: @"Going to the 🇺🇸 next June"]);
}

#pragma mark - Unescaping

/// Tests unescaping strings.
-(void) testUnescaping {
    NSString* withoutMarker = [@"Hello, world." stringByRemovingHTMLEntities];
    XCTAssertTrue([withoutMarker isEqualToString: @"Hello, world."]);

    NSString* noSemicolon = [@"Fish & Chips" stringByRemovingHTMLEntities];
    XCTAssertTrue([noSemicolon isEqualToString: @"Fish & Chips"]);

    NSString* decimal = [@"My phone number starts with a &#49;" stringByRemovingHTMLEntities];

    XCTAssertTrue([decimal isEqualToString: @"My phone number starts with a 1"]);

    NSString* invalidDecimal = [@"My phone number starts with a &#4_9;!" stringByRemovingHTMLEntities];
    XCTAssertTrue(invalidDecimal, "My phone number starts with a &#4_9;!");

    NSString* hex = [@"Let's meet at the caf&#xe9;" stringByRemovingHTMLEntities];
    XCTAssertTrue([hex isEqualToString: @"Let's meet at the café"]);

    NSString* invalidHex = [@"Let's meet at the caf&#xzi;!" stringByRemovingHTMLEntities];
    XCTAssertTrue([invalidHex isEqualToString: @"Let's meet at the caf&#xzi;!"]);

    NSString* invalidUnicodePoint = [@"What is this character ? -> &#xd8ff;" stringByRemovingHTMLEntities];
    XCTAssertTrue([invalidUnicodePoint isEqualToString: @"What is this character ? -> &#xd8ff;"]);

    NSString* badSequence = [@"I love &swift;" stringByRemovingHTMLEntities];
    XCTAssertTrue([badSequence isEqualToString: @"I love &swift;"]);

    NSString* goodSequence = [@"Do you know &aleph;?" stringByRemovingHTMLEntities];
    XCTAssertTrue([goodSequence isEqualToString: @"Do you know ℵ?"]);

    NSString* twoSequences = [@"a &amp;&amp; b" stringByRemovingHTMLEntities];
    XCTAssertTrue([twoSequences isEqualToString: @"a && b"]);

    NSString* doubleEmojiEscape = [@"Going to the &#127482;&#127480; next June" stringByRemovingHTMLEntities];
    XCTAssertTrue([doubleEmojiEscape isEqualToString: @"Going to the 🇺🇸 next June"]);

    NSString* textInTheMiddle = [@"Fish & Chips tastes &quot;great\"" stringByRemovingHTMLEntities];
    XCTAssertTrue([textInTheMiddle isEqualToString: @"Fish & Chips tastes \"great\""]);
}

#pragma mark - Open Data

-(void) testThatItUnescapesSampleData {
    NSString* review = @"44 Fotos und 68 Tipps von 567 Besucher bei NETA Mexican Street Food anzeigen. &quot;Not sharing the enthusiasm of the other reviewers. The tacos were...&quot;";

    NSString* expectedReview = @"44 Fotos und 68 Tipps von 567 Besucher bei NETA Mexican Street Food anzeigen. \"Not sharing the enthusiasm of the other reviewers. The tacos were...\"";

    XCTAssertTrue([[review stringByRemovingHTMLEntities] isEqualToString: expectedReview]);

    NSString* foursquare = @"NETA Mexican Street Food, Weinbergsweg 5, Berlin, Berlin, neta mexican street food, Burritos, Mexikanisch, Nachspeise, Abendessen &amp; more";
    NSString* expectedFoursquare = @"NETA Mexican Street Food, Weinbergsweg 5, Berlin, Berlin, neta mexican street food, Burritos, Mexikanisch, Nachspeise, Abendessen & more";
    XCTAssertTrue([[foursquare stringByRemovingHTMLEntities] isEqualToString: expectedFoursquare]);

    NSString* headline = @"What&#x27;s it like to drive with Tesla&#x27;s Autopilot and how does it work?";
    NSString* expectedHeadline = @"What's it like to drive with Tesla's Autopilot and how does it work?";

    XCTAssertTrue([[headline stringByRemovingHTMLEntities] isEqualToString: expectedHeadline]);
}

#pragma mark - Benchmark

/// Measures the average unescaping performance.
-(void) testUnescapingPerformance {
    // baseline average: 0.001s
    [self measureBlock:^{
        (void)[@"Hello, world." stringByRemovingHTMLEntities];
        (void)[@"Fish & Chips" stringByRemovingHTMLEntities];
        (void)[@"My phone number starts with a &#49;" stringByRemovingHTMLEntities];
        (void)[@"My phone number starts with a &#4_9;!" stringByRemovingHTMLEntities];
        (void)[@"Let's meet at the caf&#xe9;" stringByRemovingHTMLEntities];
        (void)[@"Let's meet at the caf&#xzi;!"stringByRemovingHTMLEntities];
        (void)[@"What is this character ? -> &#xd8ff;" stringByRemovingHTMLEntities];
        (void)[@"I love &swift;" stringByRemovingHTMLEntities];
        (void)[@"Do you know &aleph;?" stringByRemovingHTMLEntities];
        (void)[@"a &amp;&amp; b" stringByRemovingHTMLEntities];
    }];
}

/// Measures escaping avergae performance.
-(void) testEscapingPerformance {
    // baseline average: 0.001s

    [self measureBlock: ^{
        (void)[@"Fish & Chips" stringByAddingASCIIEntities];
        (void)[@"a ⪰̸ b" stringByAddingASCIIEntities];
        (void)[@"Hey 🙃" stringByAddingASCIIEntities];
        (void)[@"Going to the 🇺🇸 next June" stringByAddingASCIIEntities];

        (void)[@"Fish & Chips" stringByAddingUnicodeEntities];
        (void)[@"a ⪰̸ b" stringByAddingUnicodeEntities];
        (void)[@"Hey 🙃!" stringByAddingUnicodeEntities];
        (void)[@"Going to the 🇺🇸 next June" stringByAddingUnicodeEntities];
    }];
}

/// Measures the average perforance of unescaping a long String with a large number of entities.
-(void) testLargeUnescapingPerformance {
    // baseline average: 0.3s
    [self measureBlock:^ {
        (void)[HTMLTestLongUnescapableString stringByRemovingHTMLEntities];
    }];
}
@end
