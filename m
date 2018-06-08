From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Jun 2018 15:57:00 +0000
Subject: Re: [PATCH] video/omap: add module license tags
Message-Id: <7804713.l6SSBF4zTq@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180528154724epcas4p2a7e53a8a3ee382375f23328f9b8bd823@epcas4p2.samsung.com>
 <20180528154704.2568184-1-arnd@arndb.de>
In-Reply-To: <20180528154704.2568184-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

On Monday, May 28, 2018 05:46:19 PM Arnd Bergmann wrote:
> I got a bunch of warnings in a randconfig build:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_ams_delta.o
> WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_inn1510.o
> WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_palmte.o
> WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_palmtt.o
> 
> These come from an earlier patch of mine that turned all display drivers
> into separate modules. The fix is to add a MODULE_LICENSE tag. Since I'm
> doing that, adding a description and author field also makes sense. I
> went by the authors listed in the comment at the top of each file, but
> removed Imre's Nokia email address that I assume is not valid any more,
> since Imre is working at Intel these days.
> 
> Fixes: 81c44c2b2ce3 ("video/omap: fix modular build")
> Cc: Imre Deak <imre.deak@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.18 (with minor fixups, interdiff below), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


diff -u b/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
--- b/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c	2018-06-08 17:39:29.739986550 +0200
@@ -197,6 +197,7 @@
 };
 
 module_platform_driver(ams_delta_panel_driver);
+
 MODULE_AUTHOR("Jonathan McDowell <noodles@earth.li>");
 MODULE_DESCRIPTION("LCD panel support for the Amstrad E3 (Delta) videophone");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_h3.c b/drivers/video/fbdev/omap/lcd_h3.c
--- b/drivers/video/fbdev/omap/lcd_h3.c
+++ b/drivers/video/fbdev/omap/lcd_h3.c	2018-06-08 17:39:41.323986842 +0200
@@ -89,6 +89,7 @@
 };
 
 module_platform_driver(h3_panel_driver);
+
 MODULE_AUTHOR("Imre Deak");
 MODULE_DESCRIPTION("LCD panel support for the TI OMAP H3 board");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_inn1510.c b/drivers/video/fbdev/omap/lcd_inn1510.c
--- b/drivers/video/fbdev/omap/lcd_inn1510.c
+++ b/drivers/video/fbdev/omap/lcd_inn1510.c	2018-06-08 17:40:29.055988044 +0200
@@ -73,6 +73,7 @@
 };
 
 module_platform_driver(innovator1510_panel_driver);
+
 MODULE_AUTHOR("Imre Deak");
 MODULE_DESCRIPTION("LCD panel support for the TI OMAP1510 Innovator board");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_inn1610.c b/drivers/video/fbdev/omap/lcd_inn1610.c
--- b/drivers/video/fbdev/omap/lcd_inn1610.c
+++ b/drivers/video/fbdev/omap/lcd_inn1610.c	2018-06-08 17:40:40.851988341 +0200
@@ -106,6 +106,7 @@
 };
 
 module_platform_driver(innovator1610_panel_driver);
+
 MODULE_AUTHOR("Imre Deak");
 MODULE_DESCRIPTION("LCD panel support for the TI OMAP1610 Innovator board");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_osk.c b/drivers/video/fbdev/omap/lcd_osk.c
--- b/drivers/video/fbdev/omap/lcd_osk.c
+++ b/drivers/video/fbdev/omap/lcd_osk.c	2018-06-08 17:40:55.163988701 +0200
@@ -97,3 +97,3 @@
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Imre Deak");
 MODULE_DESCRIPTION("LCD panel support for the TI OMAP OSK board");
+MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_palmte.c b/drivers/video/fbdev/omap/lcd_palmte.c
--- b/drivers/video/fbdev/omap/lcd_palmte.c
+++ b/drivers/video/fbdev/omap/lcd_palmte.c	2018-06-08 17:41:13.839989172 +0200
@@ -60,5 +60,5 @@
 
 module_platform_driver(palmte_panel_driver);
-MODULE_AUTHOR("Romain Goyet <r.goyet@gmail.com>");
+MODULE_AUTHOR("Romain Goyet <r.goyet@gmail.com>, Laurent Gonzalez <palmte.linux@free.fr>");
 MODULE_DESCRIPTION("LCD panel support for the Palm Tungsten E");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_palmtt.c b/drivers/video/fbdev/omap/lcd_palmtt.c
--- b/drivers/video/fbdev/omap/lcd_palmtt.c
+++ b/drivers/video/fbdev/omap/lcd_palmtt.c	2018-06-08 17:42:30.855991111 +0200
@@ -72,6 +72,7 @@
 };
 
 module_platform_driver(palmtt_panel_driver);
+
 MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
 MODULE_DESCRIPTION("LCD panel support for Palm Tungsten|T");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_palmz71.c b/drivers/video/fbdev/omap/lcd_palmz71.c
--- b/drivers/video/fbdev/omap/lcd_palmz71.c
+++ b/drivers/video/fbdev/omap/lcd_palmz71.c	2018-06-08 17:43:16.543992262 +0200
@@ -67,5 +67,5 @@
 
 module_platform_driver(palmz71_panel_driver);
-MODULE_AUTHOR("Marek Vasut");
+MODULE_AUTHOR("Romain Goyet, Laurent Gonzalez, Marek Vasut");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("LCD panel support for the Palm Zire71");

