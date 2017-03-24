From: Petr Mladek <pmladek@suse.com>
Date: Fri, 24 Mar 2017 16:14:05 +0000
Subject: [PATCH v3] printk: Correctly handle preemption in console_unlock()
Message-Id: <1490372045-22288-1-git-send-email-pmladek@suse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170202093011.1e067ea7@gandalf.local.home>
In-Reply-To: <20170202093011.1e067ea7@gandalf.local.home>
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
Link to v2: https://lkml.kernel.org/r/1485353325-26591-1-git-send-email-pmladek@suse.com

Changes against v3:

  + do not remove useful details from the original comment
    as suggested by Steven and Sergey

  + fix typo in the new comment

Changes against v2:

  + use conservative solution with the following rules:

    + always clear console_may_schedule after again goto label

    + save and use the original value to decide about sleeping
      inside console unlock

    + do not set console_may_schedule using the saved value;
      it avoids potential race with console_flush_on_panic();
      also it avoids breaking the complex logic used in other
      functions manipulating this variable.

 kernel/printk/printk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2984fb0f0257..e5636fa04e66 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2161,7 +2161,7 @@ void console_unlock(void)
 	}
 
 	/*
-	 * Console drivers are called under logbuf_lock, so
+	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
 	 * end up dumping a lot of lines, for example, if called from
 	 * console registration path, and should invoke cond_resched()
@@ -2169,12 +2169,15 @@ void console_unlock(void)
 	 * scheduling stall on a slow console leading to RCU stall and
 	 * softlockup warnings which exacerbate the issue with more
 	 * messages practically incapacitating the system.
+	 *
+	 * console_trylock() is not able to detect the preemptive
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

