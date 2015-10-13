From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 13 Oct 2015 19:34:28 +0000
Subject: [PATCH v2 1/2] video: fbdev: pxafb: loosen the platform data bond
Message-Id: <1444764869-24893-1-git-send-email-robert.jarzmik@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Philipp Zabel <philipp.zabel@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>

In order to prepare the transition to a mixed platform data and
device-tree initialization, remove all the platform data references all
over the driver.

Copy the platform data into the internal structure of the pxafb, and
only use this afterward.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/video/fbdev/pxafb.c | 54 ++++++++++++++++++++++++++++-----------------
 drivers/video/fbdev/pxafb.h |  2 ++
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 94813af97f09..ed4b1a5dc306 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -457,7 +457,7 @@ static int pxafb_adjust_timing(struct pxafb_info *fbi,
 static int pxafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct pxafb_info *fbi = container_of(info, struct pxafb_info, fb);
-	struct pxafb_mach_info *inf = dev_get_platdata(fbi->dev);
+	struct pxafb_mach_info *inf = fbi->inf;
 	int err;
 
 	if (inf->fixed_modes) {
@@ -1230,7 +1230,7 @@ static unsigned int __smart_timing(unsigned time_ns, unsigned long lcd_clk)
 static void setup_smart_timing(struct pxafb_info *fbi,
 				struct fb_var_screeninfo *var)
 {
-	struct pxafb_mach_info *inf = dev_get_platdata(fbi->dev);
+	struct pxafb_mach_info *inf = fbi->inf;
 	struct pxafb_mode_info *mode = &inf->modes[0];
 	unsigned long lclk = clk_get_rate(fbi->clk);
 	unsigned t1, t2, t3, t4;
@@ -1258,14 +1258,13 @@ static void setup_smart_timing(struct pxafb_info *fbi,
 static int pxafb_smart_thread(void *arg)
 {
 	struct pxafb_info *fbi = arg;
-	struct pxafb_mach_info *inf = dev_get_platdata(fbi->dev);
+	struct pxafb_mach_info *inf = fbi->inf;
 
 	if (!inf->smart_update) {
 		pr_err("%s: not properly initialized, thread terminated\n",
 				__func__);
 		return -EINVAL;
 	}
-	inf = dev_get_platdata(fbi->dev);
 
 	pr_debug("%s(): task starting\n", __func__);
 
@@ -1788,11 +1787,11 @@ decode_mode:
 		fbi->video_mem_size = video_mem_size;
 }
 
-static struct pxafb_info *pxafb_init_fbinfo(struct device *dev)
+static struct pxafb_info *pxafb_init_fbinfo(struct device *dev,
+					    struct pxafb_mach_info *inf)
 {
 	struct pxafb_info *fbi;
 	void *addr;
-	struct pxafb_mach_info *inf = dev_get_platdata(dev);
 
 	/* Alloc the pxafb_info and pseudo_palette in one step */
 	fbi = kmalloc(sizeof(struct pxafb_info) + sizeof(u32) * 16, GFP_KERNEL);
@@ -1801,6 +1800,7 @@ static struct pxafb_info *pxafb_init_fbinfo(struct device *dev)
 
 	memset(fbi, 0, sizeof(struct pxafb_info));
 	fbi->dev = dev;
+	fbi->inf = inf;
 
 	fbi->clk = clk_get(dev, NULL);
 	if (IS_ERR(fbi->clk)) {
@@ -1852,10 +1852,9 @@ static struct pxafb_info *pxafb_init_fbinfo(struct device *dev)
 }
 
 #ifdef CONFIG_FB_PXA_PARAMETERS
-static int parse_opt_mode(struct device *dev, const char *this_opt)
+static int parse_opt_mode(struct device *dev, const char *this_opt,
+			  struct pxafb_mach_info *inf)
 {
-	struct pxafb_mach_info *inf = dev_get_platdata(dev);
-
 	const char *name = this_opt+5;
 	unsigned int namelen = strlen(name);
 	int res_specified = 0, bpp_specified = 0;
@@ -1911,9 +1910,9 @@ done:
 	return 0;
 }
 
-static int parse_opt(struct device *dev, char *this_opt)
+static int parse_opt(struct device *dev, char *this_opt,
+		     struct pxafb_mach_info *inf)
 {
-	struct pxafb_mach_info *inf = dev_get_platdata(dev);
 	struct pxafb_mode_info *mode = &inf->modes[0];
 	char s[64];
 
@@ -1922,7 +1921,7 @@ static int parse_opt(struct device *dev, char *this_opt)
 	if (!strncmp(this_opt, "vmem:", 5)) {
 		video_mem_size = memparse(this_opt + 5, NULL);
 	} else if (!strncmp(this_opt, "mode:", 5)) {
-		return parse_opt_mode(dev, this_opt);
+		return parse_opt_mode(dev, this_opt, inf);
 	} else if (!strncmp(this_opt, "pixclock:", 9)) {
 		mode->pixclock = simple_strtoul(this_opt+9, NULL, 0);
 		sprintf(s, "pixclock: %ld\n", mode->pixclock);
@@ -2011,7 +2010,8 @@ static int parse_opt(struct device *dev, char *this_opt)
 	return 0;
 }
 
-static int pxafb_parse_options(struct device *dev, char *options)
+static int pxafb_parse_options(struct device *dev, char *options,
+			       struct pxafb_mach_info *inf)
 {
 	char *this_opt;
 	int ret;
@@ -2023,7 +2023,7 @@ static int pxafb_parse_options(struct device *dev, char *options)
 
 	/* could be made table driven or similar?... */
 	while ((this_opt = strsep(&options, ",")) != NULL) {
-		ret = parse_opt(dev, this_opt);
+		ret = parse_opt(dev, this_opt, inf);
 		if (ret)
 			return ret;
 	}
@@ -2095,19 +2095,33 @@ static void pxafb_check_options(struct device *dev, struct pxafb_mach_info *inf)
 static int pxafb_probe(struct platform_device *dev)
 {
 	struct pxafb_info *fbi;
-	struct pxafb_mach_info *inf;
+	struct pxafb_mach_info *inf, *pdata;
 	struct resource *r;
-	int irq, ret;
+	int i, irq, ret;
 
 	dev_dbg(&dev->dev, "pxafb_probe\n");
 
-	inf = dev_get_platdata(&dev->dev);
 	ret = -ENOMEM;
-	fbi = NULL;
+	pdata = dev_get_platdata(&dev->dev);
+	inf = devm_kmalloc(&dev->dev, sizeof(*inf), GFP_KERNEL);
 	if (!inf)
 		goto failed;
+	if (pdata) {
+		*inf = *pdata;
+		inf->modes +			devm_kmalloc_array(&dev->dev, pdata->num_modes,
+					   sizeof(inf->modes[0]), GFP_KERNEL);
+		if (!inf->modes)
+			goto failed;
+		for (i = 0; i < inf->num_modes; i++)
+			inf->modes[i] = pdata->modes[i];
+	}
+
+	fbi = NULL;
+	if (!pdata)
+		goto failed;
 
-	ret = pxafb_parse_options(&dev->dev, g_options);
+	ret = pxafb_parse_options(&dev->dev, g_options, inf);
 	if (ret < 0)
 		goto failed;
 
@@ -2125,7 +2139,7 @@ static int pxafb_probe(struct platform_device *dev)
 		goto failed;
 	}
 
-	fbi = pxafb_init_fbinfo(&dev->dev);
+	fbi = pxafb_init_fbinfo(&dev->dev, inf);
 	if (!fbi) {
 		/* only reason for pxafb_init_fbinfo to fail is kmalloc */
 		dev_err(&dev->dev, "Failed to initialize framebuffer device\n");
diff --git a/drivers/video/fbdev/pxafb.h b/drivers/video/fbdev/pxafb.h
index 26ba9fa3f737..5dc414e26fc8 100644
--- a/drivers/video/fbdev/pxafb.h
+++ b/drivers/video/fbdev/pxafb.h
@@ -167,6 +167,8 @@ struct pxafb_info {
 
 	void (*lcd_power)(int, struct fb_var_screeninfo *);
 	void (*backlight_power)(int);
+
+	struct pxafb_mach_info	*inf;
 };
 
 #define TO_INF(ptr,member) container_of(ptr,struct pxafb_info,member)
-- 
2.1.4

