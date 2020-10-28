import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:happy/models/Orphanage.dart';
import 'package:happy/utils/routes.dart';

class CreateOrphanageOne extends StatefulWidget {
  @override
  _CreateOrphanageOneState createState() => _CreateOrphanageOneState();
}

class _CreateOrphanageOneState extends State<CreateOrphanageOne> {
  int currentStep = 0;
  bool complete = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSwitched = false;

  final _aboutFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _instructionsFocusNode = FocusNode();
  final _openingHoursFocusNode = FocusNode();
  final _openOnWeekendsFocusNode = FocusNode();

  final _nameController = TextEditingController();
  final _aboutController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _openingHoursController = TextEditingController();
  final _openOnWeekendsController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _aboutFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _instructionsFocusNode.dispose();
    _openingHoursFocusNode.dispose();
    _openOnWeekendsFocusNode.dispose();
  }

  void next() {
    currentStep + 1 != steps().length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  void cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  void goTo(int step) {
    setState(
      () {
        currentStep = step;
      },
    );
    if (step == 1) {
      FocusScope.of(context).requestFocus(_instructionsFocusNode);
    }
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
              autofocus: true,
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome da instituição'),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.length < 2) {
                  return 'Campo obrigatório';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_aboutFocusNode);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Sobre a instituição'),
              controller: _aboutController,
              focusNode: _aboutFocusNode,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_phoneFocusNode);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Telefone'),
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              focusNode: _phoneFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_emailFocusNode);
              },
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
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: _emailFocusNode,
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
              controller: _instructionsController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              focusNode: _instructionsFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_openingHoursFocusNode);
              },
              validator: (value) {
                if (value.length < 2) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Horário de atendimento'),
              controller: _openingHoursController,
              focusNode: _openingHoursFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_openOnWeekendsFocusNode);
              },
              validator: (value) {
                if (value.length < 2) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Aberto fim de semana:'),
                  SizedBox(),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    focusNode: _openOnWeekendsFocusNode,
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                ],
              ),
            )
          ],
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
        currentStep < steps().length - 1
            ? FlatButton(
                color: Colors.blue,
                onPressed: onStepContinue,
                child: Text(
                  'Continuar',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : FlatButton(
                color: Colors.blue,
                onPressed: () {
                  _saveForm();
                },
                child: Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
        currentStep > 0 && currentStep < steps().length - 1
            ? FlatButton(
                onPressed: onStepCancel,
                child: Text('Voltar'),
              )
            : Container(),
      ],
    );
  }

  Future<Null> _saveForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    try {
      await Firebase.initializeApp();
      final firestoreInstance = FirebaseFirestore.instance;

      var result = await firestoreInstance.collection("orphanages").add(
        {
          "name": _nameController.text,
          "latitude": null,
          "longitude": null,
          "about": _aboutController.text,
          "instructions": _instructionsController.text,
          "opening_hours": _openingHoursController.text,
          "phone": _phoneController.text,
          "open_on_weekend": isSwitched,
        },
      );
      var doc = await result.get();
      print(doc.data());
      Navigator.of(context).pushNamed(
        AppRoutes.CREATE_ORPHANAGE_DETAILS,
        arguments: {'orphanage': doc},
      );
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro'),
          content: Text(
            error.toString(),
          ),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de orfanato'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stepper(
                steps: steps(),
                currentStep: currentStep,
                type: StepperType.horizontal,
                onStepContinue: next,
                onStepTapped: (step) => goTo(step),
                onStepCancel: cancel,
                controlsBuilder: stepperControlBuilder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
