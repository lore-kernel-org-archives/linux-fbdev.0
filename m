From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 20 Nov 2019 09:57:14 +0000
Subject: [PATCH v1 3/5] fbtft: Drop useless #ifdef CONFIG_OF and dead code
Message-Id: <20191120095716.26628-3-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191120095716.26628-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191120095716.26628-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, linux-fbdev@vger.kernel.org, Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

First of all there is no need to guard GPIO request by CONFIG_OF.
It works for everybody independently on resource provider. While here,
rename the function to reflect the above.

Moreover, since we have a global dependency to OF, the rest of
conditional compilation is no-op, i.e. it's always be true.

Due to above drop useless #ifdef CONFIG_OF and therefore dead code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/fbtft-core.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 2122c4407bdb..ff8cb6670ea1 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -70,7 +70,6 @@ void fbtft_dbg_hex(const struct device *dev, int groupsize,
 }
 EXPORT_SYMBOL(fbtft_dbg_hex);
 
-#ifdef CONFIG_OF
 static int fbtft_request_one_gpio(struct fbtft_par *par,
 				  const char *name, int index,
 				  struct gpio_desc **gpiop)
@@ -92,14 +91,11 @@ static int fbtft_request_one_gpio(struct fbtft_par *par,
 	return ret;
 }
 
-static int fbtft_request_gpios_dt(struct fbtft_par *par)
+static int fbtft_request_gpios(struct fbtft_par *par)
 {
 	int i;
 	int ret;
 
-	if (!par->info->device->of_node)
-		return -EINVAL;
-
 	ret = fbtft_request_one_gpio(par, "reset", 0, &par->gpio.reset);
 	if (ret)
 		return ret;
@@ -135,7 +131,6 @@ static int fbtft_request_gpios_dt(struct fbtft_par *par)
 
 	return 0;
 }
-#endif
 
 #ifdef CONFIG_FB_BACKLIGHT
 static int fbtft_backlight_update_status(struct backlight_device *bd)
@@ -898,7 +893,6 @@ int fbtft_unregister_framebuffer(struct fb_info *fb_info)
 }
 EXPORT_SYMBOL(fbtft_unregister_framebuffer);
 
-#ifdef CONFIG_OF
 /**
  * fbtft_init_display_dt() - Device Tree init_display() function
  * @par: Driver data
@@ -977,7 +971,6 @@ static int fbtft_init_display_dt(struct fbtft_par *par)
 
 	return 0;
 }
-#endif
 
 /**
  * fbtft_init_display() - Generic init_display() function
@@ -1138,7 +1131,6 @@ static int fbtft_verify_gpios(struct fbtft_par *par)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 /* returns 0 if the property is not present */
 static u32 fbtft_of_value(struct device_node *node, const char *propname)
 {
@@ -1184,17 +1176,10 @@ static struct fbtft_platform_data *fbtft_probe_dt(struct device *dev)
 		pdata->display.backlight = 1;
 	if (of_find_property(node, "init", NULL))
 		pdata->display.fbtftops.init_display = fbtft_init_display_dt;
-	pdata->display.fbtftops.request_gpios = fbtft_request_gpios_dt;
+	pdata->display.fbtftops.request_gpios = fbtft_request_gpios;
 
 	return pdata;
 }
-#else
-static struct fbtft_platform_data *fbtft_probe_dt(struct device *dev)
-{
-	dev_err(dev, "Missing platform data\n");
-	return ERR_PTR(-EINVAL);
-}
-#endif
 
 /**
  * fbtft_probe_common() - Generic device probe() helper function
-- 
2.24.0
