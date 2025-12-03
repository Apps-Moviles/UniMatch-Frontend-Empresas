// lib/features/reputations/data/api/reputation_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../shared/network/api_config.dart';
import '../../../../shared/network/api_client.dart';
import '../../domain/model/reputation.dart';

class ReputationApi {
  final String _endpoint = '/reputations';

  Future<List<Reputation>> getAllReputations() async {
    final http.Response response = await http.get(Uri.parse('$baseUrl$_endpoint'));

    if (response.statusCode != 200) {
      throw Exception('Error al obtener reputaciones');
    }

    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList
        .map((item) => Reputation.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Reputation>> getReputationsByStudentId(int studentId) async {
    final http.Response response = await ApiClient.get(
      _endpoint,
      queryParameters: {'studentId': studentId.toString()},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al obtener reputaciones por studentId');
    }

    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList
        .map((item) => Reputation.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Reputation>> getReputationsByProjectId(int projectId) async {
    final http.Response response = await ApiClient.get(
      _endpoint,
      queryParameters: {'projectId': projectId.toString()},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al obtener reputaciones por projectId');
    }

    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList
        .map((item) => Reputation.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Reputation> createReputation(Reputation reputation) async {
    // 1. obtener todas las reputaciones para calcular el próximo ID
    final List<Reputation> all = await getAllReputations();

    int nextId = 1;
    if (all.isNotEmpty) {
      nextId = all.map((r) => r.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
    }

    final Reputation newRep = reputation.copyWith(id: nextId);

    final http.Response response = await ApiClient.post(
      _endpoint,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newRep.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Error al crear reputación');
    }

    final Map<String, dynamic> json =
    jsonDecode(response.body) as Map<String, dynamic>;

    return Reputation.fromJson(json);
  }

  Future<void> deleteReputation(int id) async {
    final http.Response response = await ApiClient.delete('$_endpoint/$id');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Error al eliminar reputación');
    }
  }
}
