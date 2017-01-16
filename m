From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Mon, 16 Jan 2017 11:58:44 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170116115844.GA405@tigerII.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484313321-17196-1-git-send-email-pmladek@suse.com>
 <20170114062825.GB699@tigerII.localdomain>
 <20170116113834.GF20462@pathway.suse.cz>
In-Reply-To: <20170116113834.GF20462@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On (01/16/17 12:38), Petr Mladek wrote:
[..]
> > > Now, @console_may_schedule is not cleared when we call
> > > console_trylock() and jump back to the "again" goto label.
> > > This has become a problem, since the commit 6b97a20d3a7909daa066
> > > ("printk: set may_schedule for some of console_trylock() callers").
> > 
> > so I think I'd prefer to revert that commit.
> > 
> > the reason I added the commit in question was to reduce the number of
> > printk() soft lockups that I observed back then. however, it obviously
> > didn't solve all of the printk() problems.
> 
> Interesting idea!
> 
> > now printk() is moving in a
> > completely different direction in term of lockups and deadlocks. there
> > will be no console_trylock() call in vprintk_emit() at all. we will
> > either do console_lock() from scheduleable printk_kthread or
> > console_trylock() from IRQ work. so 6b97a20d3a7909daa066 didn't buy us
> > a lot, and it still doesn't (+ it introduced a bug).
> 
> Well, console_trylock() still will be there for the sync mode.
> Or do I miss anything?

you mean in console_unlock()? there we inherit may_schedule from the
original console_sem lock path, which sould be console_lock() in async
printk case (IOW, preemptible).

other then that - from printk POV, I don't think we will care that much.
anything that directly calls console_lock()/console_trylock will be doing
console_unlock(). those paths are not addressed by async printk anyway.
I have some plans on addressing it, as you know, but that's a later work.

so let's return good ol' bhaviour:
-- console_trylock is always "no resched"
-- console_lock is always "enable resched" (regardless of
   console_trylock calls from console_unlock()).


> > apart from that, Tetsuo wasn't really happy with the patch
> > http://www.spinics.net/lists/linux-mm/msg103099.html
> 
> The complain is questionable. If a code is sensitive for preemption,
> it should disable preemption.
>
> Another question is if people expect that printk() would call
> cond_resched() or preempt.

my assumption would be that probably people expect printk to work
asap.


[..]
> This would revert the change only for non-preemptive kernel.
> 
> The commit 6b97a20d3a7909daa06625 ("printk: set may_schedule for some
> of console_trylock() callers" also enabled preemption which still
> affects preemtible kernel.
> 
> Do we want to behave differently in preemptive and non-preemtive
> kernel?

not sure I'm following here. in non-preemptible kernels console_trylock()
always sets console_may_schedule to 0, just like it did before. in
preemptible kernels we now will also set console_may_schedule to 0.
just like before.


in any case, we return back the old behavior. there should be no issues (tm)

	-ss
