import 'package:flutter/material.dart';

import '../../core/env/env.dart';
import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Text(
        Env.instance.get('backend_base_url'),
      ),
      bottomNavigationBar: FloatingActionButton(
        onPressed: () async {
          showLoader();
          await Future.delayed(const Duration(seconds: 2));
          hideLoader();

          showError('Erro de alguma coisa');
        },
        child: const Icon(Icons.abc),
      ),
    );
  }
}
