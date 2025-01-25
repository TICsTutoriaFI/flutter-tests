# Hello world

This activity ensures that you correctly installed the flutter SDK and you can run commands.

Also it will help you to get familiar with the workflow and usage of the CLI.

## Notes

For all the following exercises, all the code should be written inside the `main.dart` file using the provided method or class.

Remember to update the tests by changing the `skip: true` attribute in the tests to `false`, this will help you to make a better progress.

To run the tests you can use `flutter test path/to/tests.dart` (Not recommended)

Or you can use the following command:

```sh
dart run exam test <folder>
```

Where `<folder>` is the name of the parent folder which contain your `main.dart` file. This method should be preferred as it manages automagically the paths.

To send your exercise you should login with the given credentials and server from your tutor. This step is done once unless you delete the `flutter-tests` folder or the `.env.yaml` file.

```bash
dart run exam login <user> <password> <server>
```

Once you are done with your exercise and are ready to send your answer use:

Note: **Any skipped tests won't be sent, make sure to set to false the skip attribute**

```bash
dart run exam send <folder>
```

You will receive confirmation from the command.

## Instructions

Inside the `main.dart` you will find a function called `helloWorld`, modify so it returns:

> Hello world from Dart!

When the test is passed and not omitted you are good to go.
