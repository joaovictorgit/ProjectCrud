import 'package:flutter/material.dart';
import 'package:project_crud/models/user.dart';
import 'package:project_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user){

      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarURL'] = user.avatarURL;

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)!.settings.arguments as User;

    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              //final isValid = _form.currentState!.validate();
              //if(isValid){
                  _form.currentState!.save();
                  Provider.of<Users>(context, listen: false).put(User(
                  id: _formData['id'].toString(),
                  name: _formData['name'].toString(),
                  email: _formData['email'].toString(),
                  avatarURL: _formData['avatarURL'].toString(),
                ));
                Navigator.of(context).pop();
              //}

            },
            icon: Icon(Icons.save)
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),

                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                  initialValue: _formData['email'],
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['avatarURL'],
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formData['avatarURL'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
