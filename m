From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 19 Mar 2018 18:06:07 +0000
Subject: [PATCH 4.9 102/241] printk: Correctly handle preemption in console_unlock()
Message-Id: <20180319180755.427526044@linuxfoundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180319180751.172155436@linuxfoundation.org>
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Sasha Levin <alexander.levin@microsoft.com>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Mladek <pmladek@suse.com>


[ Upstream commit 257ab443118bffc7fdcef38f49cf59be68a3e362 ]

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
Link: http://lkml.kernel.org/r/1490372045-22288-1-git-send-email-pmladek@suse.com
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/printk/printk.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2342,7 +2342,7 @@ void console_unlock(void)
 	}
 
 	/*
-	 * Console drivers are called under logbuf_lock, so
+	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
 	 * end up dumping a lot of lines, for example, if called from
 	 * console registration path, and should invoke cond_resched()
@@ -2350,11 +2350,15 @@ void console_unlock(void)
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


