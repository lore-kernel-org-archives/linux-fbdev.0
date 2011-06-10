From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 10 Jun 2011 12:34:16 +0000
Subject: Re: [PATCH 1/3] printk: Release console_sem after logbuf_lock
Message-Id: <20110610123416.GA12451@elte.hu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110609130647.937204592@chello.nl>
 <20110609131307.493181962@chello.nl>
 <20110609130617.f8aca966.akpm@linux-foundation.org>
 <20110609202707.GA28951@elte.hu>
 <1307652883.2497.1028.camel@laptop>
 <20110609140714.fc9ea187.akpm@linux-foundation.org>
 <alpine.LSU.2.00.1106091655560.2710@sister.anvils>
 <1307705311.3941.118.camel@twins>
 <1307709030.3941.134.camel@twins>
In-Reply-To: <1307709030.3941.134.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, efault@gmx.de, Arne Jansen <lists@die-jansens.de>, PaulMundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> thinking that that would have my printk stmts appear on both the 
> fbcon as well as the serial line. But they fail to appear on the 
> latency tracer (current max was 165us waking an idle cpu).

Have you removed this bit:

                spin_unlock(&logbuf_lock);
                stop_critical_timings();        /* don't trace print latency */
                call_console_drivers(_con_start, _log_end);
                start_critical_timings();
                local_irq_restore(flags);

which hides the latencies from the latency tracer?

Thanks,

	Ingo
