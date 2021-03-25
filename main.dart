import 'dart:io';
import 'dart:convert';
import 'package:ansicolor/ansicolor.dart';

void main() async {

  AnsiPen cyan = new AnsiPen()..cyan(bold: true);
  AnsiPen yellow = new AnsiPen()..yellow(bold: true);
  AnsiPen green = new AnsiPen()..green(bold: true);
  AnsiPen blue = new AnsiPen()..blue(bold: true);

  print(
    cyan("Aurora ServerWrapper ") +
    "v" +
    yellow("0.1") +
    green("\nCopyright (C) 2021 ") +
    blue("AuroraTeam (https://github.com/AuroraTeam)") // +
    // green(
    //   "\nThis program comes with ABSOLUTELY NO WARRANTY; for details type `license w'." +
    //   "\nThis is free software, and you are welcome to redistribute it under certain conditions; type `license c' for details."
    // )
  );

  // Оууу мааай
  String config = File('test.json').readAsStringSync();
  dynamic jsonConfig = JsonDecoder().convert(config);

  Process process = await Process.start('java', [
    // jsonConfig['params'],
    '-Dminecraft.api.auth.host=${jsonConfig['apiLink']}/auth',
    '-Dminecraft.api.account.host=${jsonConfig['apiLink']}/account',
    '-Dminecraft.api.session.host=${jsonConfig['apiLink']}/session',
    '-Dminecraft.api.services.host=${jsonConfig['apiLink']}/services',
    '-jar',
    jsonConfig['jar'],
  ]);

  process.stdin.addStream(stdin);
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
}