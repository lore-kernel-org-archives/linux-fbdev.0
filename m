From: Dave Airlie <airlied@gmail.com>
Subject: [PATCH] offb: add support for framebuffer
	handoff to offb.
Date: Tue, 27 Oct 2009 20:35:28 +1000
Message-ID: <1256639728-8118-1-git-send-email-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <airlied@gmail.com>) id 1N2jRA-000158-Mo
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Oct 2009 10:38:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N2jR4-0002Yf-5r for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Oct 2009 10:38:00 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sf.net
Cc: benh@kernel.crashing.org

From: Dave Airlie <airlied@redhat.com>

This allows offb to be used for initial framebuffer,
and a kms driver to take over later in the boot sequence.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/video/offb.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index 4d8c54c..b043ac8 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -282,8 +282,17 @@ static int offb_set_par(struct fb_info *info)
 	return 0;
 }
 
+static void offb_destroy(struct fb_info *info)
+{
+	if (info->screen_base)
+		iounmap(info->screen_base);
+	release_mem_region(info->aperture_base, info->aperture_size);
+	framebuffer_release(info);
+}
+
 static struct fb_ops offb_ops = {
 	.owner		= THIS_MODULE,
+	.fb_destroy	= offb_destroy,
 	.fb_setcolreg	= offb_setcolreg,
 	.fb_set_par	= offb_set_par,
 	.fb_blank	= offb_blank,
@@ -482,10 +491,14 @@ static void __init offb_init_fb(const char *name, const char *full_name,
 	var->sync = 0;
 	var->vmode = FB_VMODE_NONINTERLACED;
 
+	/* set offb aperture size for generic probing */
+	info->aperture_base = address;
+	info->aperture_size = fix->smem_len;
+
 	info->fbops = &offb_ops;
 	info->screen_base = ioremap(address, fix->smem_len);
 	info->pseudo_palette = (void *) (info + 1);
-	info->flags = FBINFO_DEFAULT | foreign_endian;
+	info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE | foreign_endian;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
-- 
1.6.5.rc2


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
