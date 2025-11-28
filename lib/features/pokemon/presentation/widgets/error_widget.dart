import 'package:flutter/material.dart';

import '../../../../core/constants/string_constants.dart';

class AppErrorWidget extends StatelessWidget 
{
  const AppErrorWidget({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (onRetry != null) ...[
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text(StringConstants.retryLabel),
          ),
        ],
      ],
    );
  }
}
