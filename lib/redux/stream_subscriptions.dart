import "dart:async";

import 'package:cdma31/application.dart';
import 'package:cdma31/model/categoria.dart';
import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/lista_produto.dart';
import 'package:cdma31/model/produto.dart';
import 'package:cdma31/model/user.dart';






// App user
StreamSubscription<User> userUpdateSubscription;

StreamSubscription<List<Lista>> listaSubscription;

StreamSubscription<List<ListaProduto>> listaProdutosSubscription;

StreamSubscription<List<Produto>> produtosSubscription;

StreamSubscription<List<Categoria>> categoriaSubscription;





/// Cancels all active subscriptions
///
/// Called on successful logout.
cancelAllSubscriptions() {
//  userUpdateSubscription?.cancel();
  listaSubscription?.cancel();
  listaProdutosSubscription?.cancel();
  produtosSubscription?.cancel();
  categoriaSubscription?.cancel();
}