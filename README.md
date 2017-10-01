# Fabulous_TwitSplit
A Fabulous TwitSplit assignment.

## Requirement 
Navigate to workspace directory.
```
$ > pod install
```

## 3rd-parties 
+ RxSwift
+ RxCocoa

## System
+ iOS >= 9.3
+ Xcode 9 beta 4

## What've I done?
+ Twitter Core and Twitter App.
+ TwitSplit algorithm.
+ Well-organized TweetSplit's structure by categorizing it into tiny components, such as TweetIndicator, TweetExtractor, TweetConfigration, TweetComponent, TweetSplitProcessor, TweetBuilder and ValidateError.
+ Unit tests for all TwitSplit's components.
+ Easily extend or customize the appearance of TwitSplit's components.
+ Respected SOLID pricinple strictly.
+ Twitter Core and Twitter App are heavily dependencied on various abstract protocol instead of concrete classes.
+ MVVM architecture.
+ Using Linked-list as the core of TweetComponent in order to reduce the time complexity to O(1) than O(n) from ordinary array.
+ Binding mechanism.
+ Simple Router, Data Source for Twitter App.

## Achievements
+ Twitter Core framework takes 100% responsibilirty for Business logic.
+ Twitter App only is responsible for Application logic.
+ Each TweetSplit's component is single responesibility and no dependency on other parts. => Make it's testable.
+ ValidateError enum represent which kind of error. Make it clear
+ Twitter Core dones't care about UI. It works flawlessly with macOS or tvOS.
+ ViewModelCoordinator for handling all flow of ViewModels.
+ High flexibility to ship Twitter Core to community instead of encapsulating all-in-one in single project.
+ Twitter App only has acknowledgments about abstract ViewModel and abstract Presentor protocol in Twitter Core. It doesn't need to take care about what kind of technique, model objects, ... are behind the scene.
+ and minor hidden features ... ; ]

## What haven't I done (yet)?
+ Lack of Unit test for Twitter App
+ Few Side Effect in certain functions. For example, `func processTweetComponents(_ totalPage: Int = 1) -> TweetBuildResult` modify the Indicator variable which is external component.

## TwitSplit algorithm


## Unit test

wa
## Diagrams

### Infrastructure
![alt text](https://raw.githubusercontent.com/NghiaTranUIT/Fabulous_TwitSplit/master/Diagrams/infrastructure.jpg)

### Twitter iOS app
![alt text](https://raw.githubusercontent.com/NghiaTranUIT/Fabulous_TwitSplit/master/Diagrams/twitter_app.jpg)

### Twitter Core
![alt text](https://raw.githubusercontent.com/NghiaTranUIT/Fabulous_TwitSplit/master/Diagrams/twitter_core.jpg)

