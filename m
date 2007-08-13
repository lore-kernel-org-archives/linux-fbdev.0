From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 22/22] uvesafb: try to set mode with
 default timings if setting it with our own timings failed
Date: Mon, 13 Aug 2007 20:44:17 +0800
Message-ID: <46C05221.40704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKe0Z-0000Sv-3f for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 10:47:15 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZLX-0005O6-GO
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:48:36 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:48:35 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Januszewski <spock@gentoo.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Michal Januszewski <spock@gentoo.org>

Sometimes the BIOS might not perform the mode switch correctly because of
the timings that we requested.  In case this happens, try to set the video
mode with the default timings instead.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/uvesafb.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 2e5f1b5..853323e 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -1218,6 +1218,7 @@ static int uvesafb_set_par(struct fb_inf
 	task = uvesafb_prep();
 	if (!task)
 		return -ENOMEM;
+setmode:
 	task->t.regs.eax = 0x4f02;
 	task->t.regs.ebx = mode->mode_id | 0x4000;	/* use LFB */
 
@@ -1260,10 +1261,25 @@ static int uvesafb_set_par(struct fb_inf
 
 	err = uvesafb_exec(task);
 	if (err || (task->t.regs.eax & 0xffff) != 0x004f) {
-		printk(KERN_ERR "uvesafb: mode switch failed (eax=0x%x, "
-				"err=%d)\n", task->t.regs.eax, err);
-		err = -EINVAL;
-		goto out;
+		/*
+		 * The mode switch might have failed because we tried to
+		 * use our own timings.  Try again with the default timings.
+		 */
+		if (crtc != NULL) {
+			printk(KERN_WARNING "uvesafb: mode switch failed "
+				"(eax=0x%x, err=%d). Trying again with "
+				"default timings.\n", task->t.regs.eax, err);
+			uvesafb_reset(task);
+			kfree(crtc);
+			crtc = NULL;
+			info->var.pixclock = 0;
+			goto setmode;
+		} else {
+			printk(KERN_ERR "uvesafb: mode switch failed (eax="
+				"0x%x, err=%d)\n", task->t.regs.eax, err);
+			err = -EINVAL;
+			goto out;
+		}
 	}
 	par->mode_idx = i;
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
