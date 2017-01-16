From: Petr Mladek <pmladek@suse.com>
Date: Mon, 16 Jan 2017 14:14:55 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170116141455.GT14894@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484313321-17196-1-git-send-email-pmladek@suse.com>
 <20170114062825.GB699@tigerII.localdomain>
 <20170116113834.GF20462@pathway.suse.cz>
 <20170116115844.GA405@tigerII.localdomain>
 <20170116124822.GR14894@pathway.suse.cz>
 <20170116132633.GA23242@tigerII.localdomain>
In-Reply-To: <20170116132633.GA23242@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon 2017-01-16 22:26:33, Sergey Senozhatsky wrote:
> On (01/16/17 13:48), Petr Mladek wrote:
> [..]
> > The async printk code looks like this:
> > 
> > vprintk_emit(...)
> > {
> > 
> > 
> > 		if (can_printk_async()) {
> > 			/* Offload printing to a schedulable context. */
> > 			printk_kthread_need_flush_console = true;
> > 			wake_up_process(printk_kthread);
> > 		} else {
> > 			/*
> > 			 * Try to acquire and then immediately release the
> > 			 * console semaphore.  The release will print out
> > 			 * buffers and wake up /dev/kmsg and syslog() users.
> > 			 */
> > 			if (console_trylock())
> > 				console_unlock();
> > 		}
> > 
> > So, there is still the console_trylock() for the sync mode. Or do I
> > see an outdated variant?
> 
> no, it doesn't.
> 
> ASYNC printk looks like a wake_up of printk_kthread from deferred
> printk handler. and printk_kthread does a while-loop, calling
> console_lock() and doing console_unlock().

Yup.

> SYNC printk mode is also handled in deferred printk callback and
> does console_trylock()/console_unlock().

I am confused by the sentence.

If it is a synchronous mode then console_trylock()/console_unlock() must
be called directly from printk()/vprintk_emit().

If you move this to a deferred callback, it is not longer synchronous.


> > > other then that - from printk POV, I don't think we will care that much.
> > > anything that directly calls console_lock()/console_trylock will be doing
> > > console_unlock(). those paths are not addressed by async printk anyway.
> > > I have some plans on addressing it, as you know, but that's a later work.
> > > 
> > > so let's return good ol' bhaviour:
> > > -- console_trylock is always "no resched"
> > 
> > Then you would need to revert the entire commit 6b97a20d3a7909daa06625
> > ("printk: set may_schedule for some of console_trylock() callers")
> > to disable preemption also in preemptive kernel.
> 
> we check can_use_console() in console_unlock(), with console_sem acquired.
> it's not like the CPU will suddenly go offline from under us.

I am not sure how this is related to the above. It talked about
the "no resched" behavior.

If you want to avoid preemtion in preemtible kernel, you need to
disable preemtion.

If you want to avoid preemtion in non-preemtible kernel, it is
enough to do _not_ call cond_resched()/schedule().

Your mail
https://lkml.kernel.org/r/20170114062825.GB699@tigerII.localdomain
suggested to avoid calling cond_resched(). This reverted the
original behavior only for non-preemtible kernel.

If we wanted to restore the original behavior also for preemtible
kernel, we would need to disable preemtion around console_trylock/
console_unlock() calls again.


> > > -- console_lock is always "enable resched" (regardless of
> > >    console_trylock calls from console_unlock()).
> > 
> > This was always broken. If we want to fix this, we need
> > some variant of my patch.
> 
> you mean the "console_trylock calls from console_unlock()" part.
> well, may be. it sort of works for me. we safe may_schedule from
> the original context and then don't care about console_trylock().
> 
> it's a bit fragile, though. took me 1 year to find out that I
> accidentally broke it.

That only means that the problem is a corner case. Note that Tetsuo
found it by some stress test that puts the machine beyond usability.

I personally think that the enabled preemtion and automatic detection
of the context makes perfect sense.

[...]

> > My proposal:
> > 
> > 1. Keep the commit 6b97a20d3a7909d as is. As I wrote above. If
> >    a function takes a long and it is called in preemtible context,
> >    it should preempt.
> > 
> >    The fact that printk() might take long is bad. But this will
> >    get solved by async mode. The cond_resched still makes sense in
> >    sync mode.
> >
> > 
> > 2. Fix clearing/storing console_might_schedule in console_unlock().
> >    It makes sense for keeping the setting from console_lock() even
> >    if console_trylock() always set 0.
> 
> well, we can add that *_orig/etc, but is it really worth it?
> console_trylock() won't be used that often. not in printk at
> least.

IMHO, it is worth it because both patches go into the right direction.

Your commit allows to preemt a potentially long call in preemtible
context. It makes perfect sense. And it will be usable in the sync mode.

My patch is needed if we keep your commit and I vote for it.
Also it might safe someone a time in the future if he wanted
to solve the prepemtion again. Note how much effort it took
us to understand the side effects and the
console_trylock()/goto-again influence.

Best Regards,
Petr
