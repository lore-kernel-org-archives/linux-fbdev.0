From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] mx3fb: Fix display brightness
	initialization
Date: Mon,  9 Nov 2009 12:10:07 +0100
Message-ID: <1257765007-32040-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <agust@denx.de>) id 1N7S8c-0000vW-Qe
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Nov 2009 11:10:22 +0000
Received: from mail-out.m-online.net ([212.18.0.10])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N7S8U-0007eG-GW for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Nov 2009 11:10:22 +0000
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id AA9691C00049
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  9 Nov 2009 12:10:07 +0100 (CET)
Received: from localhost (p57931F06.dip.t-dialin.net [87.147.31.6])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTP id 49B5890258
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  9 Nov 2009 12:10:07 +0100 (CET)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

__blank() uses mx3fb->backlight_level to set the
display brightness. __blank() is also called from
init_fb_chan() before mx3fb->backlight_level was
initialized. This causes setting the display brightness
to zero at probe time.

This patch moves the initialization of mx3fb->backlight_level
before init_fb_chan() call.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/mx3fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 054ef29..86312dd 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -1486,12 +1486,12 @@ static int mx3fb_probe(struct platform_device *pdev)
 		goto ersdc0;
 	}
 
+	mx3fb->backlight_level = 255;
+
 	ret = init_fb_chan(mx3fb, to_idmac_chan(chan));
 	if (ret < 0)
 		goto eisdc0;
 
-	mx3fb->backlight_level = 255;
-
 	return 0;
 
 eisdc0:
-- 
1.5.6.3


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
