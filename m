From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 31 Mar 2020 10:18:49 +0000
Subject: Re: INFO: trying to register non-static key in try_to_wake_up
Message-Id: <CACT4Y+bqBCqDPQZ1Nk8G+8y2vu8aaT2S54J4UqRPaFNUcusbYw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000000000000ec257905a21f7415@google.com>
 <20200331095737.GO20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200331095737.GO20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Peter Zijlstra <peterz@infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, DRI <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Cc: syzbot <syzbot+e84d7ebd1361da13c356@syzkaller.appspotmail.com>, the arch/x86 maintainers <x86@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Mar 31, 2020 at 11:57 AM Peter Zijlstra <peterz@infradead.org> wrot=
e:
>
> On Mon, Mar 30, 2020 at 10:01:12PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    9420e8ad Merge tag 'for-linus' of git://git.kernel.org/=
pub..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1206ed4be00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x'392dd2975fd692
> > dashboard link: https://syzkaller.appspot.com/bug?extid=E84d7ebd1361da1=
3c356
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+e84d7ebd1361da13c356@syzkaller.appspotmail.com
> >
> > INFO: trying to register non-static key.
> > the code is fine but needs lockdep annotation.
> > turning off the locking correctness validator.
> > CPU: 1 PID: 1014 Comm: syz-executor.0 Not tainted 5.6.0-rc7-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/01/2011
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x188/0x20d lib/dump_stack.c:118
> >  assign_lock_key kernel/locking/lockdep.c:880 [inline]
> >  register_lock_class+0x14c4/0x1540 kernel/locking/lockdep.c:1189
> >  __lock_acquire+0xfc/0x3ca0 kernel/locking/lockdep.c:3836
> >  lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >  _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
> >  try_to_wake_up+0x9f/0x17c0 kernel/sched/core.c:2547
>
> That's p->pi_lock, which gets initialized in rt_mutex_init_task() in
> copy_process(). This should be impossible. Very odd.

The stack mentions fbdev, which is a red flag at the moment. There are
a dozen of bad bugs in fbdev and around. Just few days ago Andy
pointed to another "impossible" crash "general protection fault in
do_syscall_64" which is related to dri:
https://syzkaller.appspot.com/bug?id=0Ec7b2602b1ff40f0d34f38baa4ba1640727c3=
d9
https://groups.google.com/forum/#!msg/syzkaller-bugs/ePqhfYx0-8M/Q_Urt97iAA=
AJ

There are probably more random manifestations of these bugs already,
and I guess we will be getting more.

+fbdev maintainers



> >  wake_up_worker kernel/workqueue.c:836 [inline]
> >  insert_work+0x2ad/0x3a0 kernel/workqueue.c:1337
> >  __queue_work+0x50d/0x1280 kernel/workqueue.c:1488
> >  call_timer_fn+0x195/0x760 kernel/time/timer.c:1404
> >  expire_timers kernel/time/timer.c:1444 [inline]
> >  __run_timers kernel/time/timer.c:1773 [inline]
> >  __run_timers kernel/time/timer.c:1740 [inline]
> >  run_timer_softirq+0x412/0x1600 kernel/time/timer.c:1786
> >  __do_softirq+0x26c/0x99d kernel/softirq.c:292
> >  invoke_softirq kernel/softirq.c:373 [inline]
> >  irq_exit+0x192/0x1d0 kernel/softirq.c:413
> >  exiting_irq arch/x86/include/asm/apic.h:546 [inline]
> >  smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1146
> >  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
> >  </IRQ>
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20200331095737.GO20730%40hirez.programming.kicks-ass.net.
