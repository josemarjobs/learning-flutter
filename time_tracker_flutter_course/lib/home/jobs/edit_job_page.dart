import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerfluttercourse/custom_widgets/custom_raised_button.dart';
import 'package:timetrackerfluttercourse/custom_widgets/platform_alert_dialog.dart';
import 'package:timetrackerfluttercourse/custom_widgets/platform_exception_alert_dialog.dart';
import 'package:timetrackerfluttercourse/home/models/job.dart';
import 'package:timetrackerfluttercourse/services/database.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({
    @required this.database,
    this.job,
  }) : assert(database != null);

  final Database database;
  final Job job;

  static Future<void> show(BuildContext context, Job job) async {
    final database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditJobPage(database: database, job: job),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _ratePerHour;

  bool get isEdit => widget.job != null;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (!_validateAndSaveForm()) {
      print('invalid form');
      return;
    }

    if (!isEdit) {
      final List<Job> jobs = await widget.database.jobsStream().first;
      final allNames = jobs.map((j) => j.name).toList();
      if (allNames.contains(_name)) {
        await PlatformAlertDialog(
          title: 'Name already in use',
          content: 'Please choose a different job name',
          defaultActionText: 'OK',
        ).show(context);
        return;
      }
    }
    try {
      final job = Job(
        id: widget.job?.id ?? documentIdFromCurrentDate(),
        name: _name,
        ratePerHour: _ratePerHour,
      );
      await widget.database.setJob(job);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Failed to save job',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(isEdit ? 'Edit Job' : 'New Job'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: _submit,
          )
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        initialValue: isEdit ? widget.job.name : null,
        decoration: InputDecoration(labelText: 'Job name'),
        onSaved: (value) => _name = value,
        validator: (value) => value.isNotEmpty ? null : "name can't be empty",
      ),
      SizedBox(height: 16.0),
      TextFormField(
        initialValue: isEdit ? '${widget.job.ratePerHour}' : null,
        decoration: InputDecoration(labelText: 'Rate per hour'),
        validator: (value) {
          if (value.isEmpty) return null;
          return int.tryParse(value) != null
              ? null
              : "Rate per hour must be a number";
        },
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
      ),
      SizedBox(height: 24.0),
      CustomRaisedButton(
        color: Colors.indigo,
        child: Text(
          'Save',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        onPressed: _submit,
      )
    ];
  }
}
