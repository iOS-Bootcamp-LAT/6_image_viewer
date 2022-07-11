//
//  __image_viewerTests.swift
//  6_image_viewerTests
//
//  Created by David Granado Jordan on 6/23/22.
//

import XCTest
@testable import image_viewer

class __image_viewerTests: XCTestCase {
    
    var vc: ViewController!
    var pVM: PhotoViewModel
    
    override func setUpWithError() throws {
        
        let bundle = Bundle(for: ViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        vc = (storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController)
        vc.title = "TITLE"
    
        vc.loadViewIfNeeded()
        
        pVM = PhotoViewModel()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        XCTAssertEqual(vc.title, "TITLEt")
        
        XCTAssertEqual(vc.collectionView.numberOfSections, 1 )
        
        let data = Data()
        
        pVM.saveSelectedImageInCoreData(withName: "test", withExtension: "jpeg", data: data, caption: "test") {
            
            XCTAssertEqual(self.pVM.numberOfItemsInSection, 1)
            
            
            let photo = self.pVM.getPhotoBy(index: 0)
            XCTAssertEqual(photo.photoDescription, "test")
            
        }
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
            for index in 0...5000 {
                
            }
            XCTAssertEqual(vc.title, "TITLE")
        }
    }

}
