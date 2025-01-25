import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:yaml/yaml.dart';
import 'package:settings_yaml/settings_yaml.dart';
import 'package:pocketbase/pocketbase.dart';

final Logger logger = Logger(level: Level.verbose, theme: const LogTheme());
AsyncAuthStore store = AsyncAuthStore(
  save: (String data) async {
    await Future(() {
      final settings = SettingsYaml.load(pathToSettings: '.env.yaml');
      settings['auth'] = jsonDecode(data);
      settings.save();
    });
  },
  initial: jsonEncode(
      SettingsYaml.load(pathToSettings: '.env.yaml').selectAsMap('auth')),
);

void main(List<String> args) {
  var runner = CommandRunner('exam', "Run evaluations and send them")
    ..addCommand(Test())
    ..addCommand(Login())
    ..addCommand(Send());

  runner.run(args).catchError((error) {
    if (error is UsageException) {
      logger.err(error.toString());
    } else {
      throw error;
    }
  });
}

bool exercisesYamlExists() {
  if (!File('exercises.yaml').existsSync()) {
    logger.err('The exercises.yaml file does not exists');
    return false;
  }
  return true;
}

Future<Map<String, dynamic>> runTest(String inputString, bool isServer) async {
  final yaml = loadYaml(File('exercises.yaml').readAsStringSync());
  List<String> exercises = [];

  try {
    if (yaml['exercises'] != null && yaml['exercises'] is List) {
      exercises = List<String>.from(yaml['exercises']);
    }
  } catch (e) {
    logger.err('Could not parse from exercises.yaml');
    return {};
  }

  if (!exercises.contains(inputString)) {
    logger.warn(
        'The exercise called $inputString does not exists inside exercises.yaml');
    return {};
  }

  String exerciseFileName = exercises.firstWhere((item) => item == inputString);

  String testPath = 'lib/$exerciseFileName/tests.dart';
  String exercisePath = 'lib/$exerciseFileName/main.dart';

  if (!File(testPath).existsSync()) {
    logger.err('The tests.dart file does not exists');
    return {};
  }

  var progress = logger.progress("Running tests");
  try {
    final result = isServer
        ? await Process.run('flutter', ['test', testPath, '-r', 'expanded'])
        : await Process.run('flutter', ['test', testPath]);
    if (!isServer) logger.info(result.stdout);
    progress.complete("Tests finished");
    return {
      'code': File(exercisePath).readAsStringSync(),
      'tests': result.stdout.toString().split('\n'),
    };
  } catch (e) {
    logger.err('Failed to run the tests: $e');
    progress.fail();
    return {};
  }
}

class Send extends Command {
  @override
  String get description => 'Send exercise to server';

  @override
  String get name => 'send';

  @override
  void run() async {
    if (argResults == null || argResults!.rest.isEmpty) {
      logger.err("No exercise name provided");
      return;
    }

    if (!exercisesYamlExists()) return;

    Map<String, dynamic> result = await runTest(argResults!.rest[0], true);

    var sending = logger.progress('Sending answer');

    SettingsYaml config = SettingsYaml.load(pathToSettings: '.env.yaml');

    PocketBase pb = PocketBase(config['url'], authStore: store);

    final Map<String, dynamic> body = {
      "user": pb.authStore.record!.id,
      "exercise": argResults!.rest[0],
      "result": result,
    };

    try {
      await pb.collection('exercises').create(body: body);
      sending.complete('Answer succefully sent');
    } catch (e) {
      sending.fail("Couldn't send answer. Did you login?");
      logger.err('Error: $e');
    }
  }
}

class Test extends Command {
  @override
  String get name => "test";
  @override
  String get description => "Run the tests without sending them to server";

  @override
  void run() async {
    if (argResults == null || argResults!.rest.isEmpty) {
      logger.err("No exercise name provided");
      return;
    }

    if (!exercisesYamlExists()) return;

    await runTest(argResults!.rest[0], false);
  }
}

class Login extends Command {
  @override
  String get description => 'Login to send answers';

  @override
  String get name => 'login';

  @override
  void printUsage() {
    logger.info('`Use exam login <user> <password> <server>`');
  }

  @override
  void run() async {
    if (argResults == null || argResults!.rest.length != 3) {
      logger.err('Missing arguments');
      printUsage();
      return;
    }

    var loggingIn = logger.progress('Trying to log in');

    SettingsYaml config = SettingsYaml.load(pathToSettings: '.env.yaml');

    config['url'] = argResults!.rest[2];

    PocketBase pb = PocketBase(config['url'], authStore: store);

    try {
      await pb
          .collection('users')
          .authWithPassword(argResults!.rest[0], argResults!.rest[1]);

      if (pb.authStore.isValid) {
        loggingIn.complete('Succesfully logged in');
      }
    } catch (e) {
      loggingIn.fail('Cannot login, check your credentials and server');
    }

    config.save();
  }
}
