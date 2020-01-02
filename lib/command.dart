typedef CommandAction = void Function();

class Command {
  static final Command nullCommand = Command(() {});

  CommandAction _action;

  Command(this._action);

  void execute() => _action();
}
