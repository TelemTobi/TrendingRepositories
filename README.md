# Github Repos
> Trending repositories app - based on the official Github API.


## Table of Contents
* [Features](#features)
* [Architecture](#architecture)
* [iOS Frameworks](#ios-frameworks)
* [Third Party Frameworks](#third-party-frameworks)
* [Screenshots](#screenshots)


## Features
- **Main screen** is built with a custom colletion view **compositional layout**. it has three sections containing trending repositories this week, month and year.
- Each section can be extended to view all the repositories in an **infinite scrolling list**.
- Lists contain a **search option**, that executes on every character change.
- Repositories can be saved to the **Bookmarks screen** by tapping their bookmark button.
- **Details screen** containts more data about the repository and options to open the github page and the user profile.
- **Network errors** are handled by an error view which presents the option to try again.

## Architecture
- **MVVM**: The main architecture used thorough the entire app.

  Each view controller folder contains it's related view model. View models handle all business related tasks e.g. performing network calls and transforming model information into values that can be displayed on a view. 

- **Coordinator**: This pattern handles the entire app navigation flow. It helps keeping view controllers more manageable and more reusable, while also letting us adjust our app's flow whenever we need.

  AppCoordinator is the main coordinator, which holds the Tab Bar Controller as it's navigationController's root. this coordinator will handle any navigation outside of the tab bar screen when we'll need it in the future.
  
  Each tab flow has it's own coordinator with it's designated methods. Both tab coordinators inherit from TabBarEmbeddedCoordinator, which holds the methods they both need.
  
- **Networking Layer**: Located inside the Networking folder and managed by the Moya library, which encapsulates and simplifies the use of Alamofire.
  
  Github enum is the only target used at this point, containing a searchRepositories case, which recieves the desired time frame and the current page for repositories fetching. This target structure is ready for more cases to be added in the future.
  
  CodableResponses class contains common response wrappers, to simplify the access to the response data.


## iOS Frameworks
- **Combine**: Apple's reactive framework for handling events over time. It simplifies the code for dealing with things like delegates, notifications, completion blocks and callbacks.

  CurrentValueSubject and PassthroughSubject are the publishers mainly used through the app. for example, BaseViewModel which all view models inherit from, contains an isLoading publisher telling its subscribers to act accordingly, and an error message publisher that notifies every time an error has occured.

- **SafariServices**: Integrates Safari behaviors into the app.

  Used in the Repository details screen to present the github page or the user profile in safari.

## Third Party Frameworks
- **Moya**: Networking library focused on encapsulating network requests in a type-safe way.
  
  https://github.com/Moya/Moya
- **Kingfisher**: A pure-Swift library for downloading and caching images from the web.
  
  https://github.com/onevcat/Kingfisher
- **Hero**: A library for building view controller transitions.
  
  https://github.com/HeroTransitions/Hero

## Screenshots

<p align="center">
  <img src="/Screenshots/screenshot1.png" alt="Screenshot">
  <img src="/Screenshots/screenshot2.png" alt="Screenshot">
  <img src="/Screenshots/screenshot3.png" alt="Screenshot">
</p>





