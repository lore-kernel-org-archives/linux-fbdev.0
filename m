From: Petr Mladek <pmladek@suse.com>
Date: Fri, 13 Jan 2017 11:15:29 +0000
Subject: Re: [PATCH] mm/page_alloc: Wait for oom_lock before retrying.
Message-Id: <20170113111529.GJ14894@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161220153948.GA575@tigerII.localdomain>
 <201612221927.BGE30207.OSFJMFLFOHQtOV@I-love.SAKURA.ne.jp>
 <20161222134250.GE413@tigerII.localdomain>
 <201612222301.AFG57832.QOFMSVFOJHLOtF@I-love.SAKURA.ne.jp>
 <20161222140930.GF413@tigerII.localdomain>
 <201612261954.FJE69201.OFLVtFJSQFOHMO@I-love.SAKURA.ne.jp>
 <20161226113407.GA515@tigerII.localdomain>
 <20170112131017.GF14894@pathway.suse.cz>
 <20170113025212.GB9360@jagdpanzerIV.localdomain>
 <20170113035307.GD9360@jagdpanzerIV.localdomain>
In-Reply-To: <20170113035307.GD9360@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, mhocko@suse.com, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri 2017-01-13 12:53:07, Sergey Senozhatsky wrote:
> On (01/13/17 11:52), Sergey Senozhatsky wrote:
> [..]
> > and we really don't want to cond_resched() when we are in panic.
> > that's why console_flush_on_panic() sets it to zero explicitly.
> > 
> > console_trylock() checks oops_in_progress, so re-taking the semaphore
> > when we are in
> > 
> > 	panic()
> > 	 console_flush_on_panic()
> >           console_unlock()
> >            console_trylock()
> > 
> > should be OK. as well as doing get_console_conditional_schedule() somewhere
> > in console driver code.
> 
> d'oh... no, this is false. console_flush_on_panic() is called after we
> bust_spinlocks(0), BUT with local IRQs disabled. so console_trylock()
> would still set console_may_schedule to 0.

Ah, you found it yourself.

Best Regards,
Petr
