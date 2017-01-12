From: Petr Mladek <pmladek@suse.com>
Date: Thu, 12 Jan 2017 13:10:17 +0000
Subject: Re: [PATCH] mm/page_alloc: Wait for oom_lock before retrying.
Message-Id: <20170112131017.GF14894@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161220153948.GA575@tigerII.localdomain>
 <201612221927.BGE30207.OSFJMFLFOHQtOV@I-love.SAKURA.ne.jp>
 <20161222134250.GE413@tigerII.localdomain>
 <201612222301.AFG57832.QOFMSVFOJHLOtF@I-love.SAKURA.ne.jp>
 <20161222140930.GF413@tigerII.localdomain>
 <201612261954.FJE69201.OFLVtFJSQFOHMO@I-love.SAKURA.ne.jp>
 <20161226113407.GA515@tigerII.localdomain>
In-Reply-To: <20161226113407.GA515@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, mhocko@suse.com, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, sergey.senozhatsky.work@gmail.com

On Mon 2016-12-26 20:34:07, Sergey Senozhatsky wrote:
> Cc Greg, Jiri,
> 
> On (12/26/16 19:54), Tetsuo Handa wrote:
> [..]
> > 
> > (3) I got below warning. (Though not reproducible.)
> >     If fb_flashcursor() called console_trylock(), console_may_schedule is set to 1?
> 
> hmmm... it takes an atomic/spin `printing_lock' lock in vt_console_print(),
> then call console_conditional_schedule() from lf(), being under spin_lock.
> `console_may_schedule' in console_conditional_schedule() still keeps the
> value from console_trylock(), which was ok (console_may_schedule permits
> rescheduling). but preemption got changed under console_trylock(), by
> that spin_lock.
> 
> console_trylock() used to always forbid rescheduling; but it got changed
> like a yaer ago.
> 
> the other thing is... do we really need to console_conditional_schedule()
> from fbcon_*()? console_unlock() does cond_resched() after every line it
> prints. wouldn't that be enough?
> 
> so may be we can drop some of console_conditional_schedule()
> call sites in fbcon. or update console_conditional_schedule()
> function to always return the current preemption value, not the
> one we saw in console_trylock().
> 
> (not tested)
> 
> ---
> 
>  kernel/printk/printk.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 8b2696420abb..ad4a02cf9f15 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2075,6 +2075,24 @@ static int console_cpu_notify(unsigned int cpu)
>  	return 0;
>  }
>  
> +static int get_console_may_schedule(void)
> +{
> +	/*
> +	 * When PREEMPT_COUNT disabled we can't reliably detect if it's
> +	 * safe to schedule (e.g. calling printk while holding a spin_lock),
> +	 * because preempt_disable()/preempt_enable() are just barriers there
> +	 * and preempt_count() is always 0.
> +	 *
> +	 * RCU read sections have a separate preemption counter when
> +	 * PREEMPT_RCU enabled thus we must take extra care and check
> +	 * rcu_preempt_depth(), otherwise RCU read sections modify
> +	 * preempt_count().
> +	 */
> +	return !oops_in_progress &&
> +		preemptible() &&
> +		!rcu_preempt_depth();
> +}
> +
>  /**
>   * console_lock - lock the console system for exclusive use.
>   *
> @@ -2316,7 +2321,7 @@ EXPORT_SYMBOL(console_unlock);
>   */
>  void __sched console_conditional_schedule(void)
>  {
> -	if (console_may_schedule)
> +	if (get_console_may_schedule())

Note that console_may_schedule should be zero when
the console drivers are called. See the following lines in
console_unlock():

	/*
	 * Console drivers are called under logbuf_lock, so
	 * @console_may_schedule should be cleared before; however, we may
	 * end up dumping a lot of lines, for example, if called from
	 * console registration path, and should invoke cond_resched()
	 * between lines if allowable.  Not doing so can cause a very long
	 * scheduling stall on a slow console leading to RCU stall and
	 * softlockup warnings which exacerbate the issue with more
	 * messages practically incapacitating the system.
	 */
	do_cond_resched = console_may_schedule;
	console_may_schedule = 0;

IMHO, there is the problem described by Tetsuo in the other mail.
We do not call the above lines when the console semaphore is
re-taken and we do the main cycle again:

	/*
	 * Someone could have filled up the buffer again, so re-check if there's
	 * something to flush. In case we cannot trylock the console_sem again,
	 * there's a new owner and the console_unlock() from them will do the
	 * flush, no worries.
	 */
	raw_spin_lock(&logbuf_lock);
	retry = console_seq != log_next_seq;
	raw_spin_unlock_irqrestore(&logbuf_lock, flags);

	if (retry && console_trylock())
		goto again;


Well, simply moving the again: label is not correct as well.
The global variable is explicitly set in some functions:

	console_lock[2094]             console_may_schedule = 1;
	console_unblank[2339]          console_may_schedule = 0;
	console_flush_on_panic[2361]   console_may_schedule = 0;

But console_try_lock() will set it according to the real context
in console_unlock().


Hmm, the enforced values were there for ages (even in the initial
git commit). It was always 0 also console_trylock() until
the commit 6b97a20d3a7909daa06625d ("printk: set may_schedule for some
of console_trylock() callers").

It might make sense to completely remove the global
@console_may_schedule variable and always decide
by the context. It is slightly suboptimal. But it
simplifies the code and should be sane in all situations.

Sergey, if you agree with the above paragraph. Do you want to prepare
the patch or should I do so?

Best Regards,
Petr
