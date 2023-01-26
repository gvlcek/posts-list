# posts-list
Create an app that lists all messages and their details from JSONPlaceholder

## To run the project
- Just download the project and press play, it will work!

## Posts list
- The app starts in the Main storyboard, I was reading the documentation and Apple doesn't allow any longer to start the app from anything but a Storyboard.
- Every view is inside a xib file instead of a storyboard, this is something I do in order to minimize merging issues in bigger proyects
- I used MVP cause I find it easier to write tests
- To fetch the data in the class Webservices y used generics since the fetch process was the same for every object
- I wanted to keep it simple so I didn't use third party libraries to fetch the data since it was a very simple json, for more complex stuff I would go for Alamofire
- In order to save the favorites I went for CoreData because It was saind that native solutions were prefered over third party libraries and core data fits perfectlly in this project
- I added the localization for english and spanish
- As you can see I avoided using singletons. Previous experiences proved me that singletons get messy if there are too many so instead I used dependency injection
- The app is designed to work in light and dark mode, so try it!
- I always avoid what I call 'the magic numbers', so I created the struct Constants for every number and string have a name and purspose
- Pull to refresh in order to reload the posts
- Swipe to the left to delete one post
- Offline mode: if you don't have an internet connection I will show you the posts previously saved
- The cells have dynamic height, all done in xib files using autolayout
- Tap a post to see more details and it's comments
- Tap the star in order to add it to favorites, the favorites list is persisted if you close the app
- All the icons were used from xcodes SF Symbols

