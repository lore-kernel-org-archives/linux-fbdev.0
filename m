From: Joe Perches <joe@perches.com>
Date: Sun, 06 Jul 2014 18:01:13 +0000
Subject: Re: [PATCH] video: fbdev: omap: omapfb_main.c:  Cleaning up wrong type in format string
Message-Id: <1404669673.27043.50.camel@joe-AO725>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404668049-15016-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404668049-15016-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2014-07-06 at 19:34 +0200, Rickard Strandqvist wrote:
> Wrong type in sscanf format string, requires 'int *' but the
> argument type is 'unsigned int *'

Maybe use kstrtouint?

> diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c

> @@ -1371,7 +1371,7 @@ static ssize_t omapfb_store_bklight_level(struct device *dev,
>  	if (fbdev->panel->set_bklight_level) {
>  		unsigned int level;
>  
> -		if (sscanf(buf, "%10d", &level) = 1) {
> +		if (sscanf(buf, "%10u", &level) = 1) {
>  			r = fbdev->panel->set_bklight_level(fbdev->panel,
>  							    level);
>  		} else

Something like: (more comments below patch too)

 drivers/video/fbdev/omap/omapfb_main.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index d8d028d..96dd2f0 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1365,20 +1365,16 @@ static ssize_t omapfb_store_bklight_level(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t size)
 {
+	unsigned int level;
 	struct omapfb_device *fbdev = dev_get_drvdata(dev);
-	int r;
 
-	if (fbdev->panel->set_bklight_level) {
-		unsigned int level;
+	if (!fbdev->panel->set_bklight_level)
+		return -ENODEV;
 
-		if (sscanf(buf, "%10d", &level) = 1) {
-			r = fbdev->panel->set_bklight_level(fbdev->panel,
-							    level);
-		} else
-			r = -EINVAL;
-	} else
-		r = -ENODEV;
-	return r ? r : size;
+	if (kstrtouint(buf, 10, &level) < 0)
+		return -EINVAL;
+
+	return fbdev->panel->set_bklight_level(fbdev->panel, level) ?: size;
 }
 
 static ssize_t omapfb_show_bklight_max(struct device *dev,

---

The brightness permissions seem odd:

drivers/video/fbdev/omap/omapfb_main.c-static struct device_attribute dev_attr_panel_name drivers/video/fbdev/omap/omapfb_main.c- __ATTR(name, 0444, omapfb_show_panel_name, NULL);
drivers/video/fbdev/omap/omapfb_main.c-static DEVICE_ATTR(backlight_level, 0664,
drivers/video/fbdev/omap/omapfb_main.c:            omapfb_show_bklight_level, omapfb_store_bklight_level);
drivers/video/fbdev/omap/omapfb_main.c-static DEVICE_ATTR(backlight_max, 0444, omapfb_show_bklight_max, NULL);

Why 0644 for backlight_level when backlight_max is 0444?


