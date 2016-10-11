From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 11 Oct 2016 13:31:28 +0000
Subject: Re: tty, fbcon: use-after-free in fbcon_invert_region
Message-Id: <CACT4Y+bkJXesioxFyV-DCrvQM+wYTmfp1O3Y=owZTuDN+LOTzg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CACT4Y+acDTwy4umEvf5ROBGiRJNrxHN4Cn5szCXE5Jw-d1B=Xw@mail.gmail.com>
 <CACT4Y+bGtZKy55Kwk_Jz7_P1SOihd8SksuSv7j4x5KDawsnamQ@mail.gmail.com> <alpine.DEB.2.20.1610101946090.5260@pc>
In-Reply-To: <alpine.DEB.2.20.1610101946090.5260@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: syzkaller <syzkaller@googlegroups.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jean-philippe.brucker@arm.com, linux-fbdev@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Oct 11, 2016 at 3:43 AM, Scot Doyle <lkml14@scotdoyle.com> wrote:
> On Fri, 7 Oct 2016, Dmitry Vyukov wrote:
>> On Sat, Sep 3, 2016 at 9:20 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> > Hello,
>> >
>> > The following program causes use-after-free in fbcon_invert_region:
>> >
>> > https://gist.githubusercontent.com/dvyukov/d657f9a9ca39f34c430dcf63ec1153ac/raw/04e1b94aef0fc9eb770d11373b568980ecaa7f34/gistfile1.txt
>> >
>> > =================================
>> > BUG: KASAN: use-after-free in fbcon_invert_region+0x1cc/0x1f0 at addr
>> > ffff88006cc3f51e
>> > Read of size 2 by task a.out/4240
>> > CPU: 0 PID: 4240 Comm: a.out Not tainted 4.8.0-rc3-next-20160825+ #10
>> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>> >  ffffffff886b6fe0 ffff88003699f790 ffffffff82db3759 ffffffff8a0ae640
>> >  fffffbfff10d6dfc ffff88003e800100 ffff88006cc3f500 ffff88006cc3f520
>> >  0000000000000000 ffff88006cc3f51e ffff88003699f7b8 ffffffff81809e7c
>> >
>> > Call Trace:
>> >  [<ffffffff8180a474>] __asan_report_load2_noabort+0x14/0x20
>> > mm/kasan/report.c:325
>> >  [<ffffffff82fdbc8c>] fbcon_invert_region+0x1cc/0x1f0
>> > drivers/video/console/fbcon.c:2750
>> >  [<ffffffff8327ce72>] invert_screen+0x192/0x630 drivers/tty/vt/vt.c:470
>> >  [<     inline     >] highlight drivers/tty/vt/selection.c:50
>> >  [<ffffffff8326037c>] clear_selection+0x4c/0x60 drivers/tty/vt/selection.c:76
>> >  [<ffffffff8327374e>] hide_cursor+0x24e/0x2d0 drivers/tty/vt/vt.c:599
>> >  [<ffffffff83276207>] redraw_screen+0x2e7/0x840 drivers/tty/vt/vt.c:682
>> >  [<ffffffff83278b0c>] vc_do_resize+0xebc/0x1160 drivers/tty/vt/vt.c:952
>> >  [<ffffffff83278eba>] vt_resize+0xaa/0xe0 drivers/tty/vt/vt.c:992
>> >  [<     inline     >] tiocswinsz drivers/tty/tty_io.c:2378
>> >  [<ffffffff83224e71>] tty_ioctl+0x10c1/0x21e0 drivers/tty/tty_io.c:2892
>> >  [<     inline     >] vfs_ioctl fs/ioctl.c:43
>> >  [<ffffffff818a1c6c>] do_vfs_ioctl+0x18c/0x1080 fs/ioctl.c:675
>> >  [<     inline     >] SYSC_ioctl fs/ioctl.c:690
>> >  [<ffffffff818a2bef>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:681
>> >  [<ffffffff86e10480>] entry_SYSCALL_64_fastpath+0x23/0xc1
>
> I wonder if the text selection is outside the newly resized vc?
> Does this patch help?
>
> --- vt.c        2016-10-11 00:32:43.079605599 -0000
> +++ vt.c.new    2016-10-11 00:36:12.744650759 -0000
> @@ -874,6 +874,9 @@
>         if (!newscreen)
>                 return -ENOMEM;
>
> +       if (vc = sel_cons)
> +               clear_selection();
> +
>         old_rows = vc->vc_rows;
>         old_row_size = vc->vc_size_row;


This helped with the use-after-frees and out-of-bounds.

Tested-by: Dmitry Vyukov <dvyukov@google.com>



However, now the test program hanged in D unkillable stack on some
kind of kernel deadlock. Don't know if it's induced by your patch, or
just another bug. At least there are no vc_do_resize in stacks.

# ps afxu | grep a.out
root      6163  6.5  0.0      0     0 pts/0    Zl   13:25   0:00  |
   \_ [a.out] <defunct>

# ls /proc/6163/task/
6163  6191  6193  6194 6201

# cat /proc/6163/task/*/stack
[<     inline     >] down_read_failed drivers/tty/tty_ldsem.c:241
[<ffffffff831b8da6>] __ldsem_down_read_nested+0x2a6/0x5b0
drivers/tty/tty_ldsem.c:332
[<ffffffff831b23f5>] tty_ldisc_ref_wait+0x35/0xb0 drivers/tty/tty_ldisc.c:274
[<ffffffff831962b7>] tty_write+0x177/0x840 drivers/tty/tty_io.c:1250
[<ffffffff8182c700>] __vfs_write+0x110/0x620 fs/read_write.c:510
[<ffffffff8182dc05>] vfs_write+0x175/0x4e0 fs/read_write.c:560
[<     inline     >] SYSC_write fs/read_write.c:607
[<ffffffff818314c9>] SyS_write+0xd9/0x1b0 fs/read_write.c:599
[<ffffffff86daf545>] entry_SYSCALL_64_fastpath+0x23/0xc6
arch/x86/entry/entry_64.S:208
[<ffffffffffffffff>] 0xffffffffffffffff
[<     inline     >] down_read_failed drivers/tty/tty_ldsem.c:241
[<ffffffff831b8da6>] __ldsem_down_read_nested+0x2a6/0x5b0
drivers/tty/tty_ldsem.c:332
[<ffffffff831b23f5>] tty_ldisc_ref_wait+0x35/0xb0 drivers/tty/tty_ldisc.c:274
[<ffffffff831962b7>] tty_write+0x177/0x840 drivers/tty/tty_io.c:1250
[<ffffffff8182c700>] __vfs_write+0x110/0x620 fs/read_write.c:510
[<ffffffff8182dc05>] vfs_write+0x175/0x4e0 fs/read_write.c:560
[<     inline     >] SYSC_write fs/read_write.c:607
[<ffffffff818314c9>] SyS_write+0xd9/0x1b0 fs/read_write.c:599
[<ffffffff86daf545>] entry_SYSCALL_64_fastpath+0x23/0xc6
arch/x86/entry/entry_64.S:208
[<ffffffffffffffff>] 0xffffffffffffffff
[<     inline     >] down_read_failed drivers/tty/tty_ldsem.c:241
[<ffffffff831b8da6>] __ldsem_down_read_nested+0x2a6/0x5b0
drivers/tty/tty_ldsem.c:332
[<ffffffff831b23f5>] tty_ldisc_ref_wait+0x35/0xb0 drivers/tty/tty_ldisc.c:274
[<ffffffff831962b7>] tty_write+0x177/0x840 drivers/tty/tty_io.c:1250
[<ffffffff8182c700>] __vfs_write+0x110/0x620 fs/read_write.c:510
[<ffffffff8182dc05>] vfs_write+0x175/0x4e0 fs/read_write.c:560
[<     inline     >] SYSC_write fs/read_write.c:607
[<ffffffff818314c9>] SyS_write+0xd9/0x1b0 fs/read_write.c:599
[<ffffffff86daf545>] entry_SYSCALL_64_fastpath+0x23/0xc6
arch/x86/entry/entry_64.S:208
[<ffffffffffffffff>] 0xffffffffffffffff
[<     inline     >] down_read_failed drivers/tty/tty_ldsem.c:241
[<ffffffff831b8da6>] __ldsem_down_read_nested+0x2a6/0x5b0
drivers/tty/tty_ldsem.c:332
[<ffffffff831b23f5>] tty_ldisc_ref_wait+0x35/0xb0 drivers/tty/tty_ldisc.c:274
[<ffffffff8319def3>] tty_ioctl+0xc53/0x2180 drivers/tty/tty_io.c:2987
[<     inline     >] vfs_ioctl fs/ioctl.c:43
[<ffffffff8186bc31>] do_vfs_ioctl+0x191/0x1050 fs/ioctl.c:679
[<     inline     >] SYSC_ioctl fs/ioctl.c:694
[<ffffffff8186cb84>] SyS_ioctl+0x94/0xc0 fs/ioctl.c:685
[<ffffffff86daf545>] entry_SYSCALL_64_fastpath+0x23/0xc6
arch/x86/entry/entry_64.S:208
[<ffffffffffffffff>] 0xffffffffffffffff

# cat /proc/6191/status
Name: a.out
Umask: 0022
State: D (disk sleep)
Tgid: 6163
Ngid: 0
Pid: 6191
PPid: 6154
TracerPid: 0
Uid: 0 0 0 0
Gid: 0 0 0 0
FDSize: 256
Groups: 0
NStgid: 6163
NSpid: 6191
NSpgid: 6163
NSsid: 6154
VmPeak:  402244 kB
VmSize:  402244 kB
VmLck:       0 kB
VmPin:       0 kB
VmHWM:    3140 kB
VmRSS:    3140 kB
RssAnon:    2508 kB
RssFile:     632 kB
RssShmem:       0 kB
VmData:  401072 kB
VmStk:     136 kB
VmExe:     832 kB
VmLib:       8 kB
VmPTE:     212 kB
VmPMD:      12 kB
VmSwap:       0 kB
HugetlbPages:       0 kB
Threads: 5
SigQ: 1/3150
SigPnd: 0000000000000100
ShdPnd: 0000000000000100
SigBlk: 0000000000000000
SigIgn: 0000000000000000
SigCgt: 0000000180000440
CapInh: 0000000000000000
CapPrm: 0000003fffffffff
CapEff: 0000003fffffffff
CapBnd: 0000003fffffffff
CapAmb: 0000000000000000
Seccomp: 0
Cpus_allowed: f
Cpus_allowed_list: 0-3
Mems_allowed: 00000000,00000003
Mems_allowed_list: 0-1
voluntary_ctxt_switches: 1
nonvoluntary_ctxt_switches: 0
