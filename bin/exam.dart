import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:yaml/yaml.dart';

final Logger logger = Logger(level: Level.verbose, theme: const LogTheme());

void main(List<String> args) {
  var runner = CommandRunner('exam', "Run evaluations and send them")
    ..addCommand(Test());

  runner.run(args).catchError((error) {
    if (error is UsageException) {
      logger.err(error.toString());
    } else {
      throw error;
    }
  });
}

class Test extends Command {
  @override
  String get name => "test";
  @override
  String get description => "Run the tests without sending them to server";

  Test() {
    argParser.addOption('string',
        abbr: 's', help: 'Name of exercise defined in exercises.yaml');
  }

  @override
  void run() {
    if (argResults == null || argResults!.rest.isEmpty) {
      logger.err("No exercise name provided");
      return;
    }

    if (!File('exercises.yaml').existsSync()) {
      logger.err('The exercises.yaml file does not exists');
      return;
    }

    final inputString = argResults!.rest[0];
    final yaml = loadYaml(File('exercises.yaml').readAsStringSync());
    List<String> exercises = [];

    try {
      if (yaml['exercises'] != null && yaml['exercises'] is List) {
        exercises = List<String>.from(yaml['exercises']);
      }
    } catch (e) {
      logger.err('Could not parse from exercises.yaml');
      return;
    }

    if (!exercises.contains(inputString)) {
      logger.warn(
          'The exercise called $inputString does not exists inside exercises.yaml');
      return;
    }

    String exerciseFileName =
        exercises.firstWhere((item) => item == inputString);

    String testPath = 'lib/$exerciseFileName/tests.dart';

    if (!File(testPath).existsSync()) {
      logger.err('The tests.dart file does not exists');
      return;
    }

    runTest(testPath);
  }

  void runTest(String testPath) async {
    var progress = logger.progress("Running tests");
    try {
      final result = await Process.run('flutter', ['test', testPath]);
      logger.info(result.stdout);
      progress.complete("Tests finished");
    } catch (e) {
      logger.err('Failed to run the tests: $e');
      progress.fail();
    }
  }
}
