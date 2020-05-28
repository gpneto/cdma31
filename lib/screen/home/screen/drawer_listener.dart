import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../application.dart';

class DrawerListener extends StatefulWidget {
  final Widget child;
  final ValueChanged<FractionalOffset> onPositionChange;

  DrawerListener({
    @required this.child,
    this.onPositionChange,
  });

  @override
  _DrawerListenerState createState() => _DrawerListenerState();
}

class _DrawerListenerState extends State<DrawerListener> {
  GlobalKey _drawerKey = GlobalKey();
  int taskID;
  Offset currentOffset;

  @override
  void initState() {
    super.initState();
    _postTask();
  }

  _postTask() {
    taskID = SchedulerBinding.instance.scheduleFrameCallback((_) {
      if (widget.onPositionChange != null) {
        final RenderBox box = _drawerKey.currentContext?.findRenderObject();
        if (box != null) {
          Offset newOffset = box.globalToLocal(Offset.zero);
          if (newOffset != currentOffset) {
            currentOffset = newOffset;
            widget.onPositionChange(
              FractionalOffset.fromOffsetAndRect(
                currentOffset,
                Rect.fromLTRB(0, 0, box.size.width, box.size.height),
              ),
            );
          }
        }
      }

      _postTask();
    });
  }

  @override
  void dispose() {
    SchedulerBinding.instance.cancelFrameCallbackWithId(taskID);
    if (widget.onPositionChange != null) {
      widget.onPositionChange(FractionalOffset(1.0, 0));
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _drawerKey,
      child: widget.child,
    );
  }
}