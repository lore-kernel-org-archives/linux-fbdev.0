From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 23/33] pm2fb: accelerated 24-bit fillrect
Date: Thu, 26 Jul 2007 20:28:37 +0800
Message-ID: <46A89375.5080205@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2vR-0001AP-Kt for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:58:41 -0700
Received: from nz-out-0506.google.com ([64.233.162.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2vQ-0008TI-Dw
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:58:41 -0700
Received: by nz-out-0506.google.com with SMTP id f1so1352216nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:58:40 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds accelerated fillrect for 24-bit depth.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 06ac564..90af047 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1077,7 +1077,13 @@ static void pm2fb_fillrect (struct fb_in
 		pm2_WR(par, PM2R_RENDER,
 				PM2F_RENDER_RECTANGLE | PM2F_RENDER_FASTFILL);
 	} else {
-		cfb_fillrect(info, region);
+		WAIT_FIFO(par, 4);
+		pm2_WR(par, PM2R_COLOR_DDA_MODE, 1);
+		pm2_WR(par, PM2R_CONSTANT_COLOR, color);
+		wmb();
+		pm2_WR(par, PM2R_RENDER,
+				PM2F_RENDER_RECTANGLE | PM2F_INCREASE_X | PM2F_INCREASE_Y );
+		pm2_WR(par, PM2R_COLOR_DDA_MODE, 0);
 	}
 }
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
