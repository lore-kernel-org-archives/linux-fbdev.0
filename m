From: Scot Doyle <lkml14@scotdoyle.com>
Date: Tue, 11 Oct 2016 01:43:53 +0000
Subject: Re: tty, fbcon: use-after-free in fbcon_invert_region
Message-Id: <alpine.DEB.2.20.1610101946090.5260@pc>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CACT4Y+acDTwy4umEvf5ROBGiRJNrxHN4Cn5szCXE5Jw-d1B=Xw@mail.gmail.com> <CACT4Y+bGtZKy55Kwk_Jz7_P1SOihd8SksuSv7j4x5KDawsnamQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bGtZKy55Kwk_Jz7_P1SOihd8SksuSv7j4x5KDawsnamQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jean-philippe.brucker@arm.com, linux-fbdev@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, syzkaller <syzkaller@googlegroups.com>

On Fri, 7 Oct 2016, Dmitry Vyukov wrote:
> On Sat, Sep 3, 2016 at 9:20 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> > Hello,
> >
> > The following program causes use-after-free in fbcon_invert_region:
> >
> > https://gist.githubusercontent.com/dvyukov/d657f9a9ca39f34c430dcf63ec1153ac/raw/04e1b94aef0fc9eb770d11373b568980ecaa7f34/gistfile1.txt
> >
> > =================================
> > BUG: KASAN: use-after-free in fbcon_invert_region+0x1cc/0x1f0 at addr
> > ffff88006cc3f51e
> > Read of size 2 by task a.out/4240
> > CPU: 0 PID: 4240 Comm: a.out Not tainted 4.8.0-rc3-next-20160825+ #10
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> >  ffffffff886b6fe0 ffff88003699f790 ffffffff82db3759 ffffffff8a0ae640
> >  fffffbfff10d6dfc ffff88003e800100 ffff88006cc3f500 ffff88006cc3f520
> >  0000000000000000 ffff88006cc3f51e ffff88003699f7b8 ffffffff81809e7c
> >
> > Call Trace:
> >  [<ffffffff8180a474>] __asan_report_load2_noabort+0x14/0x20
> > mm/kasan/report.c:325
> >  [<ffffffff82fdbc8c>] fbcon_invert_region+0x1cc/0x1f0
> > drivers/video/console/fbcon.c:2750
> >  [<ffffffff8327ce72>] invert_screen+0x192/0x630 drivers/tty/vt/vt.c:470
> >  [<     inline     >] highlight drivers/tty/vt/selection.c:50
> >  [<ffffffff8326037c>] clear_selection+0x4c/0x60 drivers/tty/vt/selection.c:76
> >  [<ffffffff8327374e>] hide_cursor+0x24e/0x2d0 drivers/tty/vt/vt.c:599
> >  [<ffffffff83276207>] redraw_screen+0x2e7/0x840 drivers/tty/vt/vt.c:682
> >  [<ffffffff83278b0c>] vc_do_resize+0xebc/0x1160 drivers/tty/vt/vt.c:952
> >  [<ffffffff83278eba>] vt_resize+0xaa/0xe0 drivers/tty/vt/vt.c:992
> >  [<     inline     >] tiocswinsz drivers/tty/tty_io.c:2378
> >  [<ffffffff83224e71>] tty_ioctl+0x10c1/0x21e0 drivers/tty/tty_io.c:2892
> >  [<     inline     >] vfs_ioctl fs/ioctl.c:43
> >  [<ffffffff818a1c6c>] do_vfs_ioctl+0x18c/0x1080 fs/ioctl.c:675
> >  [<     inline     >] SYSC_ioctl fs/ioctl.c:690
> >  [<ffffffff818a2bef>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:681
> >  [<ffffffff86e10480>] entry_SYSCALL_64_fastpath+0x23/0xc1

I wonder if the text selection is outside the newly resized vc?
Does this patch help?

--- vt.c	2016-10-11 00:32:43.079605599 -0000
+++ vt.c.new	2016-10-11 00:36:12.744650759 -0000
@@ -874,6 +874,9 @@
 	if (!newscreen)
 		return -ENOMEM;
 
+	if (vc = sel_cons)
+		clear_selection();
+
 	old_rows = vc->vc_rows;
 	old_row_size = vc->vc_size_row;
 

