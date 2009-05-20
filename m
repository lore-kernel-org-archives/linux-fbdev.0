From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 10/15] viafb: make module parameters
	visible in sysfs
Date: Thu, 21 May 2009 04:28:48 +0800
Message-ID: <1242851333-325-10-git-send-email-HaraldWelte@viatech.com>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-2-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-3-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-4-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-5-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-6-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-8-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-9-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <laforge@prithivi.openmoko.org>) id 1M6siQ-00067g-Vi
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:48:42 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6siM-00052S-6m
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:48:42 +0000
In-Reply-To: <1242851333-325-9-git-send-email-HaraldWelte@viatech.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Harald Welte <HaraldWelte@viatech.com>

From: Harald Welte <laforge@gnumonks.org>

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
---
 drivers/video/via/viafbdev.c |   45 +++++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 00f58c8..980eab8 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/stat.h>
 #define _MASTER_FILE
 
 #include "global.h"
@@ -2570,82 +2571,82 @@ module_init(viafb_init);
 module_exit(viafb_exit);
 
 #ifdef MODULE
-module_param(viafb_memsize, int, 0);
+module_param(viafb_memsize, int, S_IRUSR);
 
-module_param(viafb_mode, charp, 0);
+module_param(viafb_mode, charp, S_IRUSR);
 MODULE_PARM_DESC(viafb_mode, "Set resolution (default=640x480)");
 
-module_param(viafb_mode1, charp, 0);
+module_param(viafb_mode1, charp, S_IRUSR);
 MODULE_PARM_DESC(viafb_mode1, "Set resolution (default=640x480)");
 
-module_param(viafb_bpp, int, 0);
+module_param(viafb_bpp, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_bpp, "Set color depth (default=32bpp)");
 
-module_param(viafb_bpp1, int, 0);
+module_param(viafb_bpp1, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_bpp1, "Set color depth (default=32bpp)");
 
-module_param(viafb_refresh, int, 0);
+module_param(viafb_refresh, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_refresh,
 	"Set CRT viafb_refresh rate (default = 60)");
 
-module_param(viafb_refresh1, int, 0);
+module_param(viafb_refresh1, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_refresh1,
 	"Set CRT refresh rate (default = 60)");
 
-module_param(viafb_lcd_panel_id, int, 0);
+module_param(viafb_lcd_panel_id, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_lcd_panel_id,
 	"Set Flat Panel type(Default=1024x768)");
 
-module_param(viafb_lcd_dsp_method, int, 0);
+module_param(viafb_lcd_dsp_method, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_lcd_dsp_method,
 	"Set Flat Panel display scaling method.(Default=Expandsion)");
 
-module_param(viafb_SAMM_ON, int, 0);
+module_param(viafb_SAMM_ON, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_SAMM_ON,
 	"Turn on/off flag of SAMM(Default=OFF)");
 
-module_param(viafb_accel, int, 0);
+module_param(viafb_accel, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_accel,
 	"Set 2D Hardware Acceleration.(Default = OFF)");
 
-module_param(viafb_active_dev, charp, 0);
+module_param(viafb_active_dev, charp, S_IRUSR);
 MODULE_PARM_DESC(viafb_active_dev, "Specify active devices.");
 
-module_param(viafb_display_hardware_layout, int, 0);
+module_param(viafb_display_hardware_layout, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_display_hardware_layout,
 	"Display Hardware Layout (LCD Only, DVI Only...,etc)");
 
-module_param(viafb_second_size, int, 0);
+module_param(viafb_second_size, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_second_size,
 	"Set secondary device memory size");
 
-module_param(viafb_dual_fb, int, 0);
+module_param(viafb_dual_fb, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_dual_fb,
 	"Turn on/off flag of dual framebuffer devices.(Default = OFF)");
 
-module_param(viafb_platform_epia_dvi, int, 0);
+module_param(viafb_platform_epia_dvi, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_platform_epia_dvi,
 	"Turn on/off flag of DVI devices on EPIA board.(Default = OFF)");
 
-module_param(viafb_device_lcd_dualedge, int, 0);
+module_param(viafb_device_lcd_dualedge, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_device_lcd_dualedge,
 	"Turn on/off flag of dual edge panel.(Default = OFF)");
 
-module_param(viafb_bus_width, int, 0);
+module_param(viafb_bus_width, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_bus_width,
 	"Set bus width of panel.(Default = 12)");
 
-module_param(viafb_lcd_mode, int, 0);
+module_param(viafb_lcd_mode, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_lcd_mode,
 	"Set Flat Panel mode(Default=OPENLDI)");
 
-module_param(viafb_video_dev, charp, 0);
+module_param(viafb_video_dev, charp, S_IRUSR);
 MODULE_PARM_DESC(viafb_video_dev, "Specify video devices.");
 
-module_param(viafb_lcd_port, charp, 0);
+module_param(viafb_lcd_port, charp, S_IRUSR);
 MODULE_PARM_DESC(viafb_lcd_port, "Specify LCD output port.");
 
-module_param(viafb_dvi_port, charp, 0);
+module_param(viafb_dvi_port, charp, S_IRUSR);
 MODULE_PARM_DESC(viafb_dvi_port, "Specify DVI output port.");
 
 MODULE_LICENSE("GPL");
-- 
1.6.2.4


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
