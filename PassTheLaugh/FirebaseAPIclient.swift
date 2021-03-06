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
    let storageRef = FIRStorage.storage().reference()
    
    init() { }
    
}

// MARK: - Downloading Image Methods
extension FirebaseAPIclient {
    
    static func downloadImageAtURL(_ url: String, completion: @escaping (UIImage?) -> ()) {
        guard let imageURL = NSURL(string: url) else { print("Bad URL"); completion(nil); return; }
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: imageURL as URL) { url, response, error in
            guard let imageDataURL = url, let data = NSData(contentsOf: imageDataURL) else { print("Bad URL and/or Bad Data"); completion(nil); return }
            DispatchQueue.main.async {
                let downloadedImage = UIImage(data: data as Data)
                completion(downloadedImage)
            }
        }
        
        downloadTask.resume()
    }
    
}

// MARK: - Uploading Image Methods
extension FirebaseAPIclient {
    
    static func uploadImage(_ image: UIImage, completion: @escaping (Bool) -> ()) {
        guard let data = UIImagePNGRepresentation(image) else { completion(false); return }
        
        // Create a reference to the file you want to upload
        let riversRef = FirebaseAPIclient.sharedClient.storageRef.child("images/test.png")
        
        _ = riversRef.put(data, metadata: nil) { metadata, error in
            if (error != nil) {
                print("error occurred, it is \(error)")
                print("An error occurred")
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL()
                print("Meta Data! \(downloadURL)")
                completion(true)
            }
        }
        
        
        
    }
    
}

