import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget 
{
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return const SizedBox(
      width: 48,
      height: 48,
      child: CircularProgressIndicator(strokeWidth: 3),
    ) ;
}
}
