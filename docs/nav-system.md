# PagesProvider Documentation

# Important
## Actual pages defined inside `pages.dart`

## Overview
The `PagesProvider` class is a state management class designed to handle navigation between different pages in a Flutter application. It utilizes the ChangeNotifier mixin to notify listeners about changes in the current page or available pages.

## Constructed from:
- startingPage: Page that will be in currentPage by default;
- availablePages: Pages to which provider will have access
    - Note: If you will try to call setPage for not available page, you will get exception. (Probably should have wrap it in some kind of #if(dev) directive, but dart do not have them by default)

## Methods

### addPage
**Description**: Dynamically adds a new available page to the list of pages.  
- **Parameter**: `Pages value` - The page to be added.
- **Usage**: Use this method when you want to introduce new pages into the navigation system.

### removePage
**Description**: Dynamically removes an available page from the list of pages.  
- **Parameter**: `Pages value` - The page to be removed.
- **Usage**: This method can be used when a page is no longer needed and should be removed from the navigation options.

### setPage
**Description**: Changes the current page to a specified page.  
- **Parameter**: `Pages value` - The page to set as the current active page.
- **Usage**: Use this method to navigate to a different page that is already available in the list of pages.

### getCurrentPage
**Description**: Returns the current active page or a 404 Not Found page if the current page is not available.  
- **Return Type**: `Widget` - The current page widget or a fallback widget indicating not found.
- **Usage**: This is used to fetch the widget representation of the current page in the UI. 

### getAvailablePages
**Description**: Returns an iterable list of currently available pages.  
- **Return Type**: `Iterable<Pages>` - A collection of pages that are available for navigation.
- **Usage**: Useful for displaying or managing the pages that can be navigated to.

### getPageByIndex
**Description**: Retrieves a page by its index in the available pages list.  
- **Parameter**: `int index` - The index of the page to retrieve.
- **Return Type**: `Widget` - The widget corresponding to the specified index.
- **Usage**: Use this method when you need to access a page using its index.

### getPageIndexByName
**Description**: Returns the index of a specific page by its name.  
- **Parameter**: `Pages name` - The page whose index is to be found.
- **Return Type**: `int` - The index of the specified page.
- **Usage**: This method is helpful for determining the position of a page within the available pages.

### getPageNameByIndex
**Description**: Retrieves the page name based on its index in the available pages list.  
- **Parameter**: `int index` - The index of the page to retrieve the name for.
- **Return Type**: `Pages` - The page corresponding to the specified index.
- **Usage**: Use this to get a page name when you have its index and need to work with the page itself.

## Notes
- The `notifyListeners()` method is called after any state-changing operations to ensure that the UI stays in sync with the provider state.

# Usage Example

## Provider registration

```dart
ChangeNotifierProvider(
    create: (context) => PagesProvider<App>( // <-- create provider for specific target
    startingPage: Pages.devPage, // <-- Page to start from
    availablePages: [Pages.devPage], // <-- All pages available from App's pages provider
    ),
),

```
## Provider usage

```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var pageProvider = Provider.of<PagesProvider<App>>(context);
    return pageProvider.getCurrentPage();
  }
}
```

 