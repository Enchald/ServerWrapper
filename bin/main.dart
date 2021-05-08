import 'dart:io';
import 'dart:convert';
import 'config.dart';
import 'log.dart';

void main() async {
  print(
    cyan('Aurora ServerWrapper ') +
    'v' +
    yellow('0.1') +
    green('\nCopyright (C) 2021 ') +
    blue('AuroraTeam (https://github.com/AuroraTeam)')
  );

  Config config;
  try {
    var cfgFile = File('asw_config.json').readAsStringSync();
    config = Config.fromJson(jsonDecode(cfgFile));
  } on FileSystemException {
    print(yellow('Config file not found! Create default'));
    config = Config.getDefault();
    File('asw_config.json').writeAsStringSync(JsonEncoder.withIndent('  ').convert(config.toJson()));
  }

  var process = await Process.start('java', [
    '-Dminecraft.api.auth.host=${config.authlibLink}',
    '-Dminecraft.api.account.host=${config.authlibLink}',
    '-Dminecraft.api.session.host=${config.authlibLink}',
    '-Dminecraft.api.services.host=${config.authlibLink}',
    '-jar',
    config.jar,
    ...config.params,
  ]);

  // ignore_for_file: unawaited_futures
  process.stdin.addStream(stdin);
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
}