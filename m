From: Peter Jones <pjones@redhat.com>
Subject: [PATCH] Add fb_destroy() callback to free up
	reserved memory.
Date: Tue, 23 Jun 2009 14:29:06 -0400
Message-ID: <1245781746-15506-1-git-send-email-pjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pjones@redhat.com>) id 1MJAk3-0004Ub-Ba
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Jun 2009 18:29:14 +0000
Received: from mx2.redhat.com ([66.187.237.31])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJAk2-0006UC-FL for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Jun 2009 18:29:11 +0000
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
Cc: Peter Jones <pjones@redhat.com>, airlied@gmail.com

We reserve some memory in efifb_probe that needs to be freed when we
handoff to a KMS driver.  Also unmap the ioremap() done during
probe/setup.
---
 drivers/video/efifb.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index eb12182..41ba8cc 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -135,6 +135,14 @@ static int set_system(const struct dmi_system_id *id)
 	return 0;
 }
 
+static int efifb_destroy(struct fb_info *info)
+{
+	if (info->screen_base)
+		iounmap(info->screen_base);
+	release_mem_region(info->aperture_base, info->aperture_size);
+	framebuffer_release(info);
+}
+
 static int efifb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			   unsigned blue, unsigned transp,
 			   struct fb_info *info)
@@ -163,6 +171,7 @@ static int efifb_setcolreg(unsigned regno, unsigned red, unsigned green,
 
 static struct fb_ops efifb_ops = {
 	.owner		= THIS_MODULE,
+	.fb_destroy	= efifb_destroy,
 	.fb_setcolreg	= efifb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
-- 
1.6.2.2


------------------------------------------------------------------------------
