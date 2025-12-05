// lib/features/reputations/domain/repository/reputation_repository.dart

import '../model/reputation.dart';

abstract class ReputationRepository {
  Future<List<Reputation>> getAllReputations();
  Future<List<Reputation>> getReputationsByProjectId(int projectId);
  Future<List<Reputation>> getReputationsByStudentId(int studentId);
  Future<Reputation> createReputation(Reputation reputation);
  Future<void> deleteReputation(int id);
}
