From: Petr Mladek <pmladek@suse.com>
Date: Mon, 16 Jan 2017 16:35:34 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170116163534.GG20462@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484313321-17196-1-git-send-email-pmladek@suse.com>
 <20170114062825.GB699@tigerII.localdomain>
 <20170116113834.GF20462@pathway.suse.cz>
 <20170116115844.GA405@tigerII.localdomain>
 <20170116124822.GR14894@pathway.suse.cz>
 <20170116132633.GA23242@tigerII.localdomain>
 <20170116141455.GT14894@pathway.suse.cz>
 <20170116151941.GC23242@tigerII.localdomain>
 <20170116154343.GD23242@tigerII.localdomain>
In-Reply-To: <20170116154343.GD23242@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue 2017-01-17 00:43:43, Sergey Senozhatsky wrote:
> On (01/17/17 00:19), Sergey Senozhatsky wrote:
> [..]
> > > I am confused by the sentence.
> > > 
> > > If it is a synchronous mode then console_trylock()/console_unlock() must
> > > be called directly from printk()/vprintk_emit().
> > > 
> > > If you move this to a deferred callback, it is not longer synchronous.
> > 
> > yes, everything is about to move to the deferred printk() handler.
> > it has been discussed during the LPC/KS session. Linus proposed it,
> > to be exact. and I was quite sure that everyone in the room,
> > including you, agreed. we either do everything asking scheduled for
> > help (wake_up()), which is async printk. or do the print out from
> > deferred printk() handler /** 1) in case of panic() there is a
> > console_flush_on_panic() call. 2) once the system stores at least
> > one EMERG loglevel message, we don't wake_up() printk_kthread from
> > deferred printk handler.  **/
> 
> gosh.. sorry. I need some rest. badly. the above is not completely
> accurate. "make printk always behave like printk deferred" was in
> my presentation and proposal. the difference was in EMERG loglevel
> handling. Linus suggested to handle it in deferred printk handler
> as well, while I initially wanted to handle EMERG messages in
> vprintk_emit() as a special case/exception. but I like the idea of
> doing everything in printk deferred handler better. printk is moving
> there anyway. otherwise there is no way of resolving printk deadlocks
> on "external" locks.

Yes, this is the direction. But I can not imagine to do all this in one
big step. It is even possible that it will simply not work. Just remember
the problems with suspend, sysrq, kexec.

There are more paths where we need to make sure that the messages
are flushed. And we must not rely only on deferred solutions (IRQ,
kthread) because they simply need not happen.

My expectation is that we will keep the sync mode as it is now for
some (long time). And we will do more and more deferring in the
async mode step by step. If the async mode proves to be perfectly
usable and people do not need the sync mode any longer, we could
remove the sync mode but only then.

By other words, I expect that we would first push a solution similar
to v12. It was tested for years in SUSE. Any bigger changes
would just cause another huge delay.

I am sorry but I am not a crazy jumper. The async printk idea was
blocked for years. We should not go into the other extreme now.

Best Regards,
Petr
