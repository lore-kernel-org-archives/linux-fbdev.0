From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:01:01 +0000
Subject: [PATCH 06/19] video: pxafb: use dev_get_platdata()
Message-Id: <000b01ceb362$e78c46a0$b6a4d3e0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/pxafb.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index eca2de4..1ecd9ce 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -457,7 +457,7 @@ static int pxafb_adjust_timing(struct pxafb_info *fbi,
 static int pxafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct pxafb_info *fbi = (struct pxafb_info *)info;
-	struct pxafb_mach_info *inf = fbi->dev->platform_data;
+	struct pxafb_mach_info *inf = dev_get_platdata(fbi->dev);
 	int err;
 
 	if (inf->fixed_modes) {
@@ -1230,7 +1230,7 @@ static unsigned int __smart_timing(unsigned time_ns, unsigned long lcd_clk)
 static void setup_smart_timing(struct pxafb_info *fbi,
 				struct fb_var_screeninfo *var)
 {
-	struct pxafb_mach_info *inf = fbi->dev->platform_data;
+	struct pxafb_mach_info *inf = dev_get_platdata(fbi->dev);
 	struct pxafb_mode_info *mode = &inf->modes[0];
 	unsigned long lclk = clk_get_rate(fbi->clk);
 	unsigned t1, t2, t3, t4;
@@ -1258,14 +1258,14 @@ static void setup_smart_timing(struct pxafb_info *fbi,
 static int pxafb_smart_thread(void *arg)
 {
 	struct pxafb_info *fbi = arg;
-	struct pxafb_mach_info *inf = fbi->dev->platform_data;
+	struct pxafb_mach_info *inf = dev_get_platdata(fbi->dev);
 
 	if (!inf->smart_update) {
 		pr_err("%s: not properly initialized, thread terminated\n",
 				__func__);
 		return -EINVAL;
 	}
-	inf = fbi->dev->platform_data;
+	inf = dev_get_platdata(fbi->dev);
 
 	pr_debug("%s(): task starting\n", __func__);
 
@@ -1793,7 +1793,7 @@ static struct pxafb_info *pxafb_init_fbinfo(struct device *dev)
 {
 	struct pxafb_info *fbi;
 	void *addr;
-	struct pxafb_mach_info *inf = dev->platform_data;
+	struct pxafb_mach_info *inf = dev_get_platdata(dev);
 
 	/* Alloc the pxafb_info and pseudo_palette in one step */
 	fbi = kmalloc(sizeof(struct pxafb_info) + sizeof(u32) * 16, GFP_KERNEL);
@@ -1855,7 +1855,7 @@ static struct pxafb_info *pxafb_init_fbinfo(struct device *dev)
 #ifdef CONFIG_FB_PXA_PARAMETERS
 static int parse_opt_mode(struct device *dev, const char *this_opt)
 {
-	struct pxafb_mach_info *inf = dev->platform_data;
+	struct pxafb_mach_info *inf = dev_get_platdata(dev);
 
 	const char *name = this_opt+5;
 	unsigned int namelen = strlen(name);
@@ -1914,7 +1914,7 @@ done:
 
 static int parse_opt(struct device *dev, char *this_opt)
 {
-	struct pxafb_mach_info *inf = dev->platform_data;
+	struct pxafb_mach_info *inf = dev_get_platdata(dev);
 	struct pxafb_mode_info *mode = &inf->modes[0];
 	char s[64];
 
@@ -2102,7 +2102,7 @@ static int pxafb_probe(struct platform_device *dev)
 
 	dev_dbg(&dev->dev, "pxafb_probe\n");
 
-	inf = dev->dev.platform_data;
+	inf = dev_get_platdata(&dev->dev);
 	ret = -ENOMEM;
 	fbi = NULL;
 	if (!inf)
-- 
1.7.10.4


