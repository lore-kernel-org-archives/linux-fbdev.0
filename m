From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] fix controlfb and platinumfb drivers
Date: Sat, 24 May 2003 21:40:05 +1000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <16079.23061.979768.135318@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

James,

This patch fixes the controlfb and platinumfb drivers so that the
arguments to fb_set_var are in the correct order.  Please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/video/controlfb.c pmac-2.5/drivers/video/controlfb.c
--- linux-2.5/drivers/video/controlfb.c	2003-04-25 22:19:46.000000000 +1000
+++ pmac-2.5/drivers/video/controlfb.c	2003-05-21 13:32:42.000000000 +1000
@@ -475,7 +475,7 @@
 
 	/* Apply default var */
 	var.activate = FB_ACTIVATE_NOW;
-	rc = fb_set_var(&var, &p->info);
+	rc = fb_set_var(&p->info, &var);
 	if (rc && (vmode != VMODE_640_480_60 || cmode != CMODE_8))
 		goto try_again;
 
diff -urN linux-2.5/drivers/video/platinumfb.c pmac-2.5/drivers/video/platinumfb.c
--- linux-2.5/drivers/video/platinumfb.c	2003-04-25 22:19:46.000000000 +1000
+++ pmac-2.5/drivers/video/platinumfb.c	2003-05-21 13:33:01.000000000 +1000
@@ -399,7 +399,7 @@
 	/* Apply default var */
 	p->info.var = var;
 	var.activate = FB_ACTIVATE_NOW;
-	rc = fb_set_var(&var, &p->info);
+	rc = fb_set_var(&p->info, &var);
 	if (rc && (default_vmode != VMODE_640_480_60 || default_cmode != CMODE_8))
 		goto try_again;
 
