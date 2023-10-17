import 'package:flutter_gym/constanst.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class InitCrud {
  static init() async {
    String productTab =
        'CREATE TABLE [Product](  [id] INTEGER PRIMARY KEY AUTOINCREMENT,  [NameProduct] NVARCHAR, [PriceProduct] DOUBLE );  ';

    String orderRowTab =
        'CREATE TABLE [OrderRow](  [id] INTEGER PRIMARY KEY AUTOINCREMENT,   [ProductId] INT NOT NULL DEFAULT 0, [OrderId] INT NOT NULL DEFAULT 0,   [Qty] INT DEFAULT 0); ';

    String orderRowView =
        'CREATE VIEW OrderRowView AS SELECT R.id,   R.ProductId,  P.NameProduct AS "ProductName",  P.PriceProduct,  R.Qty  FROM OrderRow R  LEFT JOIN Product P ON P.id = R.ProductId;';

    String usersTab = ' CREATE TABLE [users](  ' +
        '        [id] INTEGER PRIMARY KEY AUTOINCREMENT,   ' +
        '         [Login] NVARCHAR NOT NULL DEFAULT "", ' +
        '         [Password] NVARCHAR NOT NULL DEFAULT "", [IsRemember] BOOL NOT NULL DEFAULT false ); ';

//====================================================================
    String order_head = 'CREATE TABLE [order_head](  ' +
        '[id] INTEGER PRIMARY KEY AUTOINCREMENT,   ' +
        '[user_id] INTEGER NOT NULL,  ' +
        '[data_order] DATETIME NOT NULL ); ';

    String order_detail = ' CREATE TABLE [order_detail]( ' +
        '[id] INTEGER PRIMARY KEY AUTOINCREMENT,  ' +
        '[order_id] INTEGER NOT NULL, ' +
        '[tovar_id] INTEGER NOT NULL, ' +
        '[qty] INTEGER NOT NULL DEFAULT 0 ); ';

    String order_detail_view = ' CREATE VIEW order_detail_view AS ' +
        'SELECT ' +
        'd.id,  ' +
        'd.order_id, ' +
        'd.tovar_id, ' +
        'P.NameProduct, ' +
        'P.PriceProduct, ' +
        'd.qty, ' +
        'IFNULL((P.PriceProduct * d.qty), 0) as sum_row ' +
        'FROM  ' +
        'order_detail d LEFT JOIN Product P ' +
        'ON P.id = d.tovar_id; ';

    String order_head_view = ' CREATE VIEW order_head_view AS ' +
        'SELECT ' +
        'h.id, ' +
        'h.user_id,  ' +
        'h.data_order,  ' +
        'SUM(IFNULL(d.sum_row, 0)) as total_sum  ' +
        'FROM ' +
        'order_head h LEFT JOIN order_detail_view d  ' +
        'ON h.id = d.order_id  ' +
        'GROUP BY h.id, h.user_id, h.data_order; ';

    //====================================================================

    String ins1 =
        'INSERT INTO Product (NameProduct, PriceProduct) values(\"Pizza Piperoni\", 50.0);';
    String ins2 =
        'INSERT INTO Product (NameProduct, PriceProduct) values(\"Pizza Four taste\", 150.0);';
    String ins3 =
        'INSERT INTO Product (NameProduct, PriceProduct) values(\"Pizza Margarita\", 80.0);';

    getDatabasesPath().then((String strPath) {
      String path = join(strPath, dbName);
      try {
        final database = openDatabase(path, onCreate: (db, version) async {
          await db.execute(productTab);
          await db.execute(usersTab);

          await db.execute(ins1);
          await db.execute(ins2);
          await db.execute(ins3);

          await db.execute(orderRowTab);
          await db.execute(orderRowView);

          await db.execute(order_head);
          await db.execute(order_detail);
          await db.execute(order_detail_view);
          await db.execute(order_head_view);

          print('DB created');
        }, version: 1);
      } catch (e) {
        print(e);
      }
    });
  }
}
