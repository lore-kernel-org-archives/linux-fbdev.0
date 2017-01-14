From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Sat, 14 Jan 2017 06:28:25 +0000
Subject: Re: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170114062825.GB699@tigerII.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484313321-17196-1-git-send-email-pmladek@suse.com>
In-Reply-To: <1484313321-17196-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On (01/13/17 14:15), Petr Mladek wrote:
> Some console drivers code calls console_conditional_schedule()
> that looks at @console_may_schedule. The value must be cleared
> when the drivers are called from console_unlock() with
> interrupts disabled. But rescheduling is fine when the same
> code is called, for example, from tty operations where the
> console semaphore is taken via console_lock().
> 
> This is why @console_may_schedule is cleared before calling console
> drivers. The original value is stored to decide if we could sleep
> between lines.
> 
> Now, @console_may_schedule is not cleared when we call
> console_trylock() and jump back to the "again" goto label.
> This has become a problem, since the commit 6b97a20d3a7909daa066
> ("printk: set may_schedule for some of console_trylock() callers").

so I think I'd prefer to revert that commit.

the reason I added the commit in question was to reduce the number of
printk() soft lockups that I observed back then. however, it obviously
didn't solve all of the printk() problems. now printk() is moving in a
completely different direction in term of lockups and deadlocks. there
will be no console_trylock() call in vprintk_emit() at all. we will
either do console_lock() from scheduleable printk_kthread or
console_trylock() from IRQ work. so 6b97a20d3a7909daa066 didn't buy us
a lot, and it still doesn't (+ it introduced a bug).


apart from that, Tetsuo wasn't really happy with the patch
http://www.spinics.net/lists/linux-mm/msg103099.html


so let's just return the old behavior back.

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7180088cbb23..ddfbd47398f8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2078,20 +2078,7 @@ int console_trylock(void)
                return 0;
        }
        console_locked = 1;
-       /*
-        * When PREEMPT_COUNT disabled we can't reliably detect if it's
-        * safe to schedule (e.g. calling printk while holding a spin_lock),
-        * because preempt_disable()/preempt_enable() are just barriers there
-        * and preempt_count() is always 0.
-        *
-        * RCU read sections have a separate preemption counter when
-        * PREEMPT_RCU enabled thus we must take extra care and check
-        * rcu_preempt_depth(), otherwise RCU read sections modify
-        * preempt_count().
-        */
-       console_may_schedule = !oops_in_progress &&
-                       preemptible() &&
-                       !rcu_preempt_depth();
+       console_may_schedule = 0;
        return 1;
 }
 EXPORT_SYMBOL(console_trylock);

