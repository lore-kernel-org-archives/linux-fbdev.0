From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 16 Jan 2017 13:41:08 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <201701162241.JDE34880.OFOMVLOJQFtHFS@I-love.SAKURA.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484313321-17196-1-git-send-email-pmladek@suse.com>
        <20170114062825.GB699@tigerII.localdomain>
        <20170116113834.GF20462@pathway.suse.cz>
        <20170116115844.GA405@tigerII.localdomain>
In-Reply-To: <20170116115844.GA405@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergey.senozhatsky@gmail.com, pmladek@suse.com
Cc: rostedt@goodmis.org, peterz@infradead.org, akpm@linux-foundation.org, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Sergey Senozhatsky wrote:
> On (01/16/17 12:38), Petr Mladek wrote:
> > > apart from that, Tetsuo wasn't really happy with the patch
> > > http://www.spinics.net/lists/linux-mm/msg103099.html
> > 
> > The complain is questionable. If a code is sensitive for preemption,
> > it should disable preemption.
> >
> > Another question is if people expect that printk() would call
> > cond_resched() or preempt.
> 
> my assumption would be that probably people expect printk to work
> asap.

The code executed with oom_lock held is sensitive for preemption. I tried
to disable preemption, but it was not accepted. What is so sorry is that
this is not really a problem of printk() because sleeping for minutes
(presumably forever) with oom_lock held is triggerable without printk().
It is a problem of memory page allocator which consumes a lot of CPU time
for pointless direct reclaim rather than giving CPU time to a thread which
held the oom_lock. I tried to wait for oom_lock in order to give CPU time
to the thread holding the oom_lock, but it was not accepted neither.
