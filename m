From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 10/12] fbdev: Static pseudocolor with depth less than 4 does
 exist
Date: Sat, 29 Apr 2006 08:41:12 +0800
Message-ID: <4452B628.1020001@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZdit-0003qB-QH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:54:11 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZdiZ-00017e-Ai
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:51 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZdiZ-0006gw-26
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:51 -0700
Received: by xproxy.gmail.com with SMTP id t4so1463996wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 17:53:50 -0700 (PDT)
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

A static pseudocolor visual with depth less than 4 does exist, so let's
not accidentally upscale the depth with this configuration

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 1cb9acf..19cb4c5 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -432,7 +432,7 @@ int fb_prepare_logo(struct fb_info *info
 			depth = info->var.green.length;
 	}
 
-	if (info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR) {
+	if (info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR && depth > 4) {
 		/* assume console colormap */
 		depth = 4;
 	}



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
