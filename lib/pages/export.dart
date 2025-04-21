import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mcbakap/utils/permission.dart';
import 'package:path_provider/path_provider.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({super.key});

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  final PermissionService _permissionService = PermissionService();
  List<FileSystemEntity> _files = [];
  bool _hasPermission = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final hasPermission = await _permissionService.checkPermission();
    if (hasPermission) {
      await _loadFiles();
    }
    setState(() {
      _hasPermission = hasPermission;
      _isLoading = false;
    });
  }

  Future<void> _requestPermission() async {
    final hasPermission = await _permissionService.requestPermission();
    if (hasPermission) {
      await _loadFiles();
    }
    setState(() {
      _hasPermission = hasPermission;
    });
  }

  Future<void> _loadFiles() async {
    try {
      Directory directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Android/data/com.mojang.minecraftpe/files/games/com.mojang/minecraftWorlds'); // Ruta de ejemplo en Android
      } else if (Platform.isLinux) {
        directory = Directory('${Platform.environment['HOME']}/.minecraft/saves');
      } else {
        directory = await getApplicationDocumentsDirectory(); // Ruta de ejemplo en otros sistemas
      }
      setState(() {
        _files = directory.listSync();
      });
    } catch (e) {
      setState(() {
        _files = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cree una copia de sus mundos'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasPermission
              ? _files.isNotEmpty
                  ? ListView.builder(
                      itemCount: _files.length,
                      itemBuilder: (context, index) {
                        final file = _files[index];
                        final imagePath = Platform.isAndroid
                            ? '${file.path}/world_icon.jpeg'
                            : '${file.path}/icon.png';
                        return ListTile(
                          leading: Image.file(File(imagePath), errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported);
                          }),
                          title: Text(file.path.split('/').last),
                        );
                      },
                    )
                  : const Center(child: Text('No se encontraron archivos.'))
              : Center(
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
                ),
    );
  }
}