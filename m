From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] nvidiafb: Fix absence of cursor in nvidiafb
Date: Wed, 21 Sep 2005 07:30:21 +0800
Message-ID: <43309B8D.7060502@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHrkq-0003Ac-Nx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Sep 2005 16:42:28 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EHrko-0004Ta-E6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Sep 2005 16:42:28 -0700
Received: by zproxy.gmail.com with SMTP id 14so57967nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Sep 2005 16:42:20 -0700 (PDT)
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
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

A recent change in nvidiafb caused nvidiafb_cursor to always return -ENXIO
instead of using the soft_cursor.  This will happen if the parameter "hwcur"
is not set, which happens to be the default.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 Kconfig         |    1 +
 nvidia/nvidia.c |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)


diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -650,6 +650,7 @@ config FB_NVIDIA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the nVidia chips, TNT
 	  and newer. For very old chipsets, such as the RIVA128, then use
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -893,7 +893,7 @@ static int nvidiafb_cursor(struct fb_inf
 	int i, set = cursor->set;
 	u16 fg, bg;
 
-	if (!hwcur || cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
+	if (cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
 		return -ENXIO;
 
 	NVShowHideCursor(par, 0);
@@ -1356,6 +1356,9 @@ static int __devinit nvidia_set_fbinfo(s
 	info->pixmap.size = 8 * 1024;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
+	if (!hwcur)
+	    info->fbops->fb_cursor = soft_cursor;
+
 	info->var.accel_flags = (!noaccel);
 
 	switch (par->Architecture) {




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
