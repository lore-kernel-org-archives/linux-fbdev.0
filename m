From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] s3c-fb: fix resource releasing on error
	during probing
Date: Wed, 20 May 2009 14:14:31 +0200
Message-ID: <20090520141431.d9b22439.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M6kav-0002HQ-JZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 12:08:25 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M6kar-0006qE-3B for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 12:08:25 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Ben Dooks <ben-linux-arm@fluff.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

All resources are released in s3c_fb_win_release
so remove other places of resources releasing.
Add releasing of an allocated fb_info structure
as well.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/s3c-fb.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 5e9c630..195cc27 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -700,9 +700,12 @@ static void s3c_fb_free_memory(struct s3c_fb *sfb, struct s3c_fb_win *win)
  */
 static void s3c_fb_release_win(struct s3c_fb *sfb, struct s3c_fb_win *win)
 {
-	fb_dealloc_cmap(&win->fbinfo->cmap);
-	unregister_framebuffer(win->fbinfo);
-	s3c_fb_free_memory(sfb, win);
+	if (win->fbinfo) {
+		unregister_framebuffer(win->fbinfo);
+		fb_dealloc_cmap(&win->fbinfo->cmap);
+		s3c_fb_free_memory(sfb, win);
+		framebuffer_release(win->fbinfo);
+	}
 }
 
 /**
@@ -753,7 +756,7 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	ret = s3c_fb_alloc_memory(sfb, win);
 	if (ret) {
 		dev_err(sfb->dev, "failed to allocate display memory\n");
-		goto err_framebuffer;
+		return ret;
 	}
 
 	/* setup the r/b/g positions for the window's palette */
@@ -776,7 +779,7 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	ret = s3c_fb_check_var(&fbinfo->var, fbinfo);
 	if (ret < 0) {
 		dev_err(sfb->dev, "check_var failed on initial video params\n");
-		goto err_alloc_mem;
+		return ret;
 	}
 
 	/* create initial colour map */
@@ -796,20 +799,13 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	ret = register_framebuffer(fbinfo);
 	if (ret < 0) {
 		dev_err(sfb->dev, "failed to register framebuffer\n");
-		goto err_alloc_mem;
+		return ret;
 	}
 
 	*res = win;
 	dev_info(sfb->dev, "window %d: fb %s\n", win_no, fbinfo->fix.id);
 
 	return 0;
-
-err_alloc_mem:
-	s3c_fb_free_memory(sfb, win);
-
-err_framebuffer:
-	unregister_framebuffer(fbinfo);
-	return ret;
 }
 
 /**
-- 
1.6.0.3


----------------------------------------------------------------------
Zrob sobie prezent. Wygraj nagrode!
Sprawdz >>  http://link.interia.pl/f2176 



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
