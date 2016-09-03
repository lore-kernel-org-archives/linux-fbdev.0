From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 03 Sep 2016 19:20:47 +0000
Subject: tty, fbcon: use-after-free in fbcon_invert_region
Message-Id: <CACT4Y+acDTwy4umEvf5ROBGiRJNrxHN4Cn5szCXE5Jw-d1B=Xw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jean-philippe.brucker@arm.com, Scot Doyle <lkml14@scotdoyle.com>, linux-fbdev@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: syzkaller <syzkaller@googlegroups.com>

Hello,

The following program causes use-after-free in fbcon_invert_region:

https://gist.githubusercontent.com/dvyukov/d657f9a9ca39f34c430dcf63ec1153ac/raw/04e1b94aef0fc9eb770d11373b568980ecaa7f34/gistfile1.txt

=================================
BUG: KASAN: use-after-free in fbcon_invert_region+0x1cc/0x1f0 at addr
ffff88006cc3f51e
Read of size 2 by task a.out/4240
CPU: 0 PID: 4240 Comm: a.out Not tainted 4.8.0-rc3-next-20160825+ #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 ffffffff886b6fe0 ffff88003699f790 ffffffff82db3759 ffffffff8a0ae640
 fffffbfff10d6dfc ffff88003e800100 ffff88006cc3f500 ffff88006cc3f520
 0000000000000000 ffff88006cc3f51e ffff88003699f7b8 ffffffff81809e7c

Call Trace:
 [<ffffffff8180a474>] __asan_report_load2_noabort+0x14/0x20
mm/kasan/report.c:325
 [<ffffffff82fdbc8c>] fbcon_invert_region+0x1cc/0x1f0
drivers/video/console/fbcon.c:2750
 [<ffffffff8327ce72>] invert_screen+0x192/0x630 drivers/tty/vt/vt.c:470
 [<     inline     >] highlight drivers/tty/vt/selection.c:50
 [<ffffffff8326037c>] clear_selection+0x4c/0x60 drivers/tty/vt/selection.c:76
 [<ffffffff8327374e>] hide_cursor+0x24e/0x2d0 drivers/tty/vt/vt.c:599
 [<ffffffff83276207>] redraw_screen+0x2e7/0x840 drivers/tty/vt/vt.c:682
 [<ffffffff83278b0c>] vc_do_resize+0xebc/0x1160 drivers/tty/vt/vt.c:952
 [<ffffffff83278eba>] vt_resize+0xaa/0xe0 drivers/tty/vt/vt.c:992
 [<     inline     >] tiocswinsz drivers/tty/tty_io.c:2378
 [<ffffffff83224e71>] tty_ioctl+0x10c1/0x21e0 drivers/tty/tty_io.c:2892
 [<     inline     >] vfs_ioctl fs/ioctl.c:43
 [<ffffffff818a1c6c>] do_vfs_ioctl+0x18c/0x1080 fs/ioctl.c:675
 [<     inline     >] SYSC_ioctl fs/ioctl.c:690
 [<ffffffff818a2bef>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:681
 [<ffffffff86e10480>] entry_SYSCALL_64_fastpath+0x23/0xc1
arch/x86/entry/entry_64.S:208
Object at ffff88006cc3f500, in cache kmalloc-32 size: 32

Allocated:
PID = 3233
 [<     inline     >] kmalloc ./include/linux/slab.h:490
 [<     inline     >] kzalloc ./include/linux/slab.h:636
 [<ffffffff82b85834>] aa_alloc_task_context+0x54/0x90
security/apparmor/context.c:40
 [<ffffffff82b99e3d>] apparmor_cred_prepare+0x1d/0xb0 security/apparmor/lsm.c:76
 [<ffffffff82acf12d>] security_prepare_creds+0x7d/0xb0 security/security.c:912
 [<ffffffff813fb355>] prepare_kernel_cred+0x375/0x650 kernel/cred.c:630
 [<ffffffff813cded9>] call_usermodehelper_exec_async+0xb9/0x460
kernel/kmod.c:232
 [<ffffffff86e1070a>] ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431

Freed:
PID = 1693
 [<     inline     >] __cache_free mm/slab.c:3520
 [<ffffffff81807813>] kfree+0xc3/0x2a0 mm/slab.c:3837
 [<ffffffff8175f108>] kzfree+0x28/0x30 mm/slab_common.c:1323
 [<ffffffff82b85991>] aa_free_task_context+0x121/0x1d0
security/apparmor/context.c:54
 [<ffffffff82b99f79>] apparmor_cred_free+0x39/0x80 security/apparmor/lsm.c:51
 [<ffffffff82acf078>] security_cred_free+0x48/0x80 security/security.c:907
 [<ffffffff813f8224>] put_cred_rcu+0xe4/0x3e0 kernel/cred.c:116
 [<     inline     >] __rcu_reclaim kernel/rcu/rcu.h:118
 [<     inline     >] rcu_do_batch kernel/rcu/tree.c:2777
 [<     inline     >] invoke_rcu_callbacks kernel/rcu/tree.c:3041
 [<     inline     >] __rcu_process_callbacks kernel/rcu/tree.c:3008
 [<ffffffff814e7e3b>] rcu_process_callbacks+0xdbb/0x1560 kernel/rcu/tree.c:3025
 [<ffffffff86e1358c>] __do_softirq+0x25c/0xa3e kernel/softirq.c:273
Memory state around the buggy address:
 ffff88006cc3f400: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
 ffff88006cc3f480: 00 00 fc fc fc fc fc fc fb fb fb fb fc fc fc fc
>ffff88006cc3f500: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                            ^
 ffff88006cc3f580: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
 ffff88006cc3f600: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
=================================


I am also hitting similar bugs all over fbcon:

BUG: KASAN: slab-out-of-bounds in fbcon_putcs+0x444/0x4b0 at addr
ffff8800384e58a8

https://gist.githubusercontent.com/dvyukov/645a5f48b735fb384de7ea35fe1748ea/raw/3690a8b2c82a3b8fd7d07f4602a166f5756c3749/gistfile1.txt

BUG: KASAN: slab-out-of-bounds in bit_putcs+0xcd6/0xd70 at addr ffff88006abad8e6

https://gist.githubusercontent.com/dvyukov/2d909f2673eafbc35f7f17f95c395217/raw/83f4eb0193226d51c546015cddee4b6a697015b3/gistfile1.txt

BUG: KASAN: use-after-free in fbcon_putcs+0x444/0x4b0 at addr ffff8800644bd820

https://gist.githubusercontent.com/dvyukov/286cdf2d3f9c6956ec9055dad0cf7a2a/raw/f7e0a380be364afd0c2c4c54ff5661e451fb143d/gistfile1.txt

BUG: KASAN: slab-out-of-bounds in do_update_region+0x642/0x670 at addr
ffff8800661c56ac

https://gist.githubusercontent.com/dvyukov/7fd9d858ea38e8131e21a0377435c32c/raw/5d59989e05b4e39bb5ee90f49658674fa9db89ad/gistfile1.txt


On 0f98f121e1670eaa2a2fbb675e07d6ba7f0e146f of linux-next.
