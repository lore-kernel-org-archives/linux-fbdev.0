From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/console/fbcon.c: fix a check after use
Date: Wed, 13 Apr 2005 04:17:32 +0200
Message-ID: <20050413021732.GP3631@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262647AbVDMCY6@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

---

This patch was already sent on:
- 27 Mar 2005

--- linux-2.6.12-rc1-mm1-full/drivers/video/console/fbcon.c.old	2005-03-23 04:53:20.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/video/console/fbcon.c	2005-03-23 04:53:44.000000000 +0100
@@ -906,10 +906,13 @@ static void fbcon_init(struct vc_data *v
 	struct vc_data *svc = *default_mode;
 	struct display *t, *p = &fb_display[vc->vc_num];
 	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
-	int cap = info->flags;
+	int cap;
 
 	if (info_idx == -1 || info == NULL)
 	    return;
+
+	cap = info->flags;
+
 	if (vc != svc || logo_shown == FBCON_LOGO_DONTSHOW ||
 	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;
