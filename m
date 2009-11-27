From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] davinci: fb: Add framebuffer blank operation
Date: Fri, 27 Nov 2009 12:13:47 +0530
Message-ID: <1259304227-19412-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org

Implement frame buffer blank operation feature for DA8xx/OMAP-L1xx
driver.

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
---
 drivers/video/da8xx-fb.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index fcaa344..a2fcd92 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -702,6 +702,35 @@ static int fb_ioctl(struct fb_info *info, unsigned int cmd,
 	return 0;
 }
 
+static int cfb_blank(int blank, struct fb_info *info)
+{
+	struct da8xx_fb_par *par = info->par;
+	int ret = 0;
+
+	if (par->blank == blank)
+		return 0;
+
+	par->blank = blank;
+	switch (blank) {
+	case FB_BLANK_UNBLANK:
+		if (par->panel_power_ctrl)
+			par->panel_power_ctrl(1);
+
+		lcd_enable_raster();
+		break;
+	case FB_BLANK_POWERDOWN:
+		if (par->panel_power_ctrl)
+			par->panel_power_ctrl(0);
+
+		lcd_disable_raster();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static struct fb_ops da8xx_fb_ops = {
 	.owner = THIS_MODULE,
 	.fb_check_var = fb_check_var,
@@ -710,6 +739,7 @@ static struct fb_ops da8xx_fb_ops = {
 	.fb_fillrect = cfb_fillrect,
 	.fb_copyarea = cfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
+	.fb_blank = cfb_blank,
 };
 
 static int __init fb_probe(struct platform_device *device)
-- 
1.5.6
