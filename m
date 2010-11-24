From: Dzianis Kahanovich <mahatma@bspu.unibel.by>
Date: Wed, 24 Nov 2010 16:20:02 +0000
Subject: [PATCH v4] viafb: I2C/DDC LCD detection for VIA framebuffer
Message-Id: <4CED3B32.5000503@bspu.unibel.by>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I2C/DDC LCD detection for VIA framebuffer

Adding legacy I2C/DDC support for VIA framebuffer, used to fix LCD
panel size and (if "via_active_dev" is empty default) force LCD
detection. This solving at least defaults on Chrome9 video
on HP mini 2133 notebook, but must be good in other cases,
include double-LCD.

v2->v3 patch: original viafb_find_i2c_adapt() code is unsafe (nowere used).

v3->v4 patch: viafbinfo1 is not initilalized if !viafb_dual_fb
and may cause problems with dual separated LCD. Now dual & SAMM
code looks safe (will no generate errors).

Signed-off-by: Dzianis Kahanovich <mahatma@eu.by>
---
diff -pruN a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
--- a/drivers/video/via/via-core.c	2010-11-24 00:12:22.000000000 +0200
+++ b/drivers/video/via/via-core.c	2010-11-24 17:04:00.749999967 +0200
@@ -2,6 +2,7 @@
  * Copyright 1998-2009 VIA Technologies, Inc. All Rights Reserved.
  * Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.
  * Copyright 2009 Jonathan Corbet <corbet@lwn.net>
+ * Copyright 2010 Dzianis Kahanovich <mahatma@eu.by>
  */

 /*
@@ -16,6 +17,8 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>

+extern char *viafb_active_dev;
+
 /*
  * The default port config.
  */
@@ -575,6 +578,67 @@ static void via_teardown_subdevs(void)
 		}
 }

+static void via_i2c_detect(int stage)
+{
+	u8 *edid;
+	struct fb_var_screeninfo var;
+	int i, n = 0;
+	struct i2c_adapter *adapter;
+	struct lvds_setting_information *inf;
+
+	for (i = 0; i < VIAFB_NUM_PORTS; i++) {
+		adapter = viafb_find_i2c_adapter(i);
+		if (!adapter || !adapter->algo_data ||
+		    !(edid = fb_ddc_read(adapter)))
+			continue;
+		if (fb_parse_edid(edid, &var))
+			goto free_edid;
+		DEBUG_MSG(KERN_INFO "viafb i2c #%i EDID (%i), %ix%i:%i\n", i, stage,
var.xres, var.yres, var.bits_per_pixel);
+		if (!stage) {
+			if (n && !viafb_active_dev)
+				viafb_dual_fb = STATE_ON;
+			inf = NULL;
+		} else if (!n || !viafb_LCD_ON) {
+			fb_edid_to_monspecs(edid, &viafbinfo->monspecs);
+			inf = viaparinfo->lvds_setting_info;
+			if (!viafb_active_dev) {
+				viafb_DVI_ON +				    viaparinfo->tmds_setting_info->max_hres ?
+				    STATE_ON : STATE_OFF;
+				if (viafbinfo->monspecs.input & FB_DISP_DDI) {
+					viafb_LCD_ON = STATE_ON;
+					viafb_DeviceStatus = LCD_Device;
+					if (!n)
+						viafb_primary_dev = LCD_Device;
+				}
+			}
+		} else if (viafb_dual_fb) {
+			fb_edid_to_monspecs(edid, &viafbinfo1->monspecs);
+			inf = viaparinfo1->lvds_setting_info;
+			if (!viafb_active_dev &&
+			    (viafbinfo1->monspecs.input & FB_DISP_DDI))
+				viafb_LCD2_ON = STATE_ON;
+		} else {
+			fb_edid_to_monspecs(edid, &viafbinfo->monspecs);
+			inf = viaparinfo->lvds_setting_info2;
+			if (!viafb_active_dev &&
+			    (viafbinfo->monspecs.input & FB_DISP_DDI))
+				viafb_LCD2_ON = STATE_ON;
+		}
+		if (inf) {
+			inf->lcd_panel_hres = var.xres;
+			inf->lcd_panel_vres = var.yres;
+		}
+		n++;
+free_edid:
+		kfree(edid);
+		if (n > 1)
+			break;
+	}
+	if (stage && !viafb_active_dev)
+		viafb_set_iga_path();
+}
+

 static int __devinit via_pci_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
@@ -601,12 +665,16 @@ static int __devinit via_pci_probe(struc
 	 */
 	viafb_int_init();
 	via_setup_subdevs(&global_dev);
+	/* dual? */
+	via_i2c_detect(0);
 	/*
 	 * Set up the framebuffer device
 	 */
 	ret = via_fb_pci_probe(&global_dev);
 	if (ret)
 		goto out_subdevs;
+	/* LCD size & present */
+	via_i2c_detect(1);
 	return 0;

 out_subdevs:
diff -pruN a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
--- a/drivers/video/via/viafbdev.c	2010-11-21 11:34:11.000000000 +0200
+++ b/drivers/video/via/viafbdev.c	2010-11-24 00:14:48.070000002 +0200
@@ -43,7 +43,7 @@ static int viafb_second_size;
 static int viafb_accel = 1;

 /* Added for specifying active devices.*/
-char *viafb_active_dev;
+char *viafb_active_dev = NULL;

 /*Added for specify lcd output port*/
 char *viafb_lcd_port = "";
diff -pruN a/drivers/video/via/via_i2c.c b/drivers/video/via/via_i2c.c
--- a/drivers/video/via/via_i2c.c	2010-11-21 11:34:11.000000000 +0200
+++ b/drivers/video/via/via_i2c.c	2010-11-24 00:14:48.070000002 +0200
@@ -188,7 +188,7 @@ struct i2c_adapter *viafb_find_i2c_adapt
 {
 	struct via_i2c_stuff *stuff = &via_i2c_par[which];

-	return &stuff->adapter;
+	return stuff->is_active ? &stuff->adapter : NULL;
 }
 EXPORT_SYMBOL_GPL(viafb_find_i2c_adapter);

--

-- 
WBR, Dzianis Kahanovich AKA Denis Kaganovich, http://mahatma.bspu.unibel.by/
