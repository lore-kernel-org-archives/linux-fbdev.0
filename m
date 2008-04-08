From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 2/4] pxafb: use completion for LCD
	disable wait code
Date: Tue, 8 Apr 2008 12:04:24 +0800
Message-ID: <f17812d70804072104k69711417h641ff73ed4e77009@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jj54N-00046H-KT for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 21:04:27 -0700
Received: from wr-out-0506.google.com ([64.233.184.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jj54M-0003Q4-6u
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 21:04:27 -0700
Received: by wr-out-0506.google.com with SMTP id c48so1436785wra.1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 07 Apr 2008 21:04:25 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-arm-kernel email list <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Mack <daniel@caiaq.de>

From 7fc5217e6d466262e8b59c07cc7bbea2e82a09e8 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Thu, 27 Mar 2008 09:37:07 +0800
Subject: [PATCH] pxafb: use completion for LCD disable wait code

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/video/pxafb.c |   12 ++++--------
 drivers/video/pxafb.h |    2 ++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 27d9fed..fb24ca3 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -39,6 +39,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/completion.h>

 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -801,11 +802,6 @@ static void pxafb_disable_controller(struct
pxafb_info *fbi)
 {
 	uint32_t lccr0;

-	DECLARE_WAITQUEUE(wait, current);
-
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	add_wait_queue(&fbi->ctrlr_wait, &wait);
-
 	/* Clear LCD Status Register */
 	lcd_writel(fbi, LCSR, 0xffffffff);

@@ -813,8 +809,7 @@ static void pxafb_disable_controller(struct pxafb_info *fbi)
 	lcd_writel(fbi, LCCR0, lccr0);
 	lcd_writel(fbi, LCCR0, lccr0 | LCCR0_DIS);

-	schedule_timeout(200 * HZ / 1000);
-	remove_wait_queue(&fbi->ctrlr_wait, &wait);
+	wait_for_completion_timeout(&fbi->disable_done, 200 * HZ / 1000);

 	/* disable LCD controller clock */
 	clk_disable(fbi->clk);
@@ -831,7 +826,7 @@ static irqreturn_t pxafb_handle_irq(int irq, void *dev_id)
 	if (lcsr & LCSR_LDD) {
 		lccr0 = lcd_readl(fbi, LCCR0);
 		lcd_writel(fbi, LCCR0, lccr0 | LCCR0_LDM);
-		wake_up(&fbi->ctrlr_wait);
+		complete(&fbi->disable_done);
 	}

 	lcd_writel(fbi, LCSR, lcsr);
@@ -1181,6 +1176,7 @@ static struct pxafb_info * __init
pxafb_init_fbinfo(struct device *dev)
 	init_waitqueue_head(&fbi->ctrlr_wait);
 	INIT_WORK(&fbi->task, pxafb_task);
 	init_MUTEX(&fbi->ctrlr_sem);
+	init_completion(&fbi->disable_done);

 	return fbi;
 }
diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
index b777641..f47f139 100644
--- a/drivers/video/pxafb.h
+++ b/drivers/video/pxafb.h
@@ -114,6 +114,8 @@ struct pxafb_info {
 	wait_queue_head_t	ctrlr_wait;
 	struct work_struct	task;

+	struct completion	disable_done;
+
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 	struct notifier_block	freq_policy;
-- 
1.5.4.3



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
