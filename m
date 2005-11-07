From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/7] fbdev: Framebuffer mode required for PowerBook Titanium
Date: Mon, 07 Nov 2005 19:23:47 +0800
Message-ID: <436F3943.2090809@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5k8-00062s-R6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 04:04:56 -0800
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZ5Bz-0006Hq-Rs
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:29:40 -0800
Received: by xproxy.gmail.com with SMTP id i28so364656wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 03:29:39 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Michael Hanselmann <linux-kernel@hansmi.ch>

This patch adds the framebuffer mode required for an Apple PowerBook G4
Titanium.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 modedb.c |    4 ++++
 1 files changed, 4 insertions(+)


diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 1789a52..1da2f84 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -251,6 +251,10 @@ static const struct fb_videomode modedb[
 	NULL, 60, 1920, 1200, 5177, 128, 336, 1, 38, 208, 3,
 	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	FB_VMODE_NONINTERLACED
+    }, {
+	/* 1152x768, 60 Hz, PowerBook G4 Titanium I and II */
+	NULL, 60, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
     },
 };
 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
