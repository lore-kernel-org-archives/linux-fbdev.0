From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Mon, 16 Jan 2017 13:26:33 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170116132633.GA23242@tigerII.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484313321-17196-1-git-send-email-pmladek@suse.com>
 <20170114062825.GB699@tigerII.localdomain>
 <20170116113834.GF20462@pathway.suse.cz>
 <20170116115844.GA405@tigerII.localdomain>
 <20170116124822.GR14894@pathway.suse.cz>
In-Reply-To: <20170116124822.GR14894@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On (01/16/17 13:48), Petr Mladek wrote:
[..]
> The async printk code looks like this:
> 
> vprintk_emit(...)
> {
> 
> 
> 		if (can_printk_async()) {
> 			/* Offload printing to a schedulable context. */
> 			printk_kthread_need_flush_console = true;
> 			wake_up_process(printk_kthread);
> 		} else {
> 			/*
> 			 * Try to acquire and then immediately release the
> 			 * console semaphore.  The release will print out
> 			 * buffers and wake up /dev/kmsg and syslog() users.
> 			 */
> 			if (console_trylock())
> 				console_unlock();
> 		}
> 
> So, there is still the console_trylock() for the sync mode. Or do I
> see an outdated variant?

no, it doesn't.

ASYNC printk looks like a wake_up of printk_kthread from deferred
printk handler. and printk_kthread does a while-loop, calling
console_lock() and doing console_unlock().

SYNC printk mode is also handled in deferred printk callback and
does console_trylock()/console_unlock().


> > other then that - from printk POV, I don't think we will care that much.
> > anything that directly calls console_lock()/console_trylock will be doing
> > console_unlock(). those paths are not addressed by async printk anyway.
> > I have some plans on addressing it, as you know, but that's a later work.
> > 
> > so let's return good ol' bhaviour:
> > -- console_trylock is always "no resched"
> 
> Then you would need to revert the entire commit 6b97a20d3a7909daa06625
> ("printk: set may_schedule for some of console_trylock() callers")
> to disable preemption also in preemptive kernel.

we check can_use_console() in console_unlock(), with console_sem acquired.
it's not like the CPU will suddenly go offline from under us.

> > -- console_lock is always "enable resched" (regardless of
> >    console_trylock calls from console_unlock()).
> 
> This was always broken. If we want to fix this, we need
> some variant of my patch.

you mean the "console_trylock calls from console_unlock()" part.
well, may be. it sort of works for me. we safe may_schedule from
the original context and then don't care about console_trylock().

it's a bit fragile, though. took me 1 year to find out that I
accidentally broke it.


[..]
> > not sure I'm following here. in non-preemptible kernels console_trylock()
> > always sets console_may_schedule to 0, just like it did before.
> 
> No, if CONFIG_PREEMPT_COUNT is enabled then we are able to detect
> preemtible context even on non-preemtible kernel. Then
> 
> 	console_may_schedule = !oops_in_progress &&
> 			preemptible() &&
> 			!rcu_preempt_depth();
> 
> might eventually allow scheduling.

yes. well, that was the idea behind those lines. the question is - do we
really need it after all? given that there won't be console_trylock() in
printk path any more. my call -- we probably don't need it. thus I'm
proposing to return back console_trylock() we used to have.

> My proposal:
> 
> 1. Keep the commit 6b97a20d3a7909d as is. As I wrote above. If
>    a function takes a long and it is called in preemtible context,
>    it should preempt.
> 
>    The fact that printk() might take long is bad. But this will
>    get solved by async mode. The cond_resched still makes sense in
>    sync mode.
>
> 
> 2. Fix clearing/storing console_might_schedule in console_unlock().
>    It makes sense for keeping the setting from console_lock() even
>    if console_trylock() always set 0.

well, we can add that *_orig/etc, but is it really worth it?
console_trylock() won't be used that often. not in printk at
least.

	-ss
