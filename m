From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 13 Jan 2017 16:05:42 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170113110542.2c3e42c5@gandalf.local.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484313321-17196-1-git-send-email-pmladek@suse.com>
In-Reply-To: <1484313321-17196-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 13 Jan 2017 14:15:21 +0100
Petr Mladek <pmladek@suse.com> wrote:

> ---
> This is related to the thread
> https://lkml.kernel.org/r/201612261954.FJE69201.OFLVtFJSQFOHMO@I-love.SAKURA.ne.jp
> 
>  kernel/printk/printk.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 7180088cbb23..2ac54291230d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2150,7 +2150,7 @@ void console_unlock(void)
>  	static u64 seen_seq;
>  	unsigned long flags;
>  	bool wake_klogd = false;
> -	bool do_cond_resched, retry;
> +	bool may_schedule_orig, retry;

<bike-shedding>
 Hmm, I just hate the name of that variable.
 console_may_schedule_orig, keep the full name?
</bike-shedding>

>  
>  	if (console_suspended) {
>  		up_console_sem();
> @@ -2158,17 +2158,15 @@ void console_unlock(void)
>  	}
>  
>  	/*
> -	 * Console drivers are called under logbuf_lock, so
> -	 * @console_may_schedule should be cleared before; however, we may
> -	 * end up dumping a lot of lines, for example, if called from
> -	 * console registration path, and should invoke cond_resched()
> -	 * between lines if allowable.  Not doing so can cause a very long
> -	 * scheduling stall on a slow console leading to RCU stall and
> -	 * softlockup warnings which exacerbate the issue with more
> -	 * messages practically incapacitating the system.
> +	 * Console drivers are called with interrupts disabled, so
> +	 * @console_may_schedule must be cleared before. The original
> +	 * value must be restored so that we could schedule between lines.
> +	 *
> +	 * console_trylock() is not able to detect the preemptive context when
> +	 * CONFIG_PREEMPT_COUNT is disabled. Therefore the value must be
> +	 * stored before the "again" goto label.
>  	 */
> -	do_cond_resched = console_may_schedule;
> -	console_may_schedule = 0;
> +	may_schedule_orig = console_may_schedule;
>  
>  again:
>  	/*
> @@ -2235,12 +2233,13 @@ void console_unlock(void)
>  		raw_spin_unlock(&logbuf_lock);
>  
>  		stop_critical_timings();	/* don't trace print latency */
> +		console_may_schedule = 0;
>  		call_console_drivers(ext_text, ext_len, text, len);
> +		console_may_schedule = may_schedule_orig;
>  		start_critical_timings();
>  		printk_safe_exit_irqrestore(flags);
>  
> -		if (do_cond_resched)
> -			cond_resched();
> +		console_conditional_schedule();

Makes perfect sense to me. The only thing that worries me is that it
does change the logic slightly, and I'm not sure if this will have any
ramifications with it. That is, console_unlock() use to always leave
with console_may_schedule equal to zero, where console_unlock() clears
it. With this change, console_unlock() no longer clears that variable.
Will that have any side effects that we are unaware of?

-- Steve

>  	}
>  	console_locked = 0;
>  

