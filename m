From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/4] fbdev: Remove remaining references to soft_cursor from
 drivers
Date: Wed, 26 Oct 2005 19:51:31 +0800
Message-ID: <435F6DC3.6000802@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUk2O-0001qc-L0
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 05:05:48 -0700
Received: from zproxy.gmail.com ([64.233.162.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EUk2N-00084U-Cz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 05:05:48 -0700
Received: by zproxy.gmail.com with SMTP id 14so104212nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Oct 2005 05:05:45 -0700 (PDT)
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

au1100fb and au1200fb still refers to soft_cursor. Remove.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
> drivers/video/Kconfig:1249:warning: 'select' used by config symbol 'FB_AU1200' refer to undefined symbol 'FB_SOFT_CURSOR'
> 
> This might be due to a clash-of-intent between some of Tony's stuff and the
> MIPS tree.   A fix against next -mm would suit, thanks.
> 
> 

Here's the fix
 
 Kconfig    |    1 -
 au1100fb.c |    1 -
 au1200fb.c |    1 -
 3 files changed, 3 deletions(-)


diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index fcb559b..55ae403 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1246,7 +1246,6 @@ config FB_AU1200
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the framebuffer driver for the AMD Au1200 SOC.  It can drive
 	  various panels and CRTs by passing in kernel cmd line option
diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index bf3ac99..a512980 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -424,7 +424,6 @@ static struct fb_ops au1100fb_ops =
 	.fb_fillrect		= cfb_fillrect,
 	.fb_copyarea		= cfb_copyarea,
 	.fb_imageblit		= cfb_imageblit,
-	.fb_cursor		= soft_cursor,
 	.fb_rotate		= au1100fb_fb_rotate,
 	.fb_mmap		= au1100fb_fb_mmap,
 };
diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index adde4f6..f7243b1 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -1555,7 +1555,6 @@ static struct fb_ops au1200fb_fb_ops =
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor		= soft_cursor,
 	.fb_sync		= NULL,
 	.fb_ioctl		= au1200fb_ioctl,
 	.fb_mmap		= au1200fb_fb_mmap,



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
