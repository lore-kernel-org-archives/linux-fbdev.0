From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 02 Oct 2013 11:55:11 +0000
Subject: [PATCH 2/2] hyperv-fb: add blanking support
Message-Id: <1380714911-6254-2-git-send-email-kraxel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380714911-6254-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1380714911-6254-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Gerd Hoffmann <kraxel@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:Hyper-V CORE AND..." <devel@linuxdriverproject.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/video/hyperv_fb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/hyperv_fb.c b/drivers/video/hyperv_fb.c
index 8d456dc..130708f 100644
--- a/drivers/video/hyperv_fb.c
+++ b/drivers/video/hyperv_fb.c
@@ -575,6 +575,10 @@ static int hvfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	return 0;
 }
 
+static int hvfb_blank(int blank, struct fb_info *info)
+{
+	return 1;	/* get fb_blank to set the colormap to all black */
+}
 
 static struct fb_ops hvfb_ops = {
 	.owner = THIS_MODULE,
@@ -584,6 +588,7 @@ static struct fb_ops hvfb_ops = {
 	.fb_fillrect = cfb_fillrect,
 	.fb_copyarea = cfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
+	.fb_blank = hvfb_blank,
 };
 
 
-- 
1.8.3.1

