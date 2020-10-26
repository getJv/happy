import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:happy/models/Orphanage.dart';

class CreateOrphanageOne extends StatefulWidget {
  @override
  _CreateOrphanageOneState createState() => _CreateOrphanageOneState();
}

class _CreateOrphanageOneState extends State<CreateOrphanageOne> {
  int currentStep = 0;
  bool complete = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  next() {
    currentStep + 1 != steps().length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(
      () {
        currentStep = step;
      },
    );
  }

  StepState _getState(int i) {
    if (currentStep >= i)
      return StepState.complete;
    else
      return StepState.indexed;
  }

  List<Step> steps() {
    return <Step>[
      Step(
        title: const Text('O orfanato'),
        state: _getState(0),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome da instituição'),
              validator: (value) {
                if (value.length < 2) {
                  return 'Campo obrigatório';
                }
                return null;
              },
              onSaved: (value) => _formData['orphanage'] = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Sobre a instituição'),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onSaved: (value) => _formData['about'] = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.phone,
              onSaved: (value) => _formData['phone'] = value,
              validator: (value) {
                var potentialNumber = int.tryParse(value);
                if (potentialNumber == null) {
                  return 'Informe um telefone válido';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => _formData['email'] = value,
              validator: (value) {
                if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      Step(
        state: _getState(1),
        title: const Text('Visitação'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Instruções'),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onSaved: (value) => _formData['instructions'] = value,
              validator: (value) {
                if (value.length < 2) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Horário de atendimento'),
              onSaved: (value) => _formData['opening_hours'] = value,
              validator: (value) {
                if (value.length < 2) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Atende fim de semana'),
              onSaved: (value) => _formData['open_on_weekend'] = value,
              validator: (value) {
                if (value.length < 2) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      Step(
        state: _getState(2),
        title: const Text('Imagens'),
        subtitle: const Text("Fotos do orfanato"),
        content: Column(
          children: <Widget>[Text('área de captura de imagens')],
        ),
      ),
    ];
  }

  Widget stepperControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    return Row(
      children: [
        SizedBox(
          height: 70.0,
        ),
        FlatButton(
          color: Colors.blue,
          onPressed: onStepContinue,
          child: Text(
            'Continuar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        currentStep > 0
            ? FlatButton(
                onPressed: onStepCancel,
                child: Text('Voltar'),
              )
            : Container(),
      ],
    );
  }

  Future<Null> _saveForm() async {
    print('opaaaa');

    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    final newOrphanage = Orphanage(
      id: _formData['id'],
      name: _formData['name'],
      about: _formData['about'],
      instructions: _formData['instructions'],
      openingHours: _formData['opening_hours'],
      openOnWeekend: _formData['open_on_weekend'],
      phone: _formData['phone'],
    );

    print(newOrphanage);

    /* if (_formData['id'] == null) {
      try {
        await products.addProduct(newProduct);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Ocorreu um erro'),
                  content: Text(error.toString()),
                  actions: [
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ));
      } finally {
        setState(() {
          _isLoading = true;
        });
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        _isLoading = true;
      });
      Navigator.of(context).pop();
      products.updateProduct(newProduct);
    } */
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de orfanato'),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  _saveForm();
                })
          ],
        ),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(children: <Widget>[
            complete
                ? Expanded(
                    child: Center(
                      child: AlertDialog(
                        title: new Text("Profile Created"),
                        content: new Text(
                          "Tada!",
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              setState(() => complete = false);
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: Stepper(
                      steps: steps(),
                      currentStep: currentStep,
                      type: StepperType.vertical,
                      onStepContinue: next,
                      onStepTapped: (step) => goTo(step),
                      onStepCancel: cancel,
                      controlsBuilder: stepperControlBuilder,
                    ),
                  ),
          ]),
        ));
  }
}
