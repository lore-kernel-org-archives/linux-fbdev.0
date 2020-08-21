From: syzbot <syzbot+50bc4646cbe1b0a9a08b@syzkaller.appspotmail.com>
Date: Fri, 21 Aug 2020 16:57:16 +0000
Subject: KMSAN: uninit-value in cfb_imageblit
Message-Id: <0000000000000eb21105ad66213f@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, glider@google.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com

Hello,

syzbot found the following issue on:

HEAD commit:    ce8056d1 wip: changed copy_from_user where instrumented
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?xe7dba1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x:fe005fb99591f
dashboard link: https://syzkaller.appspot.com/bug?extidPbc4646cbe1b0a9a08b
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50bc4646cbe1b0a9a08b@syzkaller.appspotmail.com

==========================BUG: KMSAN: uninit-value in fast_imageblit drivers/video/fbdev/core/cfbimgblt.c:256 [inline]
BUG: KMSAN: uninit-value in cfb_imageblit+0x1c71/0x2a60 drivers/video/fbdev/core/cfbimgblt.c:300
CPU: 1 PID: 32379 Comm: syz-executor.1 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 fast_imageblit drivers/video/fbdev/core/cfbimgblt.c:256 [inline]
 cfb_imageblit+0x1c71/0x2a60 drivers/video/fbdev/core/cfbimgblt.c:300
 vga16fb_imageblit+0xda2/0x20c0 drivers/video/fbdev/vga16fb.c:1250
 soft_cursor+0x12bc/0x13f0 drivers/video/fbdev/core/softcursor.c:74
 bit_cursor+0x38c6/0x3a40 drivers/video/fbdev/core/bitblit.c:386
 fbcon_cursor+0x195e/0x1a60 drivers/video/fbdev/core/fbcon.c:1411
 hide_cursor+0xdd/0x560 drivers/tty/vt/vt.c:902
 do_con_write+0x33c/0x15460 drivers/tty/vt/vt.c:2617
 con_write+0x8e/0xe0 drivers/tty/vt/vt.c:3159
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0x167a/0x2230 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x9fb/0x1610 drivers/tty/tty_io.c:1046
 vfs_write+0x6a3/0x17c0 fs/read_write.c:576
 ksys_write+0x275/0x500 fs/read_write.c:631
 __do_sys_write fs/read_write.c:643 [inline]
 __se_sys_write+0x92/0xb0 fs/read_write.c:640
 __ia32_sys_write+0x4a/0x70 fs/read_write.c:640
 do_syscall_32_irqs_on arch/x86/entry/common.c:430 [inline]
 __do_fast_syscall_32+0x2af/0x480 arch/x86/entry/common.c:477
 do_fast_syscall_32+0x6b/0xd0 arch/x86/entry/common.c:505
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:554
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f88549
Code: Bad RIP value.
RSP: 002b:00000000f55820cc EFLAGS: 00000296 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000200000c0
RDX: 0000000000000078 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
 __fb_pad_aligned_buffer include/linux/fb.h:655 [inline]
 fb_pad_aligned_buffer+0x7c4/0x8e0 drivers/video/fbdev/core/fbmem.c:116
 soft_cursor+0x1224/0x13f0 drivers/video/fbdev/core/softcursor.c:72
 bit_cursor+0x38c6/0x3a40 drivers/video/fbdev/core/bitblit.c:386
 fbcon_cursor+0x195e/0x1a60 drivers/video/fbdev/core/fbcon.c:1411
 hide_cursor+0xdd/0x560 drivers/tty/vt/vt.c:902
 do_con_write+0x33c/0x15460 drivers/tty/vt/vt.c:2617
 con_write+0x8e/0xe0 drivers/tty/vt/vt.c:3159
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0x167a/0x2230 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x9fb/0x1610 drivers/tty/tty_io.c:1046
 vfs_write+0x6a3/0x17c0 fs/read_write.c:576
 ksys_write+0x275/0x500 fs/read_write.c:631
 __do_sys_write fs/read_write.c:643 [inline]
 __se_sys_write+0x92/0xb0 fs/read_write.c:640
 __ia32_sys_write+0x4a/0x70 fs/read_write.c:640
 do_syscall_32_irqs_on arch/x86/entry/common.c:430 [inline]
 __do_fast_syscall_32+0x2af/0x480 arch/x86/entry/common.c:477
 do_fast_syscall_32+0x6b/0xd0 arch/x86/entry/common.c:505
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:554
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 kmsan_memcpy_memmove_metadata+0x272/0x2e0 mm/kmsan/kmsan.c:247
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:267
 __msan_memcpy+0x43/0x50 mm/kmsan/kmsan_instr.c:116
 soft_cursor+0x7d7/0x13f0 drivers/video/fbdev/core/softcursor.c:70
 bit_cursor+0x38c6/0x3a40 drivers/video/fbdev/core/bitblit.c:386
 fbcon_cursor+0x195e/0x1a60 drivers/video/fbdev/core/fbcon.c:1411
 hide_cursor+0xdd/0x560 drivers/tty/vt/vt.c:902
 do_con_write+0x33c/0x15460 drivers/tty/vt/vt.c:2617
 con_write+0x8e/0xe0 drivers/tty/vt/vt.c:3159
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0x167a/0x2230 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x9fb/0x1610 drivers/tty/tty_io.c:1046
 vfs_write+0x6a3/0x17c0 fs/read_write.c:576
 ksys_write+0x275/0x500 fs/read_write.c:631
 __do_sys_write fs/read_write.c:643 [inline]
 __se_sys_write+0x92/0xb0 fs/read_write.c:640
 __ia32_sys_write+0x4a/0x70 fs/read_write.c:640
 do_syscall_32_irqs_on arch/x86/entry/common.c:430 [inline]
 __do_fast_syscall_32+0x2af/0x480 arch/x86/entry/common.c:477
 do_fast_syscall_32+0x6b/0xd0 arch/x86/entry/common.c:505
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:554
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:80
 slab_alloc_node mm/slub.c:2839 [inline]
 slab_alloc mm/slub.c:2848 [inline]
 __kmalloc+0x312/0x410 mm/slub.c:3911
 kmalloc include/linux/slab.h:560 [inline]
 fbcon_set_font+0x5ad/0xfb0 drivers/video/fbdev/core/fbcon.c:2673
 con_font_set drivers/tty/vt/vt.c:4571 [inline]
 con_font_op+0x1e59/0x2290 drivers/tty/vt/vt.c:4636
 vt_ioctl+0x99e/0x67c0 drivers/tty/vt/vt_ioctl.c:917
 vt_compat_ioctl+0x59b/0x1040 drivers/tty/vt/vt_ioctl.c:1242
 tty_compat_ioctl+0x74b/0x1660 drivers/tty/tty_io.c:2847
 __do_compat_sys_ioctl fs/ioctl.c:847 [inline]
 __se_compat_sys_ioctl+0x55f/0x1100 fs/ioctl.c:798
 __ia32_compat_sys_ioctl+0x4a/0x70 fs/ioctl.c:798
 do_syscall_32_irqs_on arch/x86/entry/common.c:430 [inline]
 __do_fast_syscall_32+0x2af/0x480 arch/x86/entry/common.c:477
 do_fast_syscall_32+0x6b/0xd0 arch/x86/entry/common.c:505
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:554
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
==========================

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
