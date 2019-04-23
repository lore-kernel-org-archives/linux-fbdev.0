From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Tue, 23 Apr 2019 07:50:20 +0000
Subject: [PATCH next 25/25] video: fbdev: Use dev_get_drvdata()
Message-Id: <20190423075020.173734-26-wangkefeng.wang@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Wan ZongShun <mcuos.com@gmail.com>, Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Michal Januszewski <spock@gentoo.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

Using dev_get_drvdata directly.

Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michal Januszewski <spock@gentoo.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/video/fbdev/nuc900fb.c  |  2 +-
 drivers/video/fbdev/s3c2410fb.c |  2 +-
 drivers/video/fbdev/uvesafb.c   | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/nuc900fb.c b/drivers/video/fbdev/nuc900fb.c
index 6680edae4696..44ea5380a546 100644
--- a/drivers/video/fbdev/nuc900fb.c
+++ b/drivers/video/fbdev/nuc900fb.c
@@ -455,7 +455,7 @@ static int nuc900fb_cpufreq_transition(struct notifier_block *nb,
 	struct fb_info *fbinfo;
 	long delta_f;
 	info = container_of(nb, struct nuc900fb_info, freq_transition);
-	fbinfo = platform_get_drvdata(to_platform_device(info->dev));
+	fbinfo = dev_get_drvdata(info->dev);
 
 	delta_f = info->clk_rate - clk_get_rate(info->clk);
 
diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
index a67e4567e656..a702da89910b 100644
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -777,7 +777,7 @@ static int s3c2410fb_cpufreq_transition(struct notifier_block *nb,
 	long delta_f;
 
 	info = container_of(nb, struct s3c2410fb_info, freq_transition);
-	fbinfo = platform_get_drvdata(to_platform_device(info->dev));
+	fbinfo = dev_get_drvdata(info->dev);
 
 	/* work out change, <0 for speed-up */
 	delta_f = info->clk_rate - clk_get_rate(info->clk);
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 34dc8e53a1e9..d707fdb97354 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1543,7 +1543,7 @@ static void uvesafb_ioremap(struct fb_info *info)
 static ssize_t uvesafb_show_vbe_ver(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	return snprintf(buf, PAGE_SIZE, "%.4x\n", par->vbe_ib.vbe_version);
@@ -1554,7 +1554,7 @@ static DEVICE_ATTR(vbe_version, S_IRUGO, uvesafb_show_vbe_ver, NULL);
 static ssize_t uvesafb_show_vbe_modes(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 	int ret = 0, i;
 
@@ -1573,7 +1573,7 @@ static DEVICE_ATTR(vbe_modes, S_IRUGO, uvesafb_show_vbe_modes, NULL);
 static ssize_t uvesafb_show_vendor(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_vendor_name_ptr)
@@ -1588,7 +1588,7 @@ static DEVICE_ATTR(oem_vendor, S_IRUGO, uvesafb_show_vendor, NULL);
 static ssize_t uvesafb_show_product_name(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_product_name_ptr)
@@ -1603,7 +1603,7 @@ static DEVICE_ATTR(oem_product_name, S_IRUGO, uvesafb_show_product_name, NULL);
 static ssize_t uvesafb_show_product_rev(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_product_rev_ptr)
@@ -1618,7 +1618,7 @@ static DEVICE_ATTR(oem_product_rev, S_IRUGO, uvesafb_show_product_rev, NULL);
 static ssize_t uvesafb_show_oem_string(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	if (par->vbe_ib.oem_string_ptr)
@@ -1633,7 +1633,7 @@ static DEVICE_ATTR(oem_string, S_IRUGO, uvesafb_show_oem_string, NULL);
 static ssize_t uvesafb_show_nocrtc(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", par->nocrtc);
@@ -1642,7 +1642,7 @@ static ssize_t uvesafb_show_nocrtc(struct device *dev,
 static ssize_t uvesafb_store_nocrtc(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct fb_info *info = platform_get_drvdata(to_platform_device(dev));
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
 	if (count > 0) {
-- 
2.20.1
