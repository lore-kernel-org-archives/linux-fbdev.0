From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] sisfb: Read buffer overflow
Date: Thu, 23 Jul 2009 19:50:24 +0200
Message-ID: <4A68A2E0.203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1MU2Om-0006n9-Sw
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Jul 2009 17:48:08 +0000
Received: from mail-ew0-f208.google.com ([209.85.219.208])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MU2Og-0000hd-Bg for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Jul 2009 17:48:08 +0000
Received: by ewy4 with SMTP id 4so1076175ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 23 Jul 2009 10:48:00 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: thomas@winischhofer.net, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

If called with mode_idx = 1, rate = 68, a read occurs from
sisfb_vrate[-1].refresh.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
This presumes the conditional should be reversed, correct?

diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 636a785..35531d7 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -698,8 +698,8 @@ sisfb_search_refresh_rate(struct sis_video_info *ivideo, unsigned int rate, int
 						rate, sisfb_vrate[i].refresh);
 					ivideo->rate_idx = sisfb_vrate[i].idx;
 					ivideo->refresh_rate = sisfb_vrate[i].refresh;
-				} else if(((rate - sisfb_vrate[i-1].refresh) <= 2)
-						&& (sisfb_vrate[i].idx != 1)) {
+				} else if((sisfb_vrate[i].idx != 1) &&
+						((rate - sisfb_vrate[i-1].refresh) <= 2)) {
 					DPRINTK("sisfb: Adjusting rate from %d down to %d\n",
 						rate, sisfb_vrate[i-1].refresh);
 					ivideo->rate_idx = sisfb_vrate[i-1].idx;

------------------------------------------------------------------------------
