//
//  Firebase.swift
//  Pizza-showcase
//
//  Created by Ruslan Ismailov on 14/01/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

protocol FirestoreImageDataSend {
    func getImage(picName: String, imageType: ImageType, completion: @escaping (UIImage) -> Void)
}

enum ImageType {
    case banners
    case pizzas
}

class FirebaseManager: FirestoreImageDataSend {
    static let shared = FirebaseManager()
    private func configureFirebase() -> Firestore {
        var database: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        database = Firestore.firestore()
        return database
    }
    func getItem(collection: String, docName: String, completion: @escaping (Pizza?) -> Void) {
        let database = configureFirebase()
        database.collection(collection).document(docName).getDocument { document, error in
            guard error == nil else {
                completion(nil)
                return
            }
            let doc = Pizza(
                nameOfPizza: document?.get("name") as? String ?? "",
                image: document?.get("imageName") as? String ?? "",
                description: document?.get("description") as? String ?? "",
                price: document?.get("price") as? String ?? "",
                category: document?.get("category") as? String ?? "")
            completion(doc)
        }
    }
    func getItems(collection: String, docName: String, completion: @escaping ([String]?) -> Void) {
        let database = configureFirebase()
        database.collection(collection).document(docName).getDocument { document, error in
            guard error == nil else {
                completion(nil)
                return
            }
            
            let doc = document?.get("items") as? [String]
            completion(doc)
        }
    }
    func getBanners(collection: String, docName: String, completion: @escaping ([String]?) -> Void) {
        let database = configureFirebase()
        database.collection(collection).document(docName).getDocument { document, error in
            guard error == nil else {
                completion(nil)
                return
            }
            let doc = document?.get("baners") as? [String]
            completion(doc)
        }
    }
    func getImage(picName: String, imageType: ImageType, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        var pathRef = reference.child("")
        var image: UIImage = UIImage(named: "pizzaDefault")!
        switch imageType {
        case .banners:
            image = UIImage(named: "BanerTest")!
            pathRef = reference.child("Banners")
        case .pizzas:
            pathRef = reference.child("pizzasCollection")
        }
        let fileRef = pathRef.child(picName + ".png")
        fileRef.getData(maxSize: 1024*1024) { data, error in
            guard error == nil else {
                completion(image)
                return
            }
            guard let data = data else {
                completion(image)
                return
            }
            image = UIImage(data: data)!
            completion(image)
        }
    }
}
