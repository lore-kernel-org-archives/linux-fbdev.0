From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] nvidiafb: i2c bus name beautification
Date: Sat, 19 Nov 2005 10:06:01 +0800
Message-ID: <437E8889.5050202@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdI7h-0007Tx-Mc
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 18:06:37 -0800
Received: from zproxy.gmail.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdI7h-00040l-FW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 18:06:37 -0800
Received: by zproxy.gmail.com with SMTP id z3so306425nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Nov 2005 18:06:20 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Alessandro Zummo <a.zummo@towertech.it>

From: Alessandro Zummo <a.zummo@towertech.it>

A small patch to assign nvidiafb's i2c busses a better name.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nv_i2c.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index 12f2884..fa72472 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -136,13 +136,13 @@ void nvidia_create_i2c_busses(struct nvi
 	par->chan[2].par = par;
 
 	par->chan[0].ddc_base = 0x3e;
-	nvidia_setup_i2c_bus(&par->chan[0], "BUS1");
+	nvidia_setup_i2c_bus(&par->chan[0], "nvidia #0");
 
 	par->chan[1].ddc_base = 0x36;
-	nvidia_setup_i2c_bus(&par->chan[1], "BUS2");
+	nvidia_setup_i2c_bus(&par->chan[1], "nvidia #1");
 
 	par->chan[2].ddc_base = 0x50;
-	nvidia_setup_i2c_bus(&par->chan[2], "BUS3");
+	nvidia_setup_i2c_bus(&par->chan[2], "nvidia #2");
 }
 
 void nvidia_delete_i2c_busses(struct nvidia_par *par)


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
