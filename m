From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Mon, 16 Jan 2017 13:43:28 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170116134328.GB23242@tigerII.localdomain>
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
Cc: Petr Mladek <pmladek@suse.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On (01/16/17 22:26), Sergey Senozhatsky wrote:
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

I meant that none of this is happening in vprintk_emit(). there is no
console_sem in vprintk_emit() at all. eveything is done in deferred printk.

	-ss
