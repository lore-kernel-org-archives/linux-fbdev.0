From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/13] vt: printk: Fix framebuffer
 console triggering might_sleep assertion
Date: Tue, 01 Aug 2006 07:23:52 +0800
Message-ID: <44CE9108.1030606@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7hNd-000339-UR for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:02 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hNc-0004Mn-4z
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:01 -0700
Received: by py-out-1112.google.com with SMTP id d42so802545pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:40:56 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Reported by: Dave Jones

Whilst printk'ing to both console and serial console, I got this...
(2.6.18rc1)

BUG: sleeping function called from invalid context at kernel/sched.c:4438
in_atomic():0, irqs_disabled():1

Call Trace:
 [<ffffffff80271db8>] show_trace+0xaa/0x23d
 [<ffffffff80271f60>] dump_stack+0x15/0x17
 [<ffffffff8020b9f8>] __might_sleep+0xb2/0xb4
 [<ffffffff8029232e>] __cond_resched+0x15/0x55
 [<ffffffff80267eb8>] cond_resched+0x3b/0x42
 [<ffffffff80268c64>] console_conditional_schedule+0x12/0x14
 [<ffffffff80368159>] fbcon_redraw+0xf6/0x160
 [<ffffffff80369c58>] fbcon_scroll+0x5d9/0xb52
 [<ffffffff803a43c4>] scrup+0x6b/0xd6
 [<ffffffff803a4453>] lf+0x24/0x44
 [<ffffffff803a7ff8>] vt_console_print+0x166/0x23d
 [<ffffffff80295528>] __call_console_drivers+0x65/0x76
 [<ffffffff80295597>] _call_console_drivers+0x5e/0x62
 [<ffffffff80217e3f>] release_console_sem+0x14b/0x232
 [<ffffffff8036acd6>] fb_flashcursor+0x279/0x2a6
 [<ffffffff80251e3f>] run_workqueue+0xa8/0xfb
 [<ffffffff8024e5e0>] worker_thread+0xef/0x122
 [<ffffffff8023660f>] kthread+0x100/0x136
 [<ffffffff8026419e>] child_rip+0x8/0x12

This can occur when release_console_sem() is called but the log
buffer still has contents that need to be flushed. The console drivers
are called while the console_may_schedule flag is still true. The
might_sleep() is triggered when fbcon calls console_conditional_schedule().

Fix by setting console_may_schedule to zero earlier, before the call to the
console drivers.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 kernel/printk.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index b355a8e..35c4fae 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -780,6 +780,9 @@ void release_console_sem(void)
 		up(&secondary_console_sem);
 		return;
 	}
+
+	console_may_schedule = 0;
+
 	for ( ; ; ) {
 		spin_lock_irqsave(&logbuf_lock, flags);
 		wake_klogd |= log_start - log_end;
@@ -793,7 +796,6 @@ void release_console_sem(void)
 		local_irq_restore(flags);
 	}
 	console_locked = 0;
-	console_may_schedule = 0;
 	up(&console_sem);
 	spin_unlock_irqrestore(&logbuf_lock, flags);
 	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait)) {


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
