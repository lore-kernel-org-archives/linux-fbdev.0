From: James Hogan <james@albanarts.com>
Date: Fri, 07 Jan 2011 12:55:09 +0000
Subject: Recursive lock in fbcon after unblank and modelist change
Message-Id: <AANLkTinpmkgRCk_NHBFTWcoMs5gPtqgxxBP0W3wQYBGE@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

I'm hitting the following recursive locking problem when unblanking
the framebuffer (echoing 3 then 0 to /sys/class/graphics/fb0/blank).

Basically this is what's happening:
* the fb_blank function sends the blank notification
* fbcon gets the blank notification, and calls fbcon_switch
* fbcon_switch calls fb_set_var
* fb_set_var actually makes a change, which triggers another
notification (mode change), which tries to lock fb_notifier_list.rwsem
again, which triggers the lockdep warning (and presumably potentially
a deadlock).

The reason fb_set_var makes a change is because the mode list has been
updated since the last mode change, so the current mode is effectively
out of date. E.g. this could be done by writing to
/sys/class/graphics/fb0/modes, or in my case an HDMI driver updates
the modelist on a monitor hotplug event after reading the EDID in the
same way as the sysfs interface.

So, a few questions:
(1) Is this situation a valid situation, where the modelist has been
overwritten but current mode left unchanged?
(2) If (1), any ideas how the recursive locking situation should be resolved?
(3) If not (1), should updating the modelist using sysfs (and
similarly on a monitor hotplug event), also update the current mode to
the nearest mode in the list (fb_new_modelist would seem an
appropriate place)?

Thanks
James

======================[ INFO: possible recursive locking detected ]
2.6.37-rc7+ #1435
---------------------------------------------
sh/382 is trying to acquire lock:
 ((fb_notifier_list).rwsem){.+.+.+}, at: [<40040a60>]
___blocking_notifier_call_chain+0x34/0x80

but task is already holding lock:
 ((fb_notifier_list).rwsem){.+.+.+}, at: [<40040a60>]
___blocking_notifier_call_chain+0x34/0x80

other info that might help us debug this:
3 locks held by sh/382:
 #0:  (&buffer->mutex){+.+.+.}, at: [<400e8ab0>] _sysfs_write_file+0x38/0x1a4
 #1:  (s_active#13){.+.+.+}, at: [<400e8ba0>] _sysfs_write_file+0x128/0x1a4
 #2:  ((fb_notifier_list).rwsem){.+.+.+}, at: [<40040a60>]
___blocking_notifier_call_chain+0x34/0x80

stack backtrace:

Call trace:
[<40003b1c>] _show_stack+0x68/0x7c
[<40003b44>] _dump_stack+0x14/0x28
[<4004f360>] _validate_chain+0x1170/0x137c
[<4004f9dc>] ___lock_acquire+0x470/0xc44
[<4005020c>] _lock_acquire+0x5c/0x84
[<40238204>] _down_read+0x48/0x64
[<40040a5c>] ___blocking_notifier_call_chain+0x30/0x80
[<40040ac0>] _blocking_notifier_call_chain+0x14/0x28
[<401332ac>] _fb_notifier_call_chain+0x1c/0x30
[<40134894>] _fb_set_var+0x170/0x324
[<40141e98>] _fbcon_switch+0x1b8/0x5a4
[<401635d4>] _redraw_screen+0x100/0x268
[<401424bc>] _fbcon_blank+0x238/0x2e0
[<40163834>] _do_unblank_screen+0xf8/0x200
[<40140aa8>] _fbcon_event_notify+0xae0/0xae8
[<40040608>] _notifier_call_chain+0x48/0x94
[<40040a74>] ___blocking_notifier_call_chain+0x48/0x80
[<40040ac0>] _blocking_notifier_call_chain+0x14/0x28
[<401332ac>] _fb_notifier_call_chain+0x1c/0x30
[<40133938>] _fb_blank+0x7c/0xa8
[<40139964>] _store_blank+0x50/0x84
[<401739ec>] _dev_attr_store+0x20/0x48
[<400e8bc0>] _sysfs_write_file+0x148/0x1a4
[<4009180c>] _vfs_write+0xec/0x194
[<40092168>] _sys_write+0x40/0x90
[<4000460c>] _switch_handler+0x110/0x170
[<40001098>] ___TBIBoingVec+0xc/0x10

INFO: lockdep is turned off.
