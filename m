From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Mon, 16 Jan 2017 15:19:41 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170116151941.GC23242@tigerII.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484313321-17196-1-git-send-email-pmladek@suse.com>
 <20170114062825.GB699@tigerII.localdomain>
 <20170116113834.GF20462@pathway.suse.cz>
 <20170116115844.GA405@tigerII.localdomain>
 <20170116124822.GR14894@pathway.suse.cz>
 <20170116132633.GA23242@tigerII.localdomain>
 <20170116141455.GT14894@pathway.suse.cz>
In-Reply-To: <20170116141455.GT14894@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On (01/16/17 15:14), Petr Mladek wrote:
[..]
> > SYNC printk mode is also handled in deferred printk callback and
> > does console_trylock()/console_unlock().
> 
> I am confused by the sentence.
> 
> If it is a synchronous mode then console_trylock()/console_unlock() must
> be called directly from printk()/vprintk_emit().
> 
> If you move this to a deferred callback, it is not longer synchronous.

yes, everything is about to move to the deferred printk() handler.
it has been discussed during the LPC/KS session. Linus proposed it,
to be exact. and I was quite sure that everyone in the room,
including you, agreed. we either do everything asking scheduled for
help (wake_up()), which is async printk. or do the print out from
deferred printk() handler /** 1) in case of panic() there is a
console_flush_on_panic() call. 2) once the system stores at least
one EMERG loglevel message, we don't wake_up() printk_kthread from
deferred printk handler.  **/

but, well, probably this is not related to this thread.


> it is not longer synchronous.

well, a silly and boring note is that there is nothing that guarantees
or provides 'synchronous' printk(). console_sem simply can be locked
and printk() will just log_store(), while the actual printing will
happen sometime later (if ever) from whatever context that held the
console_sem. can be IRQ or anything else.

*may be* we need a new 'terminology' here. 'sync printk' does
not reflect the actual behavior and can give false expectations.
just a note.

> > > Then you would need to revert the entire commit 6b97a20d3a7909daa06625
> > > ("printk: set may_schedule for some of console_trylock() callers")
> > > to disable preemption also in preemptive kernel.
> > 
> > we check can_use_console() in console_unlock(), with console_sem acquired.
> > it's not like the CPU will suddenly go offline from under us.
> 
> I am not sure how this is related to the above. It talked about
> the "no resched" behavior.
> 
> If you want to avoid preemtion in preemtible kernel, you need to
> disable preemtion.
>
> If you want to avoid preemtion in non-preemtible kernel, it is
> enough to do _not_ call cond_resched()/schedule().
[..]
> Your mail
> https://lkml.kernel.org/r/20170114062825.GB699@tigerII.localdomain
> suggested to avoid calling cond_resched(). This reverted the
> original behavior only for non-preemtible kernel.
> If we wanted to restore the original behavior also for preemtible
> kernel, we would need to disable preemtion around console_trylock/
> console_unlock() calls again.

ah, ok. the code there is not even a patch. so yes, could be
incomplete/wrong "revert".

[..]
> > well, we can add that *_orig/etc, but is it really worth it?
> > console_trylock() won't be used that often. not in printk at
> > least.
> 
> IMHO, it is worth it because both patches go into the right direction.

well, ok. if you insist :)

	-ss
