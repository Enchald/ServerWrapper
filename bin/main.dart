import 'dart:io';
import 'dart:convert';
import 'config.dart';
import 'log.dart';

void main() async {
  print(cyan('Aurora ServerWrapper ') +
      'v' +
      yellow('0.1') +
      green('\nCopyright (C) 2021 ') +
      blue('AuroraTeam (https://github.com/AuroraTeam)'));

  var configFile = File('asw_config.json');
  if (!await configFile.exists()) {
    print(yellow('Config file not found! Create default'));
    await configFile.writeAsString(
        JsonEncoder.withIndent('  ').convert(Config.getDefault().toJson()));
  }
  var config = Config.fromJson(jsonDecode(await configFile.readAsString()));

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
