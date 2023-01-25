//
//  CoreDataHelper.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 25/01/2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveFavorite(postId: Int, isFavorite: Bool) {
        // First I delete the object if already exists to avoid duplicates
        deleteExistingRecord(postId: postId)
        if isFavorite {
            let favoriteInstance = Favorite(context: context)
            favoriteInstance.postId = Int64(postId)
            favoriteInstance.isFavorite = isFavorite
            do {
                try context.save()
                print("Favorite saved")
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func fetchFavorites() -> [Favorite] {
        var fetchingFavorite = [Favorite]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreDataEntityFavorite)

        do {
            fetchingFavorite = try context.fetch(fetchRequest) as! [Favorite]
        } catch {
            print("Error while fetching the image")
        }
        return fetchingFavorite
    }

    func getFavoriteStatus(postId: Int) -> Favorite? {
        let favorites = fetchFavorites()
        let result = favorites.first(where: { $0.postId == postId })
        return result
    }

    private func deleteExistingRecord(postId: Int) {
        let fetchingFavorite = fetchFavorites()
        if let deleteFetch = fetchingFavorite.first(where: { $0.postId == postId }) {
            context.delete(deleteFetch)
            do {
                try context.save()
                print("Deleted record")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAll(entity: String) {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let deleteAll = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            try context.execute(deleteAll)
            do {
                try context.save()
                print("Deleted record")
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print("There was an error deleting core data records...")
        }
    }
    
    func savePosts(posts: [Post]) {
        deleteAll(entity: Constants.coreDataEntityPost)
        
        posts.forEach({
            let postsInstance = PostEntity(context: self.context)
            postsInstance.postId = Int16($0.postId)
            postsInstance.userId = Int16($0.userId)
            postsInstance.title = $0.title
            postsInstance.body = $0.body
        })
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadPosts() -> [Post] {
        var fetchingPost = [PostEntity]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreDataEntityPost)
        do {
            fetchingPost = try context.fetch(fetchRequest) as! [PostEntity]
        } catch {
            print("Error while fetching the image")
        }
        var posts: [Post] = []
        fetchingPost.forEach({
            let post = Post(userId: Int($0.userId), postId: Int($0.postId), title: $0.title ?? "", body: $0.body ?? "")
            posts.append(post)
        })
        return posts
    }
}
