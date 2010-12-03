From: Dzianis Kahanovich <mahatma@bspu.unibel.by>
Date: Fri, 03 Dec 2010 11:32:16 +0000
Subject: [PATCH v5] viafb: I2C/DDC LCD detection for VIA framebuffer
Message-Id: <4CF8D540.5080405@bspu.unibel.by>
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
include double-LCD. Also related bugfixes.

v3 patch: original viafb_find_i2c_adapt() code is unsafe (nowere used).

v4 patch: viafbinfo1 is not initilalized if !viafb_dual_fb
and may cause problems with dual separated LCD. Now dual & SAMM
code looks safe (will no generate errors).

v5 patch: handle undefined resolution, overhead, cleanup.

Signed-off-by: Dzianis Kahanovich <mahatma@eu.by>
---
diff -pruN a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
--- a/drivers/video/via/via-core.c	2010-12-03 13:06:06.000000000 +0200
+++ b/drivers/video/via/via-core.c	2010-12-03 13:16:14.000000000 +0200
@@ -559,6 +560,69 @@ static void via_teardown_subdevs(void)
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
+		memset(&var, 0, sizeof(var));
+		if (fb_parse_edid(edid, &var))
+			goto free_edid;
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
+			if (var.xres)
+			    inf->lcd_panel_hres = var.xres;
+			if (var.yres)
+			    inf->lcd_panel_vres = var.yres;
+		}
+		n++;
+free_edid:
+		kfree(edid);
+		if (n > 1)
+			break;
+	}
+	if (stage && n && !viafb_active_dev)
+		viafb_set_iga_path();
+}
+

 static int __devinit via_pci_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
@@ -585,12 +649,16 @@ static int __devinit via_pci_probe(struc
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
diff -pruN a/drivers/video/via/viafbdev.h b/drivers/video/via/viafbdev.h
--- a/drivers/video/via/viafbdev.h	2010-08-02 01:11:14.000000000 +0300
+++ b/drivers/video/via/viafbdev.h	2010-12-03 13:13:50.000000000 +0200
@@ -88,6 +88,7 @@ extern int viafb_LCD2_ON;
 extern int viafb_LCD_ON;
 extern int viafb_DVI_ON;
 extern int viafb_hotplug;
+extern char *viafb_active_dev;

 extern int strict_strtoul(const char *cp, unsigned int base,
 	unsigned long *res);
diff -pruN a/drivers/video/via/via_i2c.c b/drivers/video/via/via_i2c.c
--- a/drivers/video/via/via_i2c.c	2010-12-03 13:06:06.000000000 +0200
+++ b/drivers/video/via/via_i2c.c	2010-12-03 13:10:26.000000000 +0200
@@ -167,7 +167,7 @@ struct i2c_adapter *viafb_find_i2c_adapt
 {
 	struct via_i2c_stuff *stuff = &via_i2c_par[which];

-	return &stuff->adapter;
+	return stuff->is_active ? &stuff->adapter : NULL;
 }
 EXPORT_SYMBOL_GPL(viafb_find_i2c_adapter);

--

