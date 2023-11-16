import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/hiv/data/models/art_site.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_sites_repository.dart';
import 'package:nishauri/src/features/hiv/data/services/art_sites_service.dart';

final artSitesProvider = FutureProvider<List<ARTSite>>((ref) async {
  // Retrieve the authentication token from the authStateProvider
  await Future.delayed(const Duration(seconds: 5));
  final String token = ref.watch(authStateProvider);

  final service = ARTSitesService(token);
  final repo = ARTSitesRepository(service);
  return await repo.getSites();
});
