import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import 'package:unimatch_empresas/routes/app_routes.dart';
import '../../../companies/domain/model/company.dart';
import '../../../companies/ui/viewmodels/company_view_model.dart';
import '../../../users/domain/model/user.dart';
import '../../../users/ui/viewmodels/user_view_model.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController companyNameController;
  late TextEditingController nameController;
  late TextEditingController locationController;
  late TextEditingController sectorController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  String? _imageUrl;   // ← ahora guardará URL pública
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final userVM = Provider.of<UserViewModel>(context, listen: false);
    final companyVM = Provider.of<CompanyViewModel>(context, listen: false);

    final user = userVM.currentUser;
    final company = companyVM.companies.firstWhere(
          (c) => c.userId == user?.id,
      orElse: () => Company(
        id: 0,
        userId: 0,
        companyName: '',
        sector: '',
        location: '',
        email: '',
        phone: '',
        rating: 0.0,
        profilePicture: '',
        description: '',
      ),
    );

    companyNameController = TextEditingController(text: company.companyName);
    nameController = TextEditingController(text: user?.name ?? '');
    locationController = TextEditingController(text: company.location);
    sectorController = TextEditingController(text: company.sector);
    emailController = TextEditingController(text: company.email);
    phoneController = TextEditingController(text: company.phone);
    _imageUrl = company.profilePicture;
  }

  @override
  void dispose() {
    companyNameController.dispose();
    nameController.dispose();
    locationController.dispose();
    sectorController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  // -----------------------------------------------------------
  // PICK IMAGE
  // -----------------------------------------------------------
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    // Comprimir la imagen
    final compressedBytes = await FlutterImageCompress.compressWithFile(
      picked.path,
      quality: 70,
    );

    if (compressedBytes == null) return;

    // Guardar temporalmente para subir
    final file = File(picked.path);

    setState(() {
      _selectedImage = file;
    });
  }

  Future<String?> _uploadToFirebase(File image) async {
    try {
      final fileName = "company_${DateTime.now().millisecondsSinceEpoch}${path.extension(image.path)}";

      final ref = FirebaseStorage.instance
          .ref()
          .child("company_logos")
          .child(fileName);

      final uploadTask = await ref.putFile(image);
      final url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint("Error al subir imagen: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);
    final companyVM = Provider.of<CompanyViewModel>(context);
    final user = userVM.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Editar mi empresa',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD479),
                foregroundColor: Colors.black,
              ),
              child: const Text('Subir foto'),
            ),

            const SizedBox(height: 10),

            // Vista previa
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 120)
                : (_imageUrl != null && _imageUrl!.isNotEmpty)
                ? Image.network(_imageUrl!, height: 120)
                : Image.network(
              'https://cdn-icons-png.flaticon.com/512/149/149071.png',
              height: 120,
            ),

            const SizedBox(height: 20),

            customField('Empresa:', companyNameController),
            customField('Encargado:', nameController),
            customField('Ciudad/País:', locationController),
            customField('Sector:', sectorController),
            customField('Email:', emailController),
            customField('Celular:', phoneController),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Cancelar'),
                ),

                ElevatedButton(
                  onPressed: () async {
                    String? finalImageUrl = _imageUrl;

                    // Si el usuario seleccionó una nueva imagen → subirla
                    if (_selectedImage != null) {
                      final uploadedUrl =
                      await _uploadToFirebase(_selectedImage!);
                      if (uploadedUrl != null) {
                        finalImageUrl = uploadedUrl;
                      }
                    }

                    // Actualizar USER
                    final updatedUser = User(
                      id: user!.id,
                      name: nameController.text,
                      email: emailController.text,
                      password: user.password,
                      role: user.role,
                    );

                    // Actualizar COMPANY
                    final updatedCompany =
                    companyVM.companies.firstWhere(
                          (c) => c.userId == user.id,
                    ).copyWith(
                      companyName: companyNameController.text,
                      location: locationController.text,
                      sector: sectorController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      profilePicture: finalImageUrl ?? "",
                    );

                    userVM.updateUser(updatedUser);
                    companyVM.updateCompany(updatedCompany);

                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.profile,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD479),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Guardar cambios'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
