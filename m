From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/9] fbdev: Add 1366x768 (WXGA) mode to mode database
Date: Thu, 04 May 2006 20:28:36 +0800
Message-ID: <4459F374.3020708@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fbd5S-0007lr-5C
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:37:42 -0700
Received: from wx-out-0102.google.com ([66.249.82.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fbd5S-0002Pa-0J
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:37:42 -0700
Received: by wx-out-0102.google.com with SMTP id h26so310349wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 May 2006 05:37:41 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Dennis Munsie <dmunsie@cecropia.com>

From: Dennis Munsie <dmunsie@cecropia.com>

Adds 1366x768 @ 60Hz to drivers/video/modedb.c.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/modedb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 26a1c61..1aa36d3 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -259,6 +259,10 @@ static const struct fb_videomode modedb[
 	/* 1152x768, 60 Hz, PowerBook G4 Titanium I and II */
 	NULL, 60, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
 	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    }, {
+	/* 1366x768, 60 Hz, 47.403 kHz hsync, WXGA 16:9 aspect ratio */
+	NULL, 60, 1366, 768, 13806, 120, 10, 14, 3, 32, 5,
+	0, FB_VMODE_NONINTERLACED
     },
 };
 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
