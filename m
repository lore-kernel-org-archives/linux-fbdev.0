From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Mar 2010 17:18:07 +0000
Subject: Fwd: [PATCH] vesafb: use platform_driver_probe() instead of
Message-Id: <10f740e81003261018n20b8af34ma946b17dc047a67b@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

---------- Forwarded message ----------
From: Jan Beulich <JBeulich@novell.com>
Date: Fri, Mar 26, 2010 at 17:48
Subject: [PATCH] vesafb: use platform_driver_probe() instead of
platform_driver_register()
To: u.kleine-koenig@pengutronix.de, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org


Commit c2e13037e6794bd0d9de3f9ecabf5615f15c160b introduced a huge
amount of section mismatch warnings in vesafb code. Rather than
converting all of the annotations, do the obvious and revert the
__init -> __devinit change, and use the recommended (in that patch)
alternative to calling platform_driver_register(): vesafb depends on
information obtained from by kernel at boot time, cannot be a module,
and no post-boot devices can ever show up.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/video/vesafb.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- linux-2.6.34-rc2/drivers/video/vesafb.c
+++ 2.6.34-rc2-vesafb-init/drivers/video/vesafb.c
@@ -226,7 +226,7 @@ static int __init vesafb_setup(char *opt
       return 0;
 }

-static int __devinit vesafb_probe(struct platform_device *dev)
+static int __init vesafb_probe(struct platform_device *dev)
 {
       struct fb_info *info;
       int i, err;
@@ -477,7 +477,6 @@ err:
 }

 static struct platform_driver vesafb_driver = {
-       .probe  = vesafb_probe,
       .driver = {
               .name   = "vesafb",
       },
@@ -493,20 +492,21 @@ static int __init vesafb_init(void)
       /* ignore error return of fb_get_options */
       fb_get_options("vesafb", &option);
       vesafb_setup(option);
-       ret = platform_driver_register(&vesafb_driver);

+       vesafb_device = platform_device_alloc("vesafb", 0);
+       if (!vesafb_device)
+               return -ENOMEM;
+
+       ret = platform_device_add(vesafb_device);
       if (!ret) {
-               vesafb_device = platform_device_alloc("vesafb", 0);
+               ret = platform_driver_probe(&vesafb_driver, vesafb_probe);
+               if (ret)
+                       platform_device_del(vesafb_device);
+       }

-               if (vesafb_device)
-                       ret = platform_device_add(vesafb_device);
-               else
-                       ret = -ENOMEM;
-
-               if (ret) {
-                       platform_device_put(vesafb_device);
-                       platform_driver_unregister(&vesafb_driver);
-               }
+       if (ret) {
+               platform_device_put(vesafb_device);
+               vesafb_device = NULL;
       }

       return ret;



--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



-- 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
