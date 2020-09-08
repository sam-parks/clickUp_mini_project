# click_up_tasks

This is a Flutter Application built using ClickUp APIs. The application allows the user to select a team and view spaces, tasks, and lists for that selected team. 

## Overview

This application showcases the state management, UI and performance techniques I have learned while using Flutter. I used the BloC pattern in combination with Provider and ChangeNotifiers for handling state. I relied on stacks and flexible widgets for complex and dynamic layouts. Since this was a simple application, performance was not prioritized, but I did use an isolate for parsing JSON responses which did enhance the performance by a noticeable amount. 


**Task Page**

![Image of Task Page](https://user-images.githubusercontent.com/44235716/92432305-63fe0380-f15f-11ea-9a22-2ebc5793eb9d.jpeg)

**Select A Space**

![GIF of Space Selection](https://media.giphy.com/media/d8PjnAeXTp5Gz9FuFg/giphy.gif)



## State Management 

I used three BloCs to handle the state of the application. 

![Image of BloC Files](https://user-images.githubusercontent.com/44235716/92431340-e6d18f00-f15c-11ea-8ff8-b9837bc42b4c.png)

The Teams BloC is simple and retrieves ClickUp teams at the start of the application. The ClickUpList BloC handles the list page and builds ther UI based on reordering of the list. The Tasks Bloc does the most amount of work. It retrieves all of the items (folders, lists, tasks) for a space, saves those items in the sqflite database, and handles creating and deleting tasks. I am creating the BloCs at the top of the widget tree so I can access them throughout the app:


**BloC Creation**
```

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TeamsModel(),
        ),
        Provider(
          create: (_) => fluro.Router(),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => TeamsBloc()),
        BlocProvider(create: (_) => TaskBloc()),
        BlocProvider(create: (_) => ClickuplistBloc())
      ], child: App(_ProdConfig()))));
}
```
**BloC Access**
```
  // ignore: close_sinks
    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);
    // ignore: close_sinks
    ClickuplistBloc clickuplistBloc = BlocProvider.of<ClickuplistBloc>(context);
```

One thing I would change is refactoring the BloCs to have another BloC class that is dedicated to getting all items and saving them to sqflite, instead of the Task Bloc encompassing this functionality. I think this simplifies the code and makes it more maintanable as the Task page gets more functionality. 


