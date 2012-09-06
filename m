From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Sep 2012 07:23:11 +0000
Subject: [PATCH] video: bf*: Add missing spinlock init
Message-Id: <20120906092311.22961acd@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

It doesn't seem these spinlocks were properly initialized.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
I can't even build-test this.

 drivers/video/bf54x-lq043fb.c    |    1 +
 drivers/video/bfin-lq035q1-fb.c  |    1 +
 drivers/video/bfin-t350mcqb-fb.c |    1 +
 3 files changed, 3 insertions(+)

--- linux-3.6-rc4.orig/drivers/video/bf54x-lq043fb.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.6-rc4/drivers/video/bf54x-lq043fb.c	2012-09-06 08:49:37.812899185 +0200
@@ -525,6 +525,7 @@ static int __devinit bfin_bf54x_probe(st
 	info = fbinfo->par;
 	info->fb = fbinfo;
 	info->dev = &pdev->dev;
+	spin_lock_init(&info->lock);
 
 	platform_set_drvdata(pdev, fbinfo);
 
--- linux-3.6-rc4.orig/drivers/video/bfin-lq035q1-fb.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.6-rc4/drivers/video/bfin-lq035q1-fb.c	2012-09-06 08:48:50.618858480 +0200
@@ -577,6 +577,7 @@ static int __devinit bfin_lq035q1_probe(
 	info = fbinfo->par;
 	info->fb = fbinfo;
 	info->dev = &pdev->dev;
+	spin_lock_init(&info->lock);
 
 	info->disp_info = pdev->dev.platform_data;
 
--- linux-3.6-rc4.orig/drivers/video/bfin-t350mcqb-fb.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.6-rc4/drivers/video/bfin-t350mcqb-fb.c	2012-09-06 08:48:12.310825601 +0200
@@ -447,6 +447,7 @@ static int __devinit bfin_t350mcqb_probe
 	info = fbinfo->par;
 	info->fb = fbinfo;
 	info->dev = &pdev->dev;
+	spin_lock_init(&info->lock);
 
 	platform_set_drvdata(pdev, fbinfo);
 


-- 
Jean Delvare
