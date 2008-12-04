From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch] fbcon: Fix workqueue shutdown
Date: Wed, 3 Dec 2008 16:23:12 -0800
Message-ID: <493722F0.5070707@am.sony.com>
References: <4909EB41.40100@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geoffrey.Levand@am.sony.com>) id 1L820O-00056V-CX
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 00:23:44 +0000
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]
	helo=WA4EHSOBE006.bigfish.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.69) id 1L820K-0005Nu-EF
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 00:23:44 +0000
In-Reply-To: <4909EB41.40100@am.sony.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

Add a call to cancel_work_sync() in fbcon_exit() to cancel
any pending work in the fbcon workqueue.  Also, change the
assignment of the workqueue function info->queue.func from
NULL to fb_flashcursor(), and add a corresponding check in
fb_flashcursor() to exit immediately if the variable
fbcon_has_exited is set.

The current implementation of fbcon_exit() sets the fbcon
workqueue function info->queue.func to NULL, but does not
assure that there is no work pending when it does so.  On
occasion, depending on system timing, there will still be
pending work in the queue when fbcon_exit() is called.
This results in a null pointer deference when
run_workqueue() tries to call the queue's work function.

Fixes errors on shutdown similar to these:

  Console: switching to colour dummy device 80x25
  Unable to handle kernel paging request for data at address 0x00000000

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
Hi,

This is a resend of my 10/30/2008 patch.  I didn't
get any feed back.

I was hoping to get this bug fixed for 2.6.29.

-Geoff
 
 drivers/video/console/fbcon.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -394,13 +394,19 @@ static void fbcon_update_softback(struct
 
 static void fb_flashcursor(struct work_struct *work)
 {
-	struct fb_info *info = container_of(work, struct fb_info, queue);
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fb_info *info;
+	struct fbcon_ops *ops;
 	struct display *p;
 	struct vc_data *vc = NULL;
 	int c;
 	int mode;
 
+	if (fbcon_has_exited)
+		return;
+
+	info = container_of(work, struct fb_info, queue);
+	ops = info->fbcon_par;
+
 	acquire_console_sem();
 	if (ops && ops->currcon != -1)
 		vc = vc_cons[ops->currcon].d;
@@ -3534,12 +3540,18 @@ static void fbcon_exit(void)
 	softback_buf = 0UL;
 
 	for (i = 0; i < FB_MAX; i++) {
+		int pending;
+
 		mapped = 0;
 		info = registered_fb[i];
 
 		if (info == NULL)
 			continue;
 
+		pending = cancel_work_sync(&info->queue);
+		DPRINTK("fbcon: %s pending work\n", (pending ? "canceled" :
+			"no"));
+
 		for (j = first_fb_vc; j <= last_fb_vc; j++) {
 			if (con2fb_map[j] == i)
 				mapped = 1;
@@ -3558,9 +3570,6 @@ static void fbcon_exit(void)
 				kfree(info->fbcon_par);
 				info->fbcon_par = NULL;
 			}
-
-			if (info->queue.func == fb_flashcursor)
-				info->queue.func = NULL;
 		}
 	}
 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
