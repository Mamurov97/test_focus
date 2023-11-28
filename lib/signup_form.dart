import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        initialValue: const {
          'full_name': 'full_name',
          'email': 'email@gmail.com',
          'password': 'password',
          'confirm_password': 'password',
          'test': true
        },
        onChanged: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {}
          print(_formKey.currentState?.initialValue);
          print(_formKey.currentState?.value);
        },
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'full_name',
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'email',
              decoration: const InputDecoration(labelText: 'Email'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'password',
              decoration: InputDecoration(
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                focusColor: Theme.of(context).primaryColor,
                filled: true,
                errorMaxLines: 3,
                floatingLabelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                counterStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor),
                ),
                helperStyle: Theme.of(context).textTheme.bodySmall,
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).secondaryHeaderColor),
                errorStyle: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.error),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
              obscureText: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(6),
              ]),
              // validator: (v){
              //   return "holee";
              // },
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'confirm_password',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                suffixIcon: (_formKey.currentState?.fields['confirm_password']
                            ?.hasError ??
                        false)
                    ? const Icon(Icons.error, color: Colors.red)
                    : const Icon(Icons.check, color: Colors.green),
              ),
              obscureText: true,
              validator: (value) =>
                  _formKey.currentState?.fields['password']?.value != value
                      ? 'No coinciden'
                      : null,
            ),
            const SizedBox(height: 10),
            FormBuilderFieldDecoration<bool>(
              name: 'test',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.equal(true),
              ]),
              // initialValue: true,
              decoration: const InputDecoration(labelText: 'Accept Terms?'),
              builder: (FormFieldState<bool?> field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    errorText: field.errorText,
                  ),
                  child: SwitchListTile(
                    title: const Text(
                        'I have read and accept the terms of service.'),
                    onChanged: field.didChange,
                    value: field.value ?? false,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            MaterialButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                }
                print(jsonEncode(_formKey.currentState?.initialValue) == jsonEncode(_formKey.currentState?.value));
              },
              child:
                  const Text('Signup', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
