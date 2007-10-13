From: Antonino Daplas <adaplas@gmail.com>
Subject: [PATCH 04/15] ps3fb: Make
 ps3fb_wait_for_vsync() and ps3fb_flip_ctl() static
Date: Sat, 13 Oct 2007 08:24:33 +0800
Message-ID: <47101041.1050808@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgUxw-0005IM-0u for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:34:52 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgUxv-0002xt-Q7
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:34:52 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3588679rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 12 Oct 2007 17:34:51 -0700 (PDT)
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Make ps3fb_wait_for_vsync() and ps3fb_flip_ctl() static, as they're no
(longer) used outside ps3fb.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/ps3fb.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 74de53a..c9656a5 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -652,7 +652,7 @@ static int ps3fb_get_vblank(struct fb_vb
 	return 0;
 }
 
-int ps3fb_wait_for_vsync(u32 crtc)
+static int ps3fb_wait_for_vsync(u32 crtc)
 {
 	int ret;
 	u64 count;
@@ -667,9 +667,7 @@ int ps3fb_wait_for_vsync(u32 crtc)
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ps3fb_wait_for_vsync);
-
-void ps3fb_flip_ctl(int on, void *data)
+static void ps3fb_flip_ctl(int on, void *data)
 {
 	struct ps3fb_priv *priv = data;
 	if (on)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
