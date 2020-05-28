import "dart:async";

import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/lista_produto.dart';
import 'package:cdma31/model/produto.dart';
import 'package:cdma31/model/user.dart';






// App user
StreamSubscription<User> userUpdateSubscription;

StreamSubscription<List<Lista>> listaSubscription;

StreamSubscription<List<ListaProduto>> listaProdutosSubscription;

StreamSubscription<List<Produto>> produtosSubscription;




/// Cancels all active subscriptions
///
/// Called on successful logout.
cancelAllSubscriptions() {
  userUpdateSubscription?.cancel();
  listaSubscription?.cancel();

}