sealed class APIStrings {
  static String get postsEndpoint => 'posts';

  static String get defaultError => 'Что-то пошло не так, попробуйте ещё раз';

  static String get serverError => 'Не удалось подключиться к серверу';

  static String get connectionError => 'Нет подключения к интернету';

  static String get error500 => 'Внутренняя ошибка сервера. Попробуйте позже';
}

sealed class APIErrors {}
