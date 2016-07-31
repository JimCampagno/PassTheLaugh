//  FirebaseAPIclient.swift
//  PassTheLaugh

import Firebase

final class Constants {
    static let storageURL = "gs://passthelaugh-614f2.appspot.com"
    static let testimage = "https://firebasestorage.googleapis.com/v0/b/passthelaugh-614f2.appspot.com/o/CuteDogCat.png?alt=media&token=ed59a5d8-29c4-47ed-b9b9-3e3a838672e9"
}

final class FirebaseAPIclient {
    static let sharedClient = FirebaseAPIclient()
    let ref = FIRDatabase.database().reference()
    let storage = FIRStorage.storage()
    
    init() { }
}

// MARK: - Downloading Image Methods
extension FirebaseAPIclient {
    
    static func downloadImageAtURL(url: String, completion: (UIImage?) -> ()) {
        guard let imageURL = NSURL(string: url) else { print("Bad URL"); completion(nil); return; }
        let session = NSURLSession.sharedSession()
        
        let downloadTask = session.downloadTaskWithURL(imageURL) { url, response, error in
            guard let imageDataURL = url, data = NSData(contentsOfURL: imageDataURL) else { print("Bad URL and/or Bad Data"); completion(nil); return }
            dispatch_async(dispatch_get_main_queue()) {
                let downloadedImage = UIImage(data: data)
                completion(downloadedImage)
            }
        }
        
        downloadTask.resume()
    }
    
}

