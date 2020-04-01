import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerfluttercourse/custom_widgets/platform_alert_dialog.dart';
import 'package:timetrackerfluttercourse/custom_widgets/platform_exception_alert_dialog.dart';
import 'package:timetrackerfluttercourse/home/jobs/edit_job_page.dart';
import 'package:timetrackerfluttercourse/home/jobs/job_list_tile.dart';
import 'package:timetrackerfluttercourse/home/models/job.dart';
import 'package:timetrackerfluttercourse/services/auth.dart';
import 'package:timetrackerfluttercourse/services/database.dart';

class JobsPage extends StatelessWidget {
  void _signOut(BuildContext context) async {
    try {
      await Provider.of<AuthBase>(context).signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final signout = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);

    if (signout) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditJobPage.show(context, null),
        child: Icon(Icons.add),
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final db = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: db.jobsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          final children = jobs
              .map(
                (job) => JobListTile(
                  job: job,
                  onTap: () => EditJobPage.show(context, job),
                ),
              )
              .toList();
          return ListView(children: children);
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Some error occurred'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
