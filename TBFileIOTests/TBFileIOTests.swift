//
//  TBFileIOTests.swift
//  TBFileIOTests
//
//  Created by Timothy Barrett on 4/6/16.
//
//

import XCTest
@testable import TBFileIO

class TBFileIOTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        FileIO.shared.purgeAllCreatedFolders()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        FileIO.shared.purgeAllCreatedFolders()
    }
    
    func testFileExistsAtPath() {
        XCTAssertFalse(FileIO.shared.fileExists("TestFolder"))
    }
    
    func testCreateFolderWithName() {
        XCTAssertNil(FileIO.shared.createFolder(withName: "MyFolder"))
        XCTAssertTrue(FileIO.shared.fileExists(FileIO.shared.documentsDirectory!.URLByAppendingPathComponent("MyFolder").path!))
    }
    
    func testCreateFolderWithExistingName() {
        XCTAssertNil(FileIO.shared.createFolder(withName: "MyFolder"))
        XCTAssertTrue(FileIO.shared.fileExists(FileIO.shared.documentsDirectory!.URLByAppendingPathComponent("MyFolder").path!))
        XCTAssertNotNil(FileIO.shared.createFolder(withName: "MyFolder"))
    }
    
    func testRemoveFolderWithName() {
        XCTAssertNil(FileIO.shared.createFolder(withName: "MyFolder_Test1"))
        XCTAssertTrue(FileIO.shared.fileExists(FileIO.shared.documentsDirectory!.URLByAppendingPathComponent("MyFolder_Test1").path!))
        XCTAssertNil(FileIO.shared.removeFolder(withName: "MyFolder_Test1"))
        XCTAssertFalse(FileIO.shared.fileExists(FileIO.shared.documentsDirectory!.URLByAppendingPathComponent("MyFolder_Test1").path!))
    }
    
    func testPurgeAllFolders() {
        XCTAssertNil(FileIO.shared.purgeAllCreatedFolders())
    }
    
    func testCreateObject() {
        XCTAssertNil(FileIO.shared.writeObjectToFile(destinationFolder: "MyFile", withObject: NSData(), withFileName: "TestFileName"))
    }
    
    func testRemoveFileInFolder() {
        XCTAssertNil(FileIO.shared.writeObjectToFile(destinationFolder: "MyFolder", withObject: NSData(), withFileName: "MyObject"))
        XCTAssertNil(FileIO.shared.removeFile(fromFolder: "MyFolder", fileName: "MyObject"))
    }
    
    func testRemoveFileInFolderFileDoesNotExist() {
        XCTAssertNotNil(FileIO.shared.removeFile(fromFolder: "MyFolder", fileName: "MyObject"))
    }
    
    func testListAllFolders() {
        XCTAssertNil(FileIO.shared.createFolder(withName: "MyFolder"))
        XCTAssertNil(FileIO.shared.createFolder(withName: "MyFolder1"))
        XCTAssertEqual(FileIO.shared.listFolders()?.count, 2)
    }
    
}
