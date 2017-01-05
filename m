From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Thu, 05 Jan 2017 10:56:18 +0000
Subject: Re: printk: reset may_schedule if console_trylock() from console_unlock()
Message-Id: <20170105105618.GE480@jagdpanzerIV.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201701051927.IJF65159.OFFtSLQOOFHJMV@I-love.SAKURA.ne.jp>
In-Reply-To: <201701051927.IJF65159.OFFtSLQOOFHJMV@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: sergey.senozhatsky@gmail.com, pmladek@suse.com, jack@suse.com, tj@kernel.org, kyle@kernel.org, davej@codemonkey.org.uk, calvinowens@fb.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, sergey.senozhatsky.work@gmail.com

On (01/05/17 19:27), Tetsuo Handa wrote:
[..]
> > the other thing is... do we really need to console_conditional_schedule()
> > from fbcon_*()? console_unlock() does cond_resched() after every line it
> > prints. wouldn't that be enough?
> 
> Every record, isn't it?

yes. after every call to console drivers.


> How many bytes can a record write to consoles?

1024 - PREFIX_MAX bytes at most.


> > so may be we can drop some of console_conditional_schedule()
> > call sites in fbcon. or update console_conditional_schedule()
> > function to always return the current preemption value, not the
> > one we saw in console_trylock().
> 
> Replacing console_may_schedule with get_console_may_schedule() will avoid
> this bug. I noticed that we forgot to reset console_may_schedule to 0
> because the "again:" label is located after the assignment line.

well...
we call cond_resched() from under the spin_lock(), which modifies the
preempt count and cond_resched() which we call from
console_conditional_schedule() checks that current->preempt count is
0 before it calls tif_need_resched().

there are configs/setups where spinlock does not modify preempt count,
but I suspect that on those setups cond_resched() does nothing.

so it looks to me that we just WARN from ___might_sleep() but, at least
in this particular case, I don't think we can actually schedule().
but I just had a very quick look, so I may be completely wrong. need
to double check.

what I tried to say:
-- I will send out a patch for printk() once we settle down the current
   work in progress.

why do I want to address this in printk? because who knows, may be there
is (or there will be) something out there that takes rcu_read_lock() and
then does the console_conditional_schedule(). rcu does not modify current
preempt count, it has its own preempt counter, and get_console_may_schedule()
takes that into account.


> What happened here was:
> 
> [...]

I need more time to walk through your analysis/proposal.

	-ss
