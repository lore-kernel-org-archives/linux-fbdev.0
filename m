From: Scot Doyle <lkml14@scotdoyle.com>
Date: Tue, 11 Oct 2016 22:48:29 +0000
Subject: Re: tty, fbcon: use-after-free in fbcon_invert_region
Message-Id: <alpine.DEB.2.20.1610111709120.25352@pc>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CACT4Y+acDTwy4umEvf5ROBGiRJNrxHN4Cn5szCXE5Jw-d1B=Xw@mail.gmail.com> <CACT4Y+bGtZKy55Kwk_Jz7_P1SOihd8SksuSv7j4x5KDawsnamQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bGtZKy55Kwk_Jz7_P1SOihd8SksuSv7j4x5KDawsnamQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jean-philippe.brucker@arm.com, linux-fbdev@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, syzkaller <syzkaller@googlegroups.com>

> On Tue, Oct 11, 2016 at 3:43 AM, Scot Doyle <lkml14@scotdoyle.com> wrote:
> > I wonder if the text selection is outside the newly resized vc?
> > Does this patch help?
> > 
> > --- vt.c        2016-10-11 00:32:43.079605599 -0000
> > +++ vt.c.new    2016-10-11 00:36:12.744650759 -0000
> > @@ -874,6 +874,9 @@
> > if (!newscreen)
> > return -ENOMEM;
> > 
> > +       if (vc = sel_cons)
> > +               clear_selection();
> > +
> > old_rows = vc->vc_rows;
> > old_row_size = vc->vc_size_row;
>
> This helped with the use-after-frees and out-of-bounds.
> Tested-by: Dmitry Vyukov <dvyukov@google.com>
>
> However, now the test program hanged in D unkillable stack on some
> kind of kernel deadlock. Don't know if it's induced by your patch, or
> just another bug. At least there are no vc_do_resize in stacks.
>
> # ps afxu | grep a.out
> root      6163  6.5  0.0      0     0 pts/0    Zl   13:25   0:00  |
>    \_ [a.out] <defunct>
>
> # ls /proc/6163/task/
> 6163  6191  6193  6194 6201
> 
> # cat /proc/6163/task/*/stack
> [<     inline     >] down_read_failed drivers/tty/tty_ldsem.c:241
> [<ffffffff831b8da6>] __ldsem_down_read_nested+0x2a6/0x5b0 drivers/tty/tty_ldsem.c:332
> [<ffffffff831b23f5>] tty_ldisc_ref_wait+0x35/0xb0 drivers/tty/tty_ldisc.c:274
> [<ffffffff831962b7>] tty_write+0x177/0x840 drivers/tty/tty_io.c:1250
> [<ffffffff8182c700>] __vfs_write+0x110/0x620 fs/read_write.c:510
> [<ffffffff8182dc05>] vfs_write+0x175/0x4e0 fs/read_write.c:560
> [<     inline     >] SYSC_write fs/read_write.c:607
> [<ffffffff818314c9>] SyS_write+0xd9/0x1b0 fs/read_write.c:599
> [<ffffffff86daf545>] entry_SYSCALL_64_fastpath+0x23/0xc6
> arch/x86/entry/entry_64.S:208

The patch below removes the resize ioctl's from the first test program. 
Are there any use-after-free/out-of-bounds errors when running the patched 
test program on the unpatched kernel? If not, but there are still 
deadlocks, then perhaps they aren't caused by the proposed kernel patch?

--- test.c
+++ test.c.new
@@ -141,8 +141,6 @@
     NONFAILING(*(uint16_t*)0x20f77ff9 = (uint16_t)0x6);
     NONFAILING(*(uint16_t*)0x20f77ffb = (uint16_t)0x3f);
     NONFAILING(*(uint16_t*)0x20f77ffd = (uint16_t)0x0);
-    r[17] = execute_syscall(__NR_ioctl, r[8], 0x541cul, 0x20f77ff4ul, 0,
-                            0, 0, 0, 0, 0);
     break;
   case 8:
     NONFAILING(*(uint32_t*)0x20f6dffc = (uint32_t)0x5);
@@ -212,8 +210,6 @@
     NONFAILING(*(uint16_t*)0x20f78ffa = (uint16_t)0xeb8);
     NONFAILING(*(uint16_t*)0x20f78ffc = (uint16_t)0x9);
     NONFAILING(*(uint16_t*)0x20f78ffe = (uint16_t)0x7);
-    r2[17] = execute_syscall(__NR_ioctl, r2[5], 0x5609ul, 0x20f78ffaul, 0,
-                            0, 0, 0, 0, 0);
     break;
   case 8:
     r2[18] @@ -273,8 +269,6 @@
     NONFAILING(*(uint16_t*)0x20f70002 = (uint16_t)0x2);
     NONFAILING(*(uint16_t*)0x20f70004 = (uint16_t)0xd1e);
     NONFAILING(*(uint16_t*)0x20f70006 = (uint16_t)0x7);
-    r2[34] = execute_syscall(__NR_ioctl, r2[5], 0x5414ul, 0x20f70000ul, 0,
-                            0, 0, 0, 0, 0);
     break;
   }
   return 0;

