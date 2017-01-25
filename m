From: Petr Mladek <pmladek@suse.com>
Date: Wed, 25 Jan 2017 12:34:10 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170125123410.GE6620@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484313321-17196-1-git-send-email-pmladek@suse.com>
 <20170113110542.2c3e42c5@gandalf.local.home>
 <20170116110012.GE20462@pathway.suse.cz>
 <20170118054551.GA881@jagdpanzerIV.localdomain>
 <20170118072141.GB881@jagdpanzerIV.localdomain>
In-Reply-To: <20170118072141.GB881@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed 2017-01-18 16:21:41, Sergey Senozhatsky wrote:
> On (01/18/17 14:45), Sergey Senozhatsky wrote:
> [..]
> > 
> > there is a function that clears @console_may_schedule out of
> > console_sem scope - console_flush_on_panic().
> > so I *may be* can think about a worst case scenario of race
> > condition between
> > 	console_flush_on_panic()->console_may_schedule = 0 on panic CPU
> > and
> > 	console_unlock()->console_may_schedule = 1 from CPU that panic CPU
> > failed to stop (smp_send_stop() can return with secondary CPUs still being
> > online).
> 
> what I mean, is that we can have, let's say, 2 CPUs spinning in
> console_unlock(), both with @console_may_schedule = 1 (because secondary
> CPU restores global @console_may_schedule value). now, suppose, we have
> misbehaving scheduler (well, we are in panic after all). secondary CPU
> will cond_resched() and may be lockup somewhere in the scheduler. which is
> fine, we don't care about that secondary CPU anyway. but the same can happen
> to panic CPU as well.
> 
> what do you think?

Great catch!

console_flush_on_panic() is called after smp_send_stop();
so only one CPU should be running. But it is not guaranteed.

Better be on the safe side. I am going to use a conservative
solution that will only move the "again" goto label.


Just some thoughts for a future work:

The dependencies between console_sem, console_may_schedule,
console_locked, and console_suspended are complex like hell.
There are several surprises.

For example, console_trylock() and console_lock() behave differently
when console_suspended is set. console_trylock() completely fails.
console_lock() succeeds but it does not modify console_locked
and console_may_schedule.

This is the reason why we do not need to check console_suspended
after the "again" goto target.


IMHO, the key to make it more straightforward is to split
console flushing functionality from console_unlock().

It is a bit problematic. console_unlock() guarantees that all
messages are flushed when the semaphore is finally released.
IMHO, it might get more relaxed with some deferred techniques.
The deferred handling is perfectly fine most of the time.
In emergency situations, the console_sem is either available
or we rely on console_flush_on_panic() anyway.

Best Regards,
Petr
