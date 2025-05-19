import 'package:flutter/material.dart';

class NovoUtilizador extends StatefulWidget {
  const NovoUtilizador({super.key});

  @override
  State<NovoUtilizador> createState() => _NovoUtilizadorState();
}

class _NovoUtilizadorState extends State<NovoUtilizador> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController codigoPostalController = TextEditingController();
  final TextEditingController moradaController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController paisController = TextEditingController();
  final TextEditingController utenteController = TextEditingController();
  final TextEditingController observacoesController = TextEditingController();

  bool aceiteTermos = false;

  void _submitForm() {
    if (_formKey.currentState!.validate() && aceiteTermos) {
      // Aqui pode tratar os dados
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registo submetido com sucesso')),
      );
    } else if (!aceiteTermos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('É necessário aceitar os termos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(color: Colors.white70);
    const inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.black54,
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        title: const Text('Registo'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'MEDITRACK',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildField('Nome', nomeController, labelStyle, inputDecoration),
              _buildField('Email', emailController, labelStyle, inputDecoration, keyboard: TextInputType.emailAddress),
              _buildField('Telefone', telefoneController, labelStyle, inputDecoration, keyboard: TextInputType.phone),
              _buildField('Código Postal', codigoPostalController, labelStyle, inputDecoration),
              _buildField('Morada', moradaController, labelStyle, inputDecoration),
              _buildField('Cidade', cidadeController, labelStyle, inputDecoration),
              _buildField('País', paisController, labelStyle, inputDecoration),
              _buildField('Número de Utente', utenteController, labelStyle, inputDecoration),
              _buildField('Observações', observacoesController, labelStyle, inputDecoration, maxLines: 3),

              const SizedBox(height: 16),
              CheckboxListTile(
                value: aceiteTermos,
                onChanged: (value) => setState(() => aceiteTermos = value ?? false),
                title: const Text('Aceito os termos', style: TextStyle(color: Colors.white)),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.lightBlue,
              ),

              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Submeter',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, TextStyle labelStyle,
      InputDecoration decoration,
      {TextInputType keyboard = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: labelStyle),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboard,
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white),
            decoration: decoration,
            validator: (value) => (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
          ),
        ],
      ),
    );
  }
}
