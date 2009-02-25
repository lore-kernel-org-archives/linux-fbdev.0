From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] viafb: returns 0 two too early.
Date: Wed, 25 Feb 2009 14:21:07 +0100
Message-ID: <49A545C3.5060801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LcJhN-0002pP-Kf
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Feb 2009 13:21:17 +0000
Received: from yw-out-1718.google.com ([74.125.46.156])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LcJhE-0003tx-Qd for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Feb 2009 13:21:17 +0000
Received: by yw-out-1718.google.com with SMTP id 6so9616ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Feb 2009 05:21:07 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: josephchan@via.com.tw
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

Otherwise this will already return 0 if iteration MAXLOOP-2 occurs in the first
loop.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
index 632523f..45c54bf 100644
--- a/drivers/video/via/accel.c
+++ b/drivers/video/via/accel.c
@@ -267,13 +267,17 @@ int viafb_wait_engine_idle(void)
 	int loop = 0;
 
 	while (!(readl(viaparinfo->io_virt + VIA_REG_STATUS) &
-			VIA_VR_QUEUE_BUSY) && (loop++ < MAXLOOP))
+			VIA_VR_QUEUE_BUSY) && (loop < MAXLOOP)) {
+		loop++;
 		cpu_relax();
+	}
 
 	while ((readl(viaparinfo->io_virt + VIA_REG_STATUS) &
 		    (VIA_CMD_RGTR_BUSY | VIA_2D_ENG_BUSY | VIA_3D_ENG_BUSY)) &&
-		    (loop++ < MAXLOOP))
+		    (loop < MAXLOOP)) {
+		loop++;
 		cpu_relax();
+	}
 
 	return loop >= MAXLOOP;
 }

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
