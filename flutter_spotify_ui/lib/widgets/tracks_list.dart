import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spotify_ui/data/data.dart';
import 'package:flutter_spotify_ui/models/current_track_model.dart';

class TracksList extends StatelessWidget {
  final List<Song> tracks;
  const TracksList({
    Key? key,
    required this.tracks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowHeight: 54.0,
      headingTextStyle:
          Theme.of(context).textTheme.overline!.copyWith(fontSize: 12.0),
      showCheckboxColumn: false,
      columns: [
        DataColumn(label: const Text('TITLE')),
        DataColumn(label: const Text('ARTIST')),
        DataColumn(label: const Text('ALBUM')),
        DataColumn(label: const Icon(Icons.access_time)),
      ],
      rows: tracks.map((e) {
        final selected =
            context.watch<CurrentTrackModel>().selected?.id == e.id;
        final textStyle = TextStyle(
            color: selected
                ? Theme.of(context).accentColor
                : Theme.of(context).iconTheme.color);
        return DataRow(
          cells: [
            DataCell(Text(e.title, style: textStyle)),
            DataCell(Text(e.artist, style: textStyle)),
            DataCell(Text(e.album, style: textStyle)),
            DataCell(Text(e.duration, style: textStyle)),
          ],
          selected: selected,
          onSelectChanged: (_) =>
              context.read<CurrentTrackModel>().selectTrack(e),
        );
      }).toList(),
    );
  }
}
