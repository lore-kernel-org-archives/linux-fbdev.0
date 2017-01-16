From: Petr Mladek <pmladek@suse.com>
Date: Mon, 16 Jan 2017 12:48:22 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170116124822.GR14894@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484313321-17196-1-git-send-email-pmladek@suse.com>
 <20170114062825.GB699@tigerII.localdomain>
 <20170116113834.GF20462@pathway.suse.cz>
 <20170116115844.GA405@tigerII.localdomain>
In-Reply-To: <20170116115844.GA405@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon 2017-01-16 20:58:44, Sergey Senozhatsky wrote:
> On (01/16/17 12:38), Petr Mladek wrote:
> [..]
> > > > Now, @console_may_schedule is not cleared when we call
> > > > console_trylock() and jump back to the "again" goto label.
> > > > This has become a problem, since the commit 6b97a20d3a7909daa066
> > > > ("printk: set may_schedule for some of console_trylock() callers").
> > > 
> > > so I think I'd prefer to revert that commit.
> > > 
> > > the reason I added the commit in question was to reduce the number of
> > > printk() soft lockups that I observed back then. however, it obviously
> > > didn't solve all of the printk() problems.
> > 
> > Interesting idea!
> > 
> > > now printk() is moving in a
> > > completely different direction in term of lockups and deadlocks. there
> > > will be no console_trylock() call in vprintk_emit() at all. we will
> > > either do console_lock() from scheduleable printk_kthread or
> > > console_trylock() from IRQ work. so 6b97a20d3a7909daa066 didn't buy us
> > > a lot, and it still doesn't (+ it introduced a bug).
> > 
> > Well, console_trylock() still will be there for the sync mode.
> > Or do I miss anything?
> 
> you mean in console_unlock()? there we inherit may_schedule from the
> original console_sem lock path, which sould be console_lock() in async
> printk case (IOW, preemptible).

The async printk code looks like this:

vprintk_emit(...)
{


		if (can_printk_async()) {
			/* Offload printing to a schedulable context. */
			printk_kthread_need_flush_console = true;
			wake_up_process(printk_kthread);
		} else {
			/*
			 * Try to acquire and then immediately release the
			 * console semaphore.  The release will print out
			 * buffers and wake up /dev/kmsg and syslog() users.
			 */
			if (console_trylock())
				console_unlock();
		}

So, there is still the console_trylock() for the sync mode. Or do I
see an outdated variant?


> other then that - from printk POV, I don't think we will care that much.
> anything that directly calls console_lock()/console_trylock will be doing
> console_unlock(). those paths are not addressed by async printk anyway.
> I have some plans on addressing it, as you know, but that's a later work.
> 
> so let's return good ol' bhaviour:
> -- console_trylock is always "no resched"

Then you would need to revert the entire commit 6b97a20d3a7909daa06625
("printk: set may_schedule for some of console_trylock() callers")
to disable preemption also in preemptive kernel.



> -- console_lock is always "enable resched" (regardless of
>    console_trylock calls from console_unlock()).

This was always broken. If we want to fix this, we need
some variant of my patch.


> > > apart from that, Tetsuo wasn't really happy with the patch
> > > http://www.spinics.net/lists/linux-mm/msg103099.html
> > 
> > The complain is questionable. If a code is sensitive for preemption,
> > it should disable preemption.
> >
> > Another question is if people expect that printk() would call
> > cond_resched() or preempt.
> 
> my assumption would be that probably people expect printk to work
> asap.

Sure. But this will be solved by the async mode. If people force
sync mode there always will be a risk that printk() might take long.

IMHO, if a code takes a long time and it is called in preemtible
context it should get preempted. => We should keep that cond_resched()
and allow to call it for the synchronous mode.


> [..]
> > This would revert the change only for non-preemptive kernel.
> > 
> > The commit 6b97a20d3a7909daa06625 ("printk: set may_schedule for some
> > of console_trylock() callers" also enabled preemption which still
> > affects preemtible kernel.
> > 
> > Do we want to behave differently in preemptive and non-preemtive
> > kernel?
> 
> not sure I'm following here. in non-preemptible kernels console_trylock()
> always sets console_may_schedule to 0, just like it did before.

No, if CONFIG_PREEMPT_COUNT is enabled then we are able to detect
preemtible context even on non-preemtible kernel. Then

	console_may_schedule = !oops_in_progress &&
			preemptible() &&
			!rcu_preempt_depth();

might eventually allow scheduling.


> preemptible kernels we now will also set console_may_schedule to 0.
> just like before.

Only, the following part of the commit 6b97a20d3a7909d was important for
preemtible kernel:

@@ -1758,20 +1758,12 @@ asmlinkage int vprintk_emit(int facility, int level,
        if (!in_sched) {
                lockdep_off();
                /*
-                * Disable preemption to avoid being preempted while holding
-                * console_sem which would prevent anyone from printing to
-                * console
-                */
-               preempt_disable();
-
-               /*
                 * Try to acquire and then immediately release the console
                 * semaphore.  The release will print out buffers and wake up
                 * /dev/kmsg and syslog() users.
                 */
                if (console_trylock())
                        console_unlock();
-               preempt_enable();
                lockdep_on();
        }


Note that cond_resched() is a non-op in preemtible kernel. See the
following code is in current Linus' tree in include/linux/sched.h:

#ifndef CONFIG_PREEMPT
extern int _cond_resched(void);
#else
static inline int _cond_resched(void) { return 0; }
#endif

It makes perfect sense. The following code is needed for
non-preemtible kernel:

	local_irq_restore(flags);
	cond_resched()

but the following code does the same job in preemtible kernel:

	local_irq_restore(flags);

If there is a pending interrupt/timer that would cause preemption
in preemtible kernel, it will happen immediately when interrupts
are enabled. We do not need to call cond_resched() for this.
Also if the interrupt/timers is not pending, it does not make
sense to call cond_resched() because the time for the task
has not elapsed yet.


My proposal:

1. Keep the commit 6b97a20d3a7909d as is. As I wrote above. If
   a function takes a long and it is called in preemtible context,
   it should preempt.

   The fact that printk() might take long is bad. But this will
   get solved by async mode. The cond_resched still makes sense in
   sync mode.


2. Fix clearing/storing console_might_schedule in console_unlock().
   It makes sense for keeping the setting from console_lock() even
   if console_trylock() always set 0.


Best Regards,
Petr
