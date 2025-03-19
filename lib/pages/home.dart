import 'package:flutter/material.dart';
import 'package:mcbakap/pages/export.dart';
import 'package:mcbakap/pages/import.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedPage = 'Exportar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MCBakap'),
        actions: [
          
          // Boton de Exportar
          TextButton(
            onPressed: () {
              setState(() {
                _selectedPage = 'Exportar';
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: _selectedPage == 'Exportar' ? Colors.yellow : Colors.transparent,
            ),
            child: Text(
              'Exportar',
              style: TextStyle(
                color: _selectedPage == 'Exportar' ? Colors.black : Colors.white,
                fontWeight: _selectedPage == 'Exportar' ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),

          // Boton de Importar
          TextButton(
            onPressed: () {
              setState(() {
                _selectedPage = 'Importar';
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: _selectedPage == 'Importar' ? Colors.yellow : Colors.transparent,
            ),
            child: Text(
              'Importar',
              style: TextStyle(
                color: _selectedPage == 'Importar' ? Colors.black : Colors.white,
                fontWeight: _selectedPage == 'Importar' ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
      body: _getPage(),
    );
  }

  Widget _getPage() {
    switch (_selectedPage) {
      case 'Exportar':
        return const ExportPage();
      case 'Importar':
        return const ImportPage();
      default:
        return const Center(child: Text('Bienvenido a MCBakap. Seleccione una opción en el menú de arriba.'));
    }
  }
}