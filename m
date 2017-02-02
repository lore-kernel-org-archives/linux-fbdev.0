From: Petr Mladek <pmladek@suse.com>
Date: Thu, 02 Feb 2017 16:40:12 +0000
Subject: Re: [PATCH v2] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170202164012.GI23754@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1485353325-26591-1-git-send-email-pmladek@suse.com>
 <20170202093011.1e067ea7@gandalf.local.home>
In-Reply-To: <20170202093011.1e067ea7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu 2017-02-02 09:30:11, Steven Rostedt wrote:
> On Wed, 25 Jan 2017 15:08:45 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 7180088cbb23..cc90c0a5ae21 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2158,19 +2158,18 @@ void console_unlock(void)
> >  	}
> >  
> >  	/*
> > -	 * Console drivers are called under logbuf_lock, so
> > -	 * @console_may_schedule should be cleared before; however, we may
> > -	 * end up dumping a lot of lines, for example, if called from
> > -	 * console registration path, and should invoke cond_resched()
> > -	 * between lines if allowable.  Not doing so can cause a very long
> > -	 * scheduling stall on a slow console leading to RCU stall and
> > -	 * softlockup warnings which exacerbate the issue with more
> > -	 * messages practically incapacitating the system.
> 
> Why did you remove the comment about invoking cond_resched()? It's
> still pertinent to the code, as there still exists a:
>
> 	if (do_cond_resched)
> 		cond_resched();
> 
> And the rational in the comment is still correct.

The comment was above an assignment to a variable called
"do_cond_resched". The variable was later used only on one place.
I hoped that the purpose of cond_resched() was a common knowledge.

The new comment still mentions scheduling between lines. But it
newly explains why it has to be done here and the relation to
the "again" label.

Would you prefer to keep the original text as is (modulo the context
in which the drivers are called) and just add the second paragraph?

Anyway, thank a lot for review.

Best Regards,
Petr

> -- Steve
> 
> > +	 * Console drivers are called with interrupts disabled, so
> > +	 * @console_may_schedule must be cleared before. The original
> > +	 * value must be stored so that we could schedule between lines.
> > +	 *
> > +	 * console_trylock() is not able to detect the preemtible
> > +	 * context reliably. Therefore the value must be stored before
> > +	 * and cleared after the the "again" goto label.
> >  	 */
> >  	do_cond_resched = console_may_schedule;
> > +again:
> >  	console_may_schedule = 0;
> >  
> > -again:
> >  	/*
> >  	 * We released the console_sem lock, so we need to recheck if
> >  	 * cpu is online and (if not) is there at least one CON_ANYTIME
> 
