//
//  SocialCipherTests.swift
//  SocialCipherTests
//
//  Created by Wayne Hartman on 12/19/17.
//  Copyright © 2017 WayneHartman. All rights reserved.
//

import XCTest
@testable import SocialCipher

class SocialCipherTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSimple() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .hashtag, .url])
        let input = "hello"
        let output = cipher.encode(forString: input)
        
        XCTAssertEqual(output, "uryyb")
    }
    
    // MARK: -
    // MARK: Usernames
    // MARK: -
    
    func testSimpleUsernameExclusion() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .hashtag, .url])
        let input = "@waynehartman"
        let output = cipher.encode(forString: input)

        XCTAssertEqual(input, output)
    }
    
    func testMultipleUsernameExclusion() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .hashtag, .url])
        let input = "@waynehartman @LK64076007A"
        let output = cipher.encode(forString: input)

        XCTAssertEqual(input, output)
    }
    
    func testComplexMultipleUsernameExlusions() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .hashtag, .url])
        let input = "@waynehartman hello @LK64076007A"
        let output = cipher.encode(forString: input)

        XCTAssertEqual("@waynehartman uryyb @LK64076007A", output)
    }
    
    func testUsernameNonuse() {
        let cipher = ROT13Cipher(exclusionExpressions: [.hashtag, .url])
        let input = "@waynehartman"
        let output = cipher.encode(forString: input)

        XCTAssertEqual(output, "@jnlarunegzna")
    }
    
    // MARK: -
    // MARK: Hashtags
    // MARK: -
    
    func testSimpleHashTagExclusion() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .hashtag, .url])
        let input = "#test"
        let output = cipher.encode(forString: input)

        XCTAssertEqual(input, output)
    }
    
    func testMultipleHashtagExclusion() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .hashtag, .url])
        let input = "#test #something"
        let output = cipher.encode(forString: input)

        XCTAssertEqual(input, output)
    }
    
    func testMultipleComplexHashtagExclusion() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .hashtag, .url])
        let input = "#test #something pedestrian"
        let output = cipher.encode(forString: input)

        XCTAssertEqual("#test #something crqrfgevna", output)
    }
    
    func testHashtagNonuse() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .url])
        let input = "#lame"
        let output = cipher.encode(forString: input)
        
        XCTAssertEqual(output, "#ynzr")
    }
    
    // MARK: -
    // MARK: URLs
    // MARK: -
    
    func testSimpleURLExclusion() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .hashtag, .url])
        let input = "https://waynehartman.com"
        let output = cipher.encode(forString: input)
        
        XCTAssertEqual(input, output)
    }
    
    func testMultipleURLExclusion() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .hashtag, .url])
        let input = "https://waynehartman.com http://apple.com"
        let output = cipher.encode(forString: input)
        
        XCTAssertEqual(input, output)
    }
    
    func testMultipleComplexURLExclusion() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .hashtag, .url])
        let input = "https://waynehartman.com testing http://apple.com"
        let output = cipher.encode(forString: input)

        XCTAssertEqual("https://waynehartman.com grfgvat http://apple.com", output)
    }
    
    func testURLNonuse() {
        let cipher = ROT13Cipher(exclusionExpressions: [.username, .hashtag])
        let input = "https://waynehartman.com"
        let output = cipher.encode(forString: input)
        
        XCTAssertEqual(output, "uggcf://jnlarunegzna.pbz")
    }
}
