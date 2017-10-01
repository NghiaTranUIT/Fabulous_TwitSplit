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

## How TwitSplit works

I categorize the TwitSplit into tiny components which each individual part is Single Reponsibility.
The first benefit we can see here. All of components are easily tested and customizable without messing to counter-part of code-base.

### Structure
For clearly,
+ TweetValidator: is responsible for validating the input sentence and return specific SplitError.
+ TweetExtractor: is responsible for extract whole sentence into each words.
+ TweetIndicator: is responsible for generating appropriate indicater with certain given format.
+ TweetComponent: is responsible for holding "array" of words in order to build TweetObj in the future when fulfill the specific requirement. This "array" of TweetComponent is constructed from a generic LinkedList<T>.
+ TweetBuilder: All main algorithm will run here. It plays important role in building appropriate TweetObj.
+ TweetSplitProcessor: An abstract class in order to coordinate the flow of all functions. It takes a sentense as an input -> Validate -> Extract -> Builder -> [TweetObj] -> Output
+ TweetConfiguration: The configuration of TweetSplitProcessor. It defines MaxCharacterCount and CharacterSet.
  
### Navie approach
This assignemtn could be solved by using 1 class with recusive function.
For instance,

```
func splitStringWithOrderNumber(orderNumber: Int = 1, numberMessage: Int, content: String) -> [String]? 
```

However, I don't want to give NaiveTweetSplit too many responsibilities to handle everythings. It's cumbersome and a nightmare when we extent or customize in the future.
Obviously, It's also hard for testing.

### My approach

1. Using while-loop to loop individual word and append into **TweetComponent** 
2. When the total count of words inside **TweetComponent** (replied on Indicator's count, Words' count, space) excess the Maximum -> Create new TweetInstance the appding to array again.
3. If not excess, keep appding each words into TweetComponet until it gets over.
4. When all of words are process -> We get the real total page count -> Come back and update each TweetComponents again
5. Calculate and re-build if the new Indicator's count has been excessed the Maximum again
6. Map to [TweetObj]

For clearly, all code + explanation are writen here
+ [TweetBuilder](https://github.com/NghiaTranUIT/Fabulous_TwitSplit/blob/master/TwitterCore/TwitterCore/Source%20Code/Service/TweetSplit/TweetBuilder.swift)
+ [TweetComponent](https://github.com/NghiaTranUIT/Fabulous_TwitSplit/blob/master/TwitterCore/TwitterCore/Source%20Code/Service/TweetSplit/TweetComponent.swift)

### Time complexity

In general sitation, the time complexity is O(n).
By using 1 while loop which are conjuction with LinkedList's append in order to improve.

## Diagrams

### Infrastructure
![alt text](https://raw.githubusercontent.com/NghiaTranUIT/Fabulous_TwitSplit/master/Diagrams/infrastructure.jpg)

### Twitter iOS app
![alt text](https://raw.githubusercontent.com/NghiaTranUIT/Fabulous_TwitSplit/master/Diagrams/twitter_app.jpg)

### Twitter Core
![alt text](https://raw.githubusercontent.com/NghiaTranUIT/Fabulous_TwitSplit/master/Diagrams/twitter_core.jpg)

