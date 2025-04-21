import 'package:flutter/material.dart';
import 'package:mcbakap/utils/permission.dart';

class ImportPage extends StatefulWidget {
  const ImportPage({super.key});

  @override
  State<ImportPage> createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> {
  final PermissionService _permissionService = PermissionService();

  Future<bool> _checkPermission() async {
    return await _permissionService.checkPermission();
  }

  Future<void> _requestPermission() async {
    await _permissionService.requestPermission();
    setState(() {
      // Actualizar el estado después de solicitar el permiso
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccione un mundo'),
      ),
      body: FutureBuilder<bool>(
        future: _checkPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al verificar permisos'));
          } else if (snapshot.data == true) {
            return const Center(child: Text('Import Page'));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Permiso de acceso a todos los archivos no otorgado.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _requestPermission,
                    child: const Text('Otorgar permisos'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}