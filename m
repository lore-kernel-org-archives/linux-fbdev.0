From: Petr Mladek <pmladek@suse.com>
Date: Fri, 13 Jan 2017 13:15:21 +0000
Subject: [PATCH] printk: Correctly handle preemption in console_unlock()
Message-Id: <1484313321-17196-1-git-send-email-pmladek@suse.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>

Some console drivers code calls console_conditional_schedule()
that looks at @console_may_schedule. The value must be cleared
when the drivers are called from console_unlock() with
interrupts disabled. But rescheduling is fine when the same
code is called, for example, from tty operations where the
console semaphore is taken via console_lock().

This is why @console_may_schedule is cleared before calling console
drivers. The original value is stored to decide if we could sleep
between lines.

Now, @console_may_schedule is not cleared when we call
console_trylock() and jump back to the "again" goto label.
This has become a problem, since the commit 6b97a20d3a7909daa066
("printk: set may_schedule for some of console_trylock() callers").
@console_may_schedule might get enabled now.

There is also the opposite problem. console_lock() can be called
only from preemptive context. It can always enable scheduling in
the console code. But console_trylock() is not able to detect it
when CONFIG_PREEMPT_COUNT is disabled. Therefore we should use the
original @console_may_schedule value after re-acquiring
the console semaphore in console_unlock().

This patch solves both problems by clearing and restoring the very
original @may_schedule setting only around call_console_drivers().

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
This is related to the thread
https://lkml.kernel.org/r/201612261954.FJE69201.OFLVtFJSQFOHMO@I-love.SAKURA.ne.jp

 kernel/printk/printk.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7180088cbb23..2ac54291230d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2150,7 +2150,7 @@ void console_unlock(void)
 	static u64 seen_seq;
 	unsigned long flags;
 	bool wake_klogd = false;
-	bool do_cond_resched, retry;
+	bool may_schedule_orig, retry;
 
 	if (console_suspended) {
 		up_console_sem();
@@ -2158,17 +2158,15 @@ void console_unlock(void)
 	}
 
 	/*
-	 * Console drivers are called under logbuf_lock, so
-	 * @console_may_schedule should be cleared before; however, we may
-	 * end up dumping a lot of lines, for example, if called from
-	 * console registration path, and should invoke cond_resched()
-	 * between lines if allowable.  Not doing so can cause a very long
-	 * scheduling stall on a slow console leading to RCU stall and
-	 * softlockup warnings which exacerbate the issue with more
-	 * messages practically incapacitating the system.
+	 * Console drivers are called with interrupts disabled, so
+	 * @console_may_schedule must be cleared before. The original
+	 * value must be restored so that we could schedule between lines.
+	 *
+	 * console_trylock() is not able to detect the preemptive context when
+	 * CONFIG_PREEMPT_COUNT is disabled. Therefore the value must be
+	 * stored before the "again" goto label.
 	 */
-	do_cond_resched = console_may_schedule;
-	console_may_schedule = 0;
+	may_schedule_orig = console_may_schedule;
 
 again:
 	/*
@@ -2235,12 +2233,13 @@ void console_unlock(void)
 		raw_spin_unlock(&logbuf_lock);
 
 		stop_critical_timings();	/* don't trace print latency */
+		console_may_schedule = 0;
 		call_console_drivers(ext_text, ext_len, text, len);
+		console_may_schedule = may_schedule_orig;
 		start_critical_timings();
 		printk_safe_exit_irqrestore(flags);
 
-		if (do_cond_resched)
-			cond_resched();
+		console_conditional_schedule();
 	}
 	console_locked = 0;
 
-- 
1.8.5.6

