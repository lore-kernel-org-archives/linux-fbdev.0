From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Wed, 18 Jan 2017 05:45:51 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170118054551.GA881@jagdpanzerIV.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484313321-17196-1-git-send-email-pmladek@suse.com>
 <20170113110542.2c3e42c5@gandalf.local.home>
 <20170116110012.GE20462@pathway.suse.cz>
In-Reply-To: <20170116110012.GE20462@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On (01/16/17 12:00), Petr Mladek wrote:
[..]
> > Makes perfect sense to me. The only thing that worries me is that it
> > does change the logic slightly, and I'm not sure if this will have any
> > ramifications with it. That is, console_unlock() use to always leave
> > with console_may_schedule equal to zero, where console_unlock() clears
> > it. With this change, console_unlock() no longer clears that variable.
> > Will that have any side effects that we are unaware of?
> 
> Good question!

it does look a bit worrisome.

> If I get it correctly, the variable should never be used without the
> console semaphore. IMHO, if it was used without the semaphore or if
> it was not set correctly when the semaphore was taken, it would be a
> bug. It means that leaving the variable set might actually help
> to find a buggy usage if there is any.
> 
> My findings:
> 
>   + console_may_lock is set only by functions that get the console
>     semaphore.
> 
>   + The function that takes the semaphore and does not set the
>     variable is resume_console(). IMHO, it is a bug.
> 
>     We are on the safe side because the function is called from
>     the same context as suspend_console() and it allows rescheduling.
> 
> 
>   + I am not aware of any use of the variable without the
>     semaphore. But it is not easy to prove just be reading
>     the code.

there is a function that clears @console_may_schedule out of
console_sem scope - console_flush_on_panic().
so I *may be* can think about a worst case scenario of race
condition between
	console_flush_on_panic()->console_may_schedule = 0 on panic CPU
and
	console_unlock()->console_may_schedule = 1 from CPU that panic CPU
failed to stop (smp_send_stop() can return with secondary CPUs still being
online).

thoughts?

	-ss
