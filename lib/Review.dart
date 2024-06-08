import 'package:flutter/material.dart';

void main() {
  runApp(MyAppReview());
}

class MyAppReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('تقييم التطبيق'),
        ),
        body: Center(
          child: ReviewButton(),
        ),
      ),
    );
  }
}

class ReviewButton extends StatelessWidget {
  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReviewDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showReviewDialog(context),
      child: Text('Review Application'),
    );
  }
}

class ReviewDialog extends StatefulWidget {
  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  String _review = '';
  int _rating = 1;

  void _submitReview() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle review submission
      print('Review: $_review');
      print('Rating: $_rating');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Review Application'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Your Review'),
              maxLines: 3,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your review';
                }
                return null;
              },
              onSaved: (value) {
                _review = value!;
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Rating'),
              value: _rating,
              items: [1, 2, 3, 4, 5]
                  .map((int value) => DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _rating = value!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitReview,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
