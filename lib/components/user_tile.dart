import 'package:flutter/material.dart';
import 'package:project_crud/models/user.dart';
import 'package:project_crud/provider/users.dart';
import 'package:project_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {

  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarURL == null || user.avatarURL.isEmpty
    ? CircleAvatar(child: Icon(Icons.person))
    : CircleAvatar(backgroundImage: NetworkImage(user.avatarURL));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget> [
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: (){
                Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Excluir Usuário'),
                      content: Text('Tem certeza?'),
                      actions: <Widget>[
                        FlatButton(
                            child: Text('Não'),
                            onPressed: () => Navigator.of(context).pop(false),
                        ),
                        FlatButton(
                          child: Text('Sim'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    )
                ).then((value) {
                  if(value){
                    Provider.of<Users>(context, listen: false).remove(user);
                  }
                });

              },
            ),
          ],
        ),
      ),
    );
  }
}
