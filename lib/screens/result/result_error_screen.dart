import 'package:easychallenge/components/button.dart';
import 'package:flutter/material.dart';

class ResultErrorScreen extends StatelessWidget {
  ResultErrorScreen({
    required this.error,
    required this.onPressed,
    required this.onBack,
  });

  final String error;
  final VoidCallback onPressed;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
        leading: IconButton(
          onPressed: onBack,
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/img_system_error.png',
              width: 160,
              height: 160,
            ),
            Text(
              'Oooops...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Algo não saiu como planejado e as\n informações não foram'
                ' carregadas.',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Button(text: 'Tentar novamente', onPressed: onPressed),
            )
          ],
        ),
      ),
    );
  }
}
