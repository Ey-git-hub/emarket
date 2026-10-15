import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
	const UserProfileScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Profile'),
				centerTitle: true,
			),
			body: Center(
				child: Padding(
					padding: const EdgeInsets.all(24),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Icon(
								Icons.person_outline,
								size: 96,
								color: Theme.of(context).colorScheme.primary,
							),
							const SizedBox(height: 20),
							Text(
								'Profile coming soon',
								style: Theme.of(context).textTheme.headlineSmall,
								textAlign: TextAlign.center,
							),
							const SizedBox(height: 8),
							Text(
								'Your profile information will appear here.',
								style: Theme.of(context).textTheme.bodyMedium,
								textAlign: TextAlign.center,
							),
						],
					),
				),
			),
		);
	}
}
