// lib/features/reputations/data/repository/reputation_repository_impl.dart

import 'package:unimatch_empresas/features/reputations/domain/model/reputation.dart';
import 'package:unimatch_empresas/features/reputations/domain/repository/reputation_repository.dart';

import '../api/reputation_api.dart';

class ReputationRepositoryImpl implements ReputationRepository {
  final ReputationApi api;

  ReputationRepositoryImpl(this.api);

  @override
  Future<List<Reputation>> getAllReputations() {
    return api.getAllReputations();
  }

  @override
  Future<List<Reputation>> getReputationsByProjectId(int projectId) {
    return api.getReputationsByProjectId(projectId);
  }

  @override
  Future<List<Reputation>> getReputationsByStudentId(int studentId) {
    return api.getReputationsByStudentId(studentId);
  }

  @override
  Future<Reputation> createReputation(Reputation reputation) {
    return api.createReputation(reputation);
  }

  @override
  Future<void> deleteReputation(int id) {
    return api.deleteReputation(id);
  }
}
