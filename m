From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 31 Mar 2020 12:50:30 +0000
Subject: Re: INFO: trying to register non-static key in try_to_wake_up
Message-Id: <CAKMK7uF5zZH3CaHueWsLR96-AzT==wP8=MpymTqx-T+SRsXWHA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000000000000ec257905a21f7415@google.com>
 <20200331095737.GO20730@hirez.programming.kicks-ass.net>
 <CGME20200331101907eucas1p1ce5d3f7c49c2c724c4e85f5c19c7108d@eucas1p1.samsung.com>
 <CACT4Y+bqBCqDPQZ1Nk8G+8y2vu8aaT2S54J4UqRPaFNUcusbYw@mail.gmail.com>
 <7641fb29-20ec-0963-d04c-bfbf49fd3ebc@samsung.com>
In-Reply-To: <7641fb29-20ec-0963-d04c-bfbf49fd3ebc@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, syzbot <syzbot+e84d7ebd1361da13c356@syzkaller.appspotmail.com>, the arch/x86 maintainers <x86@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>

On Tue, Mar 31, 2020 at 2:18 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 3/31/20 12:18 PM, Dmitry Vyukov wrote:
> > On Tue, Mar 31, 2020 at 11:57 AM Peter Zijlstra <peterz@infradead.org> =
wrote:
> >>
> >> On Mon, Mar 30, 2020 at 10:01:12PM -0700, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following crash on:
> >>>
> >>> HEAD commit:    9420e8ad Merge tag 'for-linus' of git://git.kernel.or=
g/pub..
> >>> git tree:       upstream
> >>> console output: https://protect2.fireeye.com/url?k=0756a78d-5a9a6c49-=
07572cc2-0cc47a314e9a-e4dc8b657d340686&u=3Dhttps://syzkaller.appspot.com/x/=
log.txt?x=1206ed4be00000
> >>> kernel config:  https://protect2.fireeye.com/url?kC211072-1eeddbb6-43=
209b3d-0cc47a314e9a-3bd45a19932c37c8&u=3Dhttps://syzkaller.appspot.com/x/.c=
onfig?x'392dd2975fd692
> >>> dashboard link: https://protect2.fireeye.com/url?k=BF7a6153-e2b6aa97-=
bf7bea1c-0cc47a314e9a-c64073ee605efb7b&u=3Dhttps://syzkaller.appspot.com/bu=
g?extid=E84d7ebd1361da13c356
> >>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >>>
> >>> Unfortunately, I don't have any reproducer for this crash yet.
> >>>
> >>> IMPORTANT: if you fix the bug, please add the following tag to the co=
mmit:
> >>> Reported-by: syzbot+e84d7ebd1361da13c356@syzkaller.appspotmail.com
> >>>
> >>> INFO: trying to register non-static key.
> >>> the code is fine but needs lockdep annotation.
> >>> turning off the locking correctness validator.
> >>> CPU: 1 PID: 1014 Comm: syz-executor.0 Not tainted 5.6.0-rc7-syzkaller=
 #0
> >>> Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 01/01/2011
> >>> Call Trace:
> >>>  <IRQ>
> >>>  __dump_stack lib/dump_stack.c:77 [inline]
> >>>  dump_stack+0x188/0x20d lib/dump_stack.c:118
> >>>  assign_lock_key kernel/locking/lockdep.c:880 [inline]
> >>>  register_lock_class+0x14c4/0x1540 kernel/locking/lockdep.c:1189
> >>>  __lock_acquire+0xfc/0x3ca0 kernel/locking/lockdep.c:3836
> >>>  lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
> >>>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >>>  _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
> >>>  try_to_wake_up+0x9f/0x17c0 kernel/sched/core.c:2547
> >>
> >> That's p->pi_lock, which gets initialized in rt_mutex_init_task() in
> >> copy_process(). This should be impossible. Very odd.
> >
> > The stack mentions fbdev, which is a red flag at the moment. There are
> > a dozen of bad bugs in fbdev and around. Just few days ago Andy
> > pointed to another "impossible" crash "general protection fault in
> > do_syscall_64" which is related to dri:
> > https://protect2.fireeye.com/url?k=0Cb8ad06-517466c2-0cb92649-0cc47a314=
e9a-a20c11191483c65b&u=3Dhttps://syzkaller.appspot.com/bug?id=0Ec7b2602b1ff=
40f0d34f38baa4ba1640727c3d9
> > https://protect2.fireeye.com/url?ka4292e3-3c8e5927-614319ac-0cc47a314e9=
a-aeda6d72c01a7b0e&u=3Dhttps://groups.google.com/forum/#!msg/syzkaller-bugs=
/ePqhfYx0-8M/Q_Urt97iAAAJ
> >
> > There are probably more random manifestations of these bugs already,
> > and I guess we will be getting more.
> >
> > +fbdev maintainers
>
> Thank you for the report.
>
> fbdev is in the maintenance mode and no new features or drivers are
> being added so syzbot reports are not for a new bugs (regressions) and
> are not a priority (at least to me).

Yup same here, I've seen a pile of syzbot reports for fbdev (and also
vt, or combinations of them since fbdev is linked to vt through fbcon)
fly by. But I really don't have to deal with these, my recommendation
to anyone who cares about security are:
- Don't enable vt
- Don't enable fbdev

All that code has been developed long ago, in a much more innocent
time. If someone wants to fix this you'd not just need to fix all the
syzbot stuff, but also ramp up a full testsuite for all the ioctl, and
all the corner-cases. Plus also fix some of the horrendous locking in
there, probably.

Multi-year effort, easily.

Regressions I'll obviously try to handle, but none of these are. It's
just syzbot has become smarter at hitting bugs in fbdev and vt
subsystems (or maybe the hw the virtual machines emulate has become
more varied, some of the reports are for fun stuff like vgacon ...).

Cheers, Daniel

> I have only resources to review/merge pending fbdev patches from time
> to time so any help in fixing these syzbot reports is welcomed (there
> have been a few fbdev related syzbot reports recently).
>
> Also please note that fbdev is maintained through drm-misc tree so
> patches can also be handled by other drm-misc maintainers in case I'm
> not available / busy with other things.
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
> >>>  wake_up_worker kernel/workqueue.c:836 [inline]
> >>>  insert_work+0x2ad/0x3a0 kernel/workqueue.c:1337
> >>>  __queue_work+0x50d/0x1280 kernel/workqueue.c:1488
> >>>  call_timer_fn+0x195/0x760 kernel/time/timer.c:1404
> >>>  expire_timers kernel/time/timer.c:1444 [inline]
> >>>  __run_timers kernel/time/timer.c:1773 [inline]
> >>>  __run_timers kernel/time/timer.c:1740 [inline]
> >>>  run_timer_softirq+0x412/0x1600 kernel/time/timer.c:1786
> >>>  __do_softirq+0x26c/0x99d kernel/softirq.c:292
> >>>  invoke_softirq kernel/softirq.c:373 [inline]
> >>>  irq_exit+0x192/0x1d0 kernel/softirq.c:413
> >>>  exiting_irq arch/x86/include/asm/apic.h:546 [inline]
> >>>  smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1146
> >>>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
> >>>  </IRQ>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
