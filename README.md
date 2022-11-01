# Energy Monitor App

## Targets

App is divided in three targets:

1.  **Main App:** Contains Composers, ViewModels, View and Resources.
2.  **Energy Data Loader Feature**  Contains models, network client for downloading data and JSON Parsing and cache.
3.  **Chart Drawing Feature** Chart drawing functionality

![](/targets.png)

## Tests

![](/tests.png)

## External libraries

- SnapshotTesting for testing UI

https://github.com/pointfreeco/swift-snapshot-testing

## Snapahot tests

Snapshots were recorded using **Xcode Version 14** and **iPhone 13** simulator. Tests will fail when running them with different simulator or different Xcode version.

Light Mode             |  Dark Mode
:-------------------------:|:-------------------------:
![](/light.png)  |  ![](/dark.png)
## Energy Monitor App Architecture

![imagen](/architecture.png)