## Overview
Collection of splash screens for Godot Engine. Easy to use, fast Installing, multiple resolutions.
I used [GDAction](https://github.com/duongvituan/godot-action-animation-framework) for animation.

Run on Desktop:

![desktop](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/desktop_size.gif)

Run on mobile:

![mobile](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/mobile_size.gif)

You can use preview_demo to choose the right splash screen for your project:

![preview_demo](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/preview_demo.gif)

## Install and use

### Installation
Copy the contents of the plugins to the same folder in your project and activate AwesomeSplash and GDAction.


### How to use AwesomeSplash
1. Create folder src/collection_demo/ (if it doesn't exist then you can create src folder and demo_collection folder)
2. Copy demo splash you like to your project in to demo_collection folder.
(Note: If you copy to another folder, just fix the "Load failed due to missing dependencies" error by clicking "Fix Dependencies" and selecting your path.)
3. Create SplashContainer.
4. Drag and drop splash_screen.tscn to SplashContainer.


## QA:
### How to set main screen is AwesomeSplash.
In Godot engine: Select Project > Project Settings... > Application -> Run -> Main Scene: Select to your Screen Splash screen

### How to hide the default splash screen of Godot engine.
In Godot engine: Select Project > Project Settings... > Application -> Boot Splash -> Image: select (res://addons/awesome_splash/assets/None.png)


## Contribution
Contributions are welcome and are accepted via pull requests.

You can use Tween, AnimationPlayer or GDAction ...etc.. to create SplashScreen.

You can contribute code and submit pull or you can provide ideas and resources by creating an issue. :)


## License

[MIT License](https://github.com/duongvituan/godot-action-animation-framework/blob/master/LICENSE)

Copyright (c) 2021-present, [Duong Vi Tuan](https://github.com/duongvituan)