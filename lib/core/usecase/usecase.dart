abstract class UseCase<Types, Params> {
  Future<Types> calls(Params param);
}

class NoParams {}
