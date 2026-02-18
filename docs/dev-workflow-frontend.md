
# Frontend Workflow

## Separate page was created for every developer.
```dart
ChangeNotifierProvider(
    create: (context) => PagesProvider<DevPage>(
    startingPage: Pages.deskPage,
    awaiblePages: [
        Pages.artyom,
        Pages.maxim,
        Pages.misha,
        Pages.alexiy,
        Pages.deskPage,
    ],
    ),
),
```
## Idea is

### 1. Every developer will create some widgets, render them isinde their own page. All widgets will be stored inside shared `widgets/` directory.

<div style="text-align: center;">
  <img src="public\1.png" style="max-width: 100%; height: auto;">
  <p>Picture 1. Developer page.</p>
</div>

### 2. Actual page will be assembled from created widgets.

<div style="text-align: center;">
  <img src="public\2.png" style="max-width: 100%; height: auto;">
  <p>Picture 2. Assembled page preview.</p>
</div>

### 3. Dev pages will be removed from realese version of application.
