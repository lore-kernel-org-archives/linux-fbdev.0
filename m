From: Petr Mladek <pmladek@suse.com>
Date: Wed, 25 Jan 2017 14:08:45 +0000
Subject: [PATCH v2] printk: Correctly handle preemption in console_unlock()
Message-Id: <1485353325-26591-1-git-send-email-pmladek@suse.com>
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

This patch solves both problems by moving the "again" goto label.

Alternative solution was to clear and restore the value around
call_console_drivers(). Then console_conditional_schedule() could
be used also inside console_unlock(). But there was a potential race
with console_flush_on_panic() as reported by Sergey Senozhatsky.
That function should be called only where there is only one CPU
and with interrupts disabled. But better be on the safe side
because stopping CPUs might fail.

Fixes: 6b97a20d3a7909 ("printk: set may_schedule for some of console_trylock() callers")
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
Changes against v2:

  + use conservative solution with the following rules:

    + always clear console_may_schedule after again goto label

    + save and use the original value to decide about sleeping
      inside console unlock

    + do not set console_may_schedule using the saved value;
      it avoids potential race with console_flush_on_panic();
      also it avoids breaking the complex logic used in other
      functions manipulating this variable.

 kernel/printk/printk.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7180088cbb23..cc90c0a5ae21 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2158,19 +2158,18 @@ void console_unlock(void)
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
+	 * value must be stored so that we could schedule between lines.
+	 *
+	 * console_trylock() is not able to detect the preemtible
+	 * context reliably. Therefore the value must be stored before
+	 * and cleared after the the "again" goto label.
 	 */
 	do_cond_resched = console_may_schedule;
+again:
 	console_may_schedule = 0;
 
-again:
 	/*
 	 * We released the console_sem lock, so we need to recheck if
 	 * cpu is online and (if not) is there at least one CON_ANYTIME
-- 
1.8.5.6

