From: syzbot <syzbot+3f3e624036e240d8aa36@syzkaller.appspotmail.com>
Date: Sun, 12 Jan 2020 07:15:09 +0000
Subject: INFO: task hung in do_fb_ioctl
Message-Id: <00000000000077defe059bec1e14@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, sam@ravnborg.org, syzkaller-bugs@googlegroups.com

Hello,

syzbot found the following crash on:

HEAD commit:    e69ec487 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?xc223fee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x698c0c240ba616
dashboard link: https://syzkaller.appspot.com/bug?extid?3e624036e240d8aa36
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3f3e624036e240d8aa36@syzkaller.appspotmail.com

INFO: task syz-executor.1:11061 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D27352 11061   9784 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
  __down_common kernel/locking/semaphore.c:220 [inline]
  __down+0x176/0x2c0 kernel/locking/semaphore.c:237
  down+0x64/0x90 kernel/locking/semaphore.c:61
  console_lock+0x29/0x80 kernel/printk/printk.c:2289
  do_fb_ioctl+0x335/0x7d0 drivers/video/fbdev/core/fbmem.c:1101
  fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45af49
Code: e8 3c 1f 00 00 eb aa cc cc cc cc cc cc cc cc cc cc 64 48 8b 0c 25 f8  
ff ff ff 48 3b 61 10 76 40 48 83 ec 28 48 89 6c 24 20 48 <8d> 6c 24 20 48  
8b 42 10 48 8b 4a 18 48 8b 52 08 48 89 14 24 48 89
RSP: 002b:00007f1917090c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045af49
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f19170916d4
R13: 00000000004c3903 R14: 00000000004d9f18 R15: 00000000ffffffff

Showing all locks held in the system:
1 lock held by khungtaskd/1123:
  #0: ffffffff899a5340 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
1 lock held by rsyslogd/9652:
  #0: ffff8880999af8e0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/9742:
  #0: ffff8880a9539090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017cb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9743:
  #0: ffff8880a1023090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000181b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9744:
  #0: ffff88808df81090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000182b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9745:
  #0: ffff888091efe090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000176b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9746:
  #0: ffff8880964c9090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000180b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9747:
  #0: ffff88808cb42090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017bb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9748:
  #0: ffff8880a00d8090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000174b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by syz-executor.3/11058:

======================
NMI backtrace for cpu 1
CPU: 1 PID: 1123 Comm: khungtaskd Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0xb11/0x10c0 kernel/hung_task.c:289
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 11058 Comm: syz-executor.3 Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__sanitizer_cov_trace_pc+0x1a/0x50 kernel/kcov.c:183
Code: c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 65 48 8b  
04 25 c0 1e 02 00 65 8b 15 84 f7 8c 7e 81 e2 00 01 1f 00 <48> 8b 75 08 75  
2b 8b 90 80 13 00 00 83 fa 02 75 20 48 8b 88 88 13
RSP: 0018:ffffc90001aded78 EFLAGS: 00000246
RAX: ffff888050d04140 RBX: 0000000000000000 RCX: ffffffff83c1643f
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffffc90001aded78 R08: ffff888050d04140 R09: 0000000000000040
R10: ffffed10431a560b R11: ffff888218d2b05f R12: 0000000000001400
R13: 0000000000000040 R14: ffff8880000a0000 R15: 0000000000000000
FS:  00007f0b3684b700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00deef6d8 CR3: 00000000a8194000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  bitfill_aligned drivers/video/fbdev/core/cfbfillrect.c:43 [inline]
  bitfill_aligned+0x39/0x210 drivers/video/fbdev/core/cfbfillrect.c:35
  cfb_fillrect+0x423/0x7c0 drivers/video/fbdev/core/cfbfillrect.c:327
  vga16fb_fillrect+0x6ce/0x19b0 drivers/video/fbdev/vga16fb.c:951
  bit_clear_margins+0x30b/0x530 drivers/video/fbdev/core/bitblit.c:232
  fbcon_clear_margins+0x1e9/0x250 drivers/video/fbdev/core/fbcon.c:1372
  fbcon_switch+0xd7f/0x17f0 drivers/video/fbdev/core/fbcon.c:2354
  redraw_screen+0x2b6/0x7d0 drivers/tty/vt/vt.c:997
  fbcon_modechanged+0x5c3/0x790 drivers/video/fbdev/core/fbcon.c:2991
  fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
  fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
  fbcon_switch+0x556/0x17f0 drivers/video/fbdev/core/fbcon.c:2287
  redraw_screen+0x2b6/0x7d0 drivers/tty/vt/vt.c:997
  fbcon_modechanged+0x5c3/0x790 drivers/video/fbdev/core/fbcon.c:2991
  fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
  fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
  do_fb_ioctl+0x390/0x7d0 drivers/video/fbdev/core/fbmem.c:1104
  fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45af49
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0b3684ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045af49
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0b3684b6d4
R13: 00000000004c3903 R14: 00000000004d9f18 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
